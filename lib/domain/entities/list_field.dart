import 'field_type.dart';

class ListField {
  const ListField({
    this.id,
    required this.listId,
    required this.name,
    required this.type,
    required this.sortOrder,
    required this.isRequired,
    required this.options,
  });

  final int? id;
  final int listId;
  final String name;
  final FieldType type;
  final int sortOrder;
  final bool isRequired;
  final List<String> options;

  ListField copyWith({
    int? id,
    int? listId,
    String? name,
    FieldType? type,
    int? sortOrder,
    bool? isRequired,
    List<String>? options,
  }) {
    return ListField(
      id: id ?? this.id,
      listId: listId ?? this.listId,
      name: name ?? this.name,
      type: type ?? this.type,
      sortOrder: sortOrder ?? this.sortOrder,
      isRequired: isRequired ?? this.isRequired,
      options: options ?? this.options,
    );
  }
}
