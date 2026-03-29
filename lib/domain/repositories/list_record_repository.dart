import '../entities/list_record.dart';
import '../entities/record_sort_option.dart';
import '../entities/search_result.dart';

abstract class ListRecordRepository {
  Stream<List<ListRecord>> watchRecords(
    int listId, {
    required String query,
    required bool pinnedOnly,
    required RecordSortOption sort,
  });

  Stream<List<SearchResult>> watchSearchResults(String query);
  Future<ListRecord?> getRecord(int recordId);
  Future<int> saveRecord(ListRecord record);
  Future<void> setPinned(int recordId, bool isPinned);
  Future<void> deleteRecord(int recordId);
}
