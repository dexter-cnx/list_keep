import 'package:isar/isar.dart';

import '../../domain/entities/list_field.dart';
import '../../domain/repositories/list_field_repository.dart';
import '../models/list_field_model.dart';

class IsarListFieldRepository implements ListFieldRepository {
  IsarListFieldRepository(this._isar);

  final Isar _isar;

  @override
  Stream<List<ListField>> watchFields(int listId) async* {
    yield await getFields(listId);
    yield* _isar.listFieldModels.watchLazy().asyncMap((_) => getFields(listId));
  }

  @override
  Future<List<ListField>> getFields(int listId) async {
    final models = await _isar.listFieldModels.where().findAll();
    return models
        .where((model) => model.listId == listId)
        .map((model) => model.toDomain())
        .toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  }

  @override
  Future<int> saveField(ListField field) async {
    final model = ListFieldModel.fromDomain(field);
    return _isar.writeTxn(() => _isar.listFieldModels.put(model));
  }

  @override
  Future<void> deleteField(int fieldId) async {
    await _isar.writeTxn(() => _isar.listFieldModels.delete(fieldId));
  }

  @override
  Future<void> reorderFields(int listId, List<int> orderedFieldIds) async {
    await _isar.writeTxn(() async {
      for (var index = 0; index < orderedFieldIds.length; index++) {
        final model = await _isar.listFieldModels.get(orderedFieldIds[index]);
        if (model == null || model.listId != listId) continue;
        model.sortOrder = index;
        await _isar.listFieldModels.put(model);
      }
    });
  }
}
