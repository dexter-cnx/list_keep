import 'package:isar/isar.dart';

import '../../domain/entities/list_record.dart';
import '../../domain/entities/record_sort_option.dart';
import '../../domain/entities/search_result.dart';
import '../../domain/repositories/list_record_repository.dart';
import '../models/app_list_model.dart';
import '../models/list_record_model.dart';

class IsarListRecordRepository implements ListRecordRepository {
  IsarListRecordRepository(this._isar);

  final Isar _isar;

  @override
  Stream<List<ListRecord>> watchRecords(
    int listId, {
    required String query,
    required bool pinnedOnly,
    required RecordSortOption sort,
  }) async* {
    yield await _loadRecords(
      listId,
      query: query,
      pinnedOnly: pinnedOnly,
      sort: sort,
    );
    yield* _isar.listRecordModels.watchLazy().asyncMap(
      (_) => _loadRecords(
        listId,
        query: query,
        pinnedOnly: pinnedOnly,
        sort: sort,
      ),
    );
  }

  @override
  Stream<List<SearchResult>> watchSearchResults(String query) async* {
    yield await _loadSearchResults(query);
    yield* _isar.listRecordModels.watchLazy().asyncMap(
      (_) => _loadSearchResults(query),
    );
  }

  @override
  Future<ListRecord?> getRecord(int recordId) async {
    final model = await _isar.listRecordModels.get(recordId);
    return model?.toDomain();
  }

  @override
  Future<int> saveRecord(ListRecord record) async {
    final model = ListRecordModel.fromDomain(record);
    return _isar.writeTxn(() => _isar.listRecordModels.put(model));
  }

  @override
  Future<void> setPinned(int recordId, bool isPinned) async {
    await _isar.writeTxn(() async {
      final model = await _isar.listRecordModels.get(recordId);
      if (model == null) return;
      model
        ..isPinned = isPinned
        ..updatedAt = DateTime.now();
      await _isar.listRecordModels.put(model);
    });
  }

  @override
  Future<void> deleteRecord(int recordId) async {
    await _isar.writeTxn(() => _isar.listRecordModels.delete(recordId));
  }

  Future<List<ListRecord>> _loadRecords(
    int listId, {
    required String query,
    required bool pinnedOnly,
    required RecordSortOption sort,
  }) async {
    final models = await _isar.listRecordModels.where().findAll();
    final normalizedQuery = query.trim().toLowerCase();

    final records = models
        .where((model) => model.listId == listId)
        .where((model) => !pinnedOnly || model.isPinned)
        .where(
          (model) =>
              normalizedQuery.isEmpty ||
              model.searchIndex.contains(normalizedQuery),
        )
        .map((model) => model.toDomain())
        .toList();

    _sort(records, sort);
    return records;
  }

  Future<List<SearchResult>> _loadSearchResults(String query) async {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) {
      return const [];
    }

    final recordModels = await _isar.listRecordModels.where().findAll();
    final listModels = await _isar.appListModels.where().findAll();
    final listsById = {
      for (final list in listModels.where((list) => !list.isArchived))
        list.id: list.toDomain(),
    };

    return recordModels
        .where((record) => record.searchIndex.contains(normalizedQuery))
        .where((record) => listsById.containsKey(record.listId))
        .map(
          (record) => SearchResult(
            list: listsById[record.listId]!,
            record: record.toDomain(),
          ),
        )
        .toList()
      ..sort((a, b) => b.record.updatedAt.compareTo(a.record.updatedAt));
  }

  void _sort(List<ListRecord> records, RecordSortOption sort) {
    switch (sort) {
      case RecordSortOption.updatedNewest:
        records.sort((a, b) {
          final pinnedCompare = (b.isPinned ? 1 : 0) - (a.isPinned ? 1 : 0);
          if (pinnedCompare != 0) return pinnedCompare;
          return b.updatedAt.compareTo(a.updatedAt);
        });
        return;
      case RecordSortOption.updatedOldest:
        records.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
        return;
      case RecordSortOption.alphabetical:
        records.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
        return;
    }
  }
}
