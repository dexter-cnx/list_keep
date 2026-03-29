import 'package:isar/isar.dart';

import '../../domain/entities/app_list.dart';

part 'app_list_model.g.dart';

@collection
class AppListModel {
  Id id = Isar.autoIncrement;

  @Index()
  late bool isArchived;

  late String name;
  String description = '';
  String iconKey = 'checklist';
  int colorValue = 0xFF0A7E8C;
  late DateTime createdAt;
  late DateTime updatedAt;

  AppList toDomain() {
    return AppList(
      id: id,
      name: name,
      description: description,
      iconKey: iconKey,
      colorValue: colorValue,
      isArchived: isArchived,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static AppListModel fromDomain(AppList list) {
    return AppListModel()
      ..id = list.id ?? Isar.autoIncrement
      ..name = list.name
      ..description = list.description
      ..iconKey = list.iconKey
      ..colorValue = list.colorValue
      ..isArchived = list.isArchived
      ..createdAt = list.createdAt
      ..updatedAt = list.updatedAt;
  }
}
