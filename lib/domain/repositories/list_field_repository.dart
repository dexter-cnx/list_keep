import '../entities/list_field.dart';

abstract class ListFieldRepository {
  Stream<List<ListField>> watchFields(int listId);
  Future<List<ListField>> getFields(int listId);
  Future<int> saveField(ListField field);
  Future<void> deleteField(int fieldId);
  Future<void> reorderFields(int listId, List<int> orderedFieldIds);
}
