import 'dart:convert';

import 'package:isar/isar.dart';

import '../../domain/entities/field_type.dart';
import '../../domain/entities/list_field.dart';

part 'list_field_model.g.dart';

@collection
class ListFieldModel {
  Id id = Isar.autoIncrement;

  @Index()
  late int listId;

  late String name;
  late String typeKey;
  late int sortOrder;
  bool isRequired = false;
  String optionsJson = '[]';

  ListField toDomain() {
    return ListField(
      id: id,
      listId: listId,
      name: name,
      type: FieldType.fromKey(typeKey),
      sortOrder: sortOrder,
      isRequired: isRequired,
      options: (jsonDecode(optionsJson) as List<dynamic>).cast<String>(),
    );
  }

  static ListFieldModel fromDomain(ListField field) {
    return ListFieldModel()
      ..id = field.id ?? Isar.autoIncrement
      ..listId = field.listId
      ..name = field.name
      ..typeKey = field.type.key
      ..sortOrder = field.sortOrder
      ..isRequired = field.isRequired
      ..optionsJson = jsonEncode(field.options);
  }
}
