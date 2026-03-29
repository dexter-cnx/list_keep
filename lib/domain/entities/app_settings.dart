class AppSettings {
  const AppSettings({required this.localeCode});

  final String localeCode;

  AppSettings copyWith({String? localeCode}) {
    return AppSettings(localeCode: localeCode ?? this.localeCode);
  }
}
