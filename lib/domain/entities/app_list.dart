class AppList {
  const AppList({
    this.id,
    required this.name,
    required this.description,
    required this.iconKey,
    required this.colorValue,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String name;
  final String description;
  final String iconKey;
  final int colorValue;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;

  AppList copyWith({
    int? id,
    String? name,
    String? description,
    String? iconKey,
    int? colorValue,
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppList(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconKey: iconKey ?? this.iconKey,
      colorValue: colorValue ?? this.colorValue,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
