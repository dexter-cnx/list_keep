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
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text('settings.title'.tr())),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          AppSectionCard(
            accentColor: colors.secondary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'settings.title'.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Offline-first, on-device, and ready to adapt to your preferred language.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
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
                      final selected = settings.localeCode == code;
                      return ChoiceChip(
                        label: Text(AppLocalization.localeNames[code] ?? code),
                        selected: selected,
                        onSelected: (value) async {
                          if (!value) return;
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
            accentColor: colors.tertiary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'List Keep',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Smart lists for structured personal records, built to stay local, fast, and easy to extend.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.45,
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
