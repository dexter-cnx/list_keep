import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';
import 'theme/app_theme.dart';

class ListKeepApp extends ConsumerWidget {
  const ListKeepApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'List Keep',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      builder: (context, child) {
        final scheme = Theme.of(context).colorScheme;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark
                  ? [
                      const Color(0xFF0D1117),
                      const Color(0xFF05070B),
                      scheme.surface,
                    ]
                  : [
                      const Color(0xFFFCF9F4),
                      const Color(0xFFFBF6EF),
                      const Color(0xFFF6EFE4),
                    ],
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: IgnorePointer(
                  child: _AmbientOrbs(scheme: scheme, isDark: isDark),
                ),
              ),
              child ?? const SizedBox.shrink(),
            ],
          ),
        );
      },
      routerConfig: router,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}

class _AmbientOrbs extends StatelessWidget {
  const _AmbientOrbs({required this.scheme, required this.isDark});

  final ColorScheme scheme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: -48,
          top: 80,
          child: _Orb(
            size: isDark ? 220 : 180,
            color: isDark
                ? scheme.primary.withValues(alpha: 0.10)
                : scheme.primary.withValues(alpha: 0.08),
          ),
        ),
        Positioned(
          left: -56,
          top: 220,
          child: _Orb(
            size: isDark ? 180 : 150,
            color: isDark
                ? scheme.secondary.withValues(alpha: 0.10)
                : scheme.tertiary.withValues(alpha: 0.08),
          ),
        ),
        Positioned(
          right: 32,
          bottom: -40,
          child: _Orb(
            size: isDark ? 240 : 200,
            color: isDark
                ? scheme.primary.withValues(alpha: 0.06)
                : scheme.secondaryContainer.withValues(alpha: 0.55),
          ),
        ),
      ],
    );
  }
}

class _Orb extends StatelessWidget {
  const _Orb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
