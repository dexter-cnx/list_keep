enum FieldType {
  text,
  multilineText,
  number,
  currency,
  checkbox,
  date,
  dateTime,
  singleSelect,
  multiSelect,
  rating,
  url,
  phone,
  email;

  String get key => name;

  bool get usesOptions =>
      this == FieldType.singleSelect || this == FieldType.multiSelect;

  static FieldType fromKey(String key) {
    return FieldType.values.firstWhere(
      (type) => type.key == key,
      orElse: () => FieldType.text,
    );
  }
}
