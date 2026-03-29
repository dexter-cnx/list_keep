import 'package:isar/isar.dart';

import '../../domain/entities/app_settings.dart';

part 'app_settings_model.g.dart';

@collection
class AppSettingsModel {
  static const int singletonId = 1;

  Id id = singletonId;
  String localeCode = 'en';

  AppSettings toDomain() {
    return AppSettings(localeCode: localeCode);
  }
}
