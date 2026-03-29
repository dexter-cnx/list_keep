import 'package:isar/isar.dart';

import '../../domain/entities/app_list.dart';
import '../../domain/repositories/app_list_repository.dart';
import '../models/app_list_model.dart';
import '../models/list_field_model.dart';
import '../models/list_record_model.dart';

class IsarAppListRepository implements AppListRepository {
  IsarAppListRepository(this._isar);

  final Isar _isar;

  @override
  Stream<List<AppList>> watchLists({required bool includeArchived}) async* {
    yield await _loadLists(includeArchived: includeArchived);
    yield* _isar.appListModels.watchLazy().asyncMap(
      (_) => _loadLists(includeArchived: includeArchived),
    );
  }

  @override
  Future<AppList?> getList(int listId) async {
    final model = await _isar.appListModels.get(listId);
    return model?.toDomain();
  }

  @override
  Future<int> saveList(AppList list) async {
    final model = AppListModel.fromDomain(list);
    return _isar.writeTxn(() => _isar.appListModels.put(model));
  }

  @override
  Future<void> archiveList(int listId, bool archived) async {
    await _isar.writeTxn(() async {
      final model = await _isar.appListModels.get(listId);
      if (model == null) return;
      model
        ..isArchived = archived
        ..updatedAt = DateTime.now();
      await _isar.appListModels.put(model);
    });
  }

  @override
  Future<void> deleteList(int listId) async {
    await _isar.writeTxn(() async {
      final fieldIds = (await _isar.listFieldModels.where().findAll())
          .where((field) => field.listId == listId)
          .map((field) => field.id)
          .toList();
      final recordIds = (await _isar.listRecordModels.where().findAll())
          .where((record) => record.listId == listId)
          .map((record) => record.id)
          .toList();

      await _isar.listFieldModels.deleteAll(fieldIds);
      await _isar.listRecordModels.deleteAll(recordIds);
      await _isar.appListModels.delete(listId);
    });
  }

  Future<List<AppList>> _loadLists({required bool includeArchived}) async {
    final models = await _isar.appListModels.where().findAll();
    return models
        .where(
          (model) => includeArchived ? model.isArchived : !model.isArchived,
        )
        .map((model) => model.toDomain())
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }
}
