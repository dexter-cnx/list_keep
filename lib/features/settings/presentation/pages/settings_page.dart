import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/core/extensions/build_context_x.dart';
import '../../../../app/core/widgets/app_section_card.dart';
import '../../../../app/l10n/localization.dart';
import '../../../../app/providers.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('settings.title'.tr())),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppSectionCard(
            child: settingsAsync.when(
              data: (settings) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'settings.language'.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: AppLocalization.supportedLocales.map((locale) {
                      final code = locale.languageCode;
                      return ChoiceChip(
                        label: Text(AppLocalization.localeNames[code] ?? code),
                        selected: settings.localeCode == code,
                        onSelected: (selected) async {
                          if (!selected) return;
                          await ref
                              .read(settingsRepositoryProvider)
                              .saveLocale(code);
                          if (!context.mounted) return;
                          await context.setLocale(Locale(code));
                          if (!context.mounted) return;
                          context.showSnack('settings.saved'.tr());
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Text('$error'),
            ),
          ),
          const SizedBox(height: 16),
          AppSectionCard(
            accentColor: Theme.of(context).colorScheme.secondary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'List Keep',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Offline-first smart lists for structured personal records. The scaffold is ready for templates, search, filters, and later extensions.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
