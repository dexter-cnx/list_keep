import 'package:isar/isar.dart';

import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../models/app_settings_model.dart';

class IsarSettingsRepository implements SettingsRepository {
  IsarSettingsRepository(this._isar);

  final Isar _isar;

  @override
  Stream<AppSettings> watchSettings() async* {
    yield await getSettings();
    yield* _isar.appSettingsModels.watchLazy().asyncMap((_) => getSettings());
  }

  @override
  Future<AppSettings> getSettings() async {
    final model = await _isar.appSettingsModels.get(
      AppSettingsModel.singletonId,
    );
    return model?.toDomain() ?? const AppSettings(localeCode: 'en');
  }

  @override
  Future<void> saveLocale(String localeCode) async {
    await _isar.writeTxn(() async {
      final current =
          await _isar.appSettingsModels.get(AppSettingsModel.singletonId) ??
          AppSettingsModel();
      current.localeCode = localeCode;
      await _isar.appSettingsModels.put(current);
    });
  }
}
