import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final csvFile = File('assets/i18n/translations.csv');
  if (!await csvFile.exists()) {
    stderr.writeln('Missing assets/i18n/translations.csv');
    exitCode = 1;
    return;
  }

  final lines = await csvFile.readAsLines();
  final rows = lines
      .where((line) => line.trim().isNotEmpty)
      .map(_parseCsvLine)
      .toList();

  if (rows.length < 2) {
    stderr.writeln(
      'translations.csv must contain a header and at least one row.',
    );
    exitCode = 1;
    return;
  }

  final header = rows.first.map((cell) => cell.trim()).toList();
  if (header.length < 3 || header.first != 'key') {
    stderr.writeln('Header must start with "key" and contain locale columns.');
    exitCode = 1;
    return;
  }

  final locales = header.sublist(1);
  final localeMaps = <String, Map<String, Object?>>{
    for (final locale in locales) locale: <String, Object?>{},
  };

  for (var rowIndex = 1; rowIndex < rows.length; rowIndex++) {
    final row = rows[rowIndex];
    final key = row.first.trim();
    if (key.isEmpty) {
      stderr.writeln('Row ${rowIndex + 1} is missing a translation key.');
      exitCode = 1;
      return;
    }

    for (var localeIndex = 0; localeIndex < locales.length; localeIndex++) {
      final value = localeIndex + 1 < row.length ? row[localeIndex + 1] : '';
      _writeNestedValue(localeMaps[locales[localeIndex]]!, key, value);
    }
  }

  final outputDir = Directory('assets/i18n/generated');
  await outputDir.create(recursive: true);

  for (final entry in localeMaps.entries) {
    final file = File('${outputDir.path}/${entry.key}.json');
    const encoder = JsonEncoder.withIndent('  ');
    await file.writeAsString('${encoder.convert(entry.value)}\n');
  }

  stdout.writeln(
    'Generated ${locales.length} locale files in ${outputDir.path}',
  );
}

List<String> _parseCsvLine(String line) {
  final cells = <String>[];
  final buffer = StringBuffer();
  var inQuotes = false;

  for (var index = 0; index < line.length; index++) {
    final char = line[index];
    if (char == '"') {
      final escapedQuote = index + 1 < line.length && line[index + 1] == '"';
      if (escapedQuote) {
        buffer.write('"');
        index++;
      } else {
        inQuotes = !inQuotes;
      }
      continue;
    }

    if (char == ',' && !inQuotes) {
      cells.add(buffer.toString());
      buffer.clear();
      continue;
    }

    buffer.write(char);
  }

  cells.add(buffer.toString());
  return cells;
}

void _writeNestedValue(
  Map<String, Object?> root,
  String dottedKey,
  String value,
) {
  final segments = dottedKey.split('.');
  Map<String, Object?> current = root;

  for (var index = 0; index < segments.length; index++) {
    final segment = segments[index].trim();
    if (segment.isEmpty) {
      throw FormatException('Invalid key: $dottedKey');
    }

    final isLeaf = index == segments.length - 1;
    if (isLeaf) {
      current[segment] = value;
      return;
    }

    final next = current.putIfAbsent(segment, () => <String, Object?>{});
    if (next is! Map<String, Object?>) {
      throw FormatException('Key collision while writing $dottedKey');
    }
    current = next;
  }
}
