import 'dart:convert';

import 'package:isar/isar.dart';

import '../../domain/entities/list_record.dart';
import '../../domain/entities/record_value.dart';

part 'list_record_model.g.dart';

@collection
class ListRecordModel {
  Id id = Isar.autoIncrement;

  @Index()
  late int listId;

  @Index(caseSensitive: false)
  late String searchIndex;

  @Index()
  late bool isPinned;

  late String title;
  String valuesJson = '{}';
  late DateTime createdAt;
  late DateTime updatedAt;

  ListRecord toDomain() {
    final map = jsonDecode(valuesJson) as Map<String, dynamic>;

    return ListRecord(
      id: id,
      listId: listId,
      title: title,
      isPinned: isPinned,
      values: map.entries
          .map(
            (entry) =>
                RecordValue(fieldId: int.parse(entry.key), value: entry.value),
          )
          .toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static ListRecordModel fromDomain(ListRecord record) {
    return ListRecordModel()
      ..id = record.id ?? Isar.autoIncrement
      ..listId = record.listId
      ..title = record.title
      ..isPinned = record.isPinned
      ..valuesJson = jsonEncode({
        for (final value in record.values)
          value.fieldId.toString(): value.value,
      })
      ..searchIndex = _buildSearchIndex(record)
      ..createdAt = record.createdAt
      ..updatedAt = record.updatedAt;
  }

  static String _buildSearchIndex(ListRecord record) {
    final values = record.values.map((value) => '${value.value ?? ''}');
    return [record.title, ...values].join(' ').toLowerCase();
  }
}
