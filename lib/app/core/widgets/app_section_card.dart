import 'package:flutter/material.dart';

class AppSectionCard extends StatelessWidget {
  const AppSectionCard({
    super.key,
    this.padding = const EdgeInsets.all(20),
    this.accentColor,
    required this.child,
  });

  final EdgeInsets padding;
  final Color? accentColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final accent = accentColor ?? colors.primary;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark
        ? colors.surfaceContainerLowest.withValues(alpha: 0.9)
        : colors.surfaceContainerLowest;

    return Card(
      color: surface,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border(
            top: BorderSide(
              color: accent.withValues(alpha: isDark ? 0.42 : 0.22),
              width: 1.2,
            ),
          ),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: colors.primary.withValues(alpha: 0.05),
                    blurRadius: 22,
                    offset: const Offset(0, 10),
                  ),
                ],
        ),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
