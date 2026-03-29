class RecordValue {
  const RecordValue({required this.fieldId, required this.value});

  final int fieldId;
  final Object? value;

  RecordValue copyWith({int? fieldId, Object? value}) {
    return RecordValue(
      fieldId: fieldId ?? this.fieldId,
      value: value ?? this.value,
    );
  }
}
