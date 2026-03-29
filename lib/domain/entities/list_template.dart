import 'field_type.dart';

class ListTemplate {
  const ListTemplate({
    required this.id,
    required this.name,
    required this.description,
    required this.iconKey,
    required this.colorValue,
    required this.fields,
  });

  final String id;
  final String name;
  final String description;
  final String iconKey;
  final int colorValue;
  final List<TemplateField> fields;
}

class TemplateField {
  const TemplateField({
    required this.name,
    required this.type,
    this.isRequired = false,
    this.options = const [],
  });

  final String name;
  final FieldType type;
  final bool isRequired;
  final List<String> options;
}
