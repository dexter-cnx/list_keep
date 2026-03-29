import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers.dart';
import '../../../../domain/entities/app_list.dart';
import '../../../../domain/entities/field_type.dart';
import '../../../../domain/entities/list_field.dart';
import '../../../../domain/entities/list_record.dart';
import '../../../../domain/entities/list_template.dart';
import '../../../../domain/entities/record_value.dart';

final listActionsProvider = Provider<ListActions>((ref) {
  return ListActions(ref);
});

class ListActions {
  ListActions(this._ref);

  final Ref _ref;

  Future<int> saveList({
    int? listId,
    required String name,
    required String description,
    required String iconKey,
    required int colorValue,
    ListTemplate? template,
  }) async {
    final now = DateTime.now();
    final appListRepository = _ref.read(appListRepositoryProvider);
    final fieldRepository = _ref.read(listFieldRepositoryProvider);

    final existing = listId != null
        ? await appListRepository.getList(listId)
        : null;
    final id = await appListRepository.saveList(
      AppList(
        id: listId,
        name: name.trim(),
        description: description.trim(),
        iconKey: iconKey,
        colorValue: colorValue,
        isArchived: existing?.isArchived ?? false,
        createdAt: existing?.createdAt ?? now,
        updatedAt: now,
      ),
    );

    if (existing == null) {
      if (template != null) {
        for (var index = 0; index < template.fields.length; index++) {
          final field = template.fields[index];
          await fieldRepository.saveField(
            ListField(
              listId: id,
              name: field.name,
              type: field.type,
              sortOrder: index,
              isRequired: field.isRequired,
              options: field.options,
            ),
          );
        }
      } else {
        await fieldRepository.saveField(
          ListField(
            listId: id,
            name: 'Title',
            type: FieldType.text,
            sortOrder: 0,
            isRequired: true,
            options: const [],
          ),
        );
      }
    }

    return id;
  }

  Future<void> archiveList(int listId, bool archived) {
    return _ref.read(appListRepositoryProvider).archiveList(listId, archived);
  }

  Future<void> deleteList(int listId) {
    return _ref.read(appListRepositoryProvider).deleteList(listId);
  }

  Future<void> saveField(ListField field) {
    return _ref.read(listFieldRepositoryProvider).saveField(field);
  }

  Future<void> deleteField(int fieldId) {
    return _ref.read(listFieldRepositoryProvider).deleteField(fieldId);
  }

  Future<void> reorderFields(int listId, List<int> orderedFieldIds) {
    return _ref
        .read(listFieldRepositoryProvider)
        .reorderFields(listId, orderedFieldIds);
  }

  Future<int> saveRecord(ListRecord record) {
    return _ref.read(listRecordRepositoryProvider).saveRecord(record);
  }

  Future<void> deleteRecord(int recordId) {
    return _ref.read(listRecordRepositoryProvider).deleteRecord(recordId);
  }

  Future<void> setRecordPinned(int recordId, bool pinned) {
    return _ref.read(listRecordRepositoryProvider).setPinned(recordId, pinned);
  }

  ListRecord buildRecord({
    int? recordId,
    required int listId,
    required List<RecordValue> values,
    required bool isPinned,
    DateTime? createdAt,
  }) {
    final now = DateTime.now();
    final title = _deriveRecordTitle(values);

    return ListRecord(
      id: recordId,
      listId: listId,
      title: title,
      isPinned: isPinned,
      values: values,
      createdAt: createdAt ?? now,
      updatedAt: now,
    );
  }

  String _deriveRecordTitle(List<RecordValue> values) {
    for (final value in values) {
      final content = '${value.value ?? ''}'.trim();
      if (content.isNotEmpty && content != 'false' && content != '[]') {
        return content;
      }
    }
    return 'Untitled record';
  }
}
