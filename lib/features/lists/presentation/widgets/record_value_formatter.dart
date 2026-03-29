import 'package:intl/intl.dart';

import '../../../../domain/entities/field_type.dart';

String formatRecordValue(FieldType type, Object? value) {
  if (value == null) return '';

  switch (type) {
    case FieldType.checkbox:
      return value == true ? 'Yes' : 'No';
    case FieldType.currency:
      final number = value is num ? value : num.tryParse('$value');
      if (number == null) return '$value';
      return NumberFormat.currency(symbol: '\$').format(number);
    case FieldType.number:
      return '$value';
    case FieldType.date:
      final date = DateTime.tryParse('$value');
      return date == null ? '$value' : DateFormat.yMMMd().format(date);
    case FieldType.dateTime:
      final date = DateTime.tryParse('$value');
      return date == null ? '$value' : DateFormat.yMMMd().add_jm().format(date);
    case FieldType.multiSelect:
      if (value is List) return value.join(', ');
      return '$value';
    case FieldType.rating:
      return '$value/5';
    default:
      return '$value';
  }
}
