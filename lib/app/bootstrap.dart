import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../data/models/app_list_model.dart';
import '../data/models/app_settings_model.dart';
import '../data/models/list_field_model.dart';
import '../data/models/list_record_model.dart';

class BootstrapData {
  const BootstrapData({required this.isar, required this.startLocale});

  final Isar isar;
  final Locale startLocale;
}

Future<BootstrapData> bootstrap() async {
  final directory = await getApplicationSupportDirectory();
  final isar = await Isar.open(
    [
      AppListModelSchema,
      ListFieldModelSchema,
      ListRecordModelSchema,
      AppSettingsModelSchema,
    ],
    directory: directory.path,
    name: 'list_keep',
  );

  final settings = await isar.appSettingsModels.get(
    AppSettingsModel.singletonId,
  );
  final startLocale = settings?.localeCode.isNotEmpty == true
      ? Locale(settings!.localeCode)
      : const Locale('en');

  return BootstrapData(isar: isar, startLocale: startLocale);
}
