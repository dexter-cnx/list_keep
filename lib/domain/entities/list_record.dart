import 'record_value.dart';

class ListRecord {
  const ListRecord({
    this.id,
    required this.listId,
    required this.title,
    required this.isPinned,
    required this.values,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int listId;
  final String title;
  final bool isPinned;
  final List<RecordValue> values;
  final DateTime createdAt;
  final DateTime updatedAt;

  ListRecord copyWith({
    int? id,
    int? listId,
    String? title,
    bool? isPinned,
    List<RecordValue>? values,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ListRecord(
      id: id ?? this.id,
      listId: listId ?? this.listId,
      title: title ?? this.title,
      isPinned: isPinned ?? this.isPinned,
      values: values ?? this.values,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
