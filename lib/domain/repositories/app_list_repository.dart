import '../entities/app_list.dart';

abstract class AppListRepository {
  Stream<List<AppList>> watchLists({required bool includeArchived});
  Future<AppList?> getList(int listId);
  Future<int> saveList(AppList list);
  Future<void> archiveList(int listId, bool archived);
  Future<void> deleteList(int listId);
}
