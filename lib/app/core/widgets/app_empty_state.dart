import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.icon,
    required this.titleKey,
    required this.descriptionKey,
    this.actionLabelKey,
    this.onAction,
  });

  final IconData icon;
  final String titleKey;
  final String descriptionKey;
  final String? actionLabelKey;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark
                ? colors.surfaceContainerLowest.withValues(alpha: 0.9)
                : colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.12)
                  : colors.outlineVariant.withValues(alpha: 0.55),
            ),
            boxShadow: isDark
                ? []
                : [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.04),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -24,
                top: -28,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.primary.withValues(
                      alpha: isDark ? 0.08 : 0.05,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: colors.secondaryContainer.withValues(
                        alpha: isDark ? 0.32 : 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      icon,
                      color: colors.onSecondaryContainer,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    titleKey.tr(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    descriptionKey.tr(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                      height: 1.45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (actionLabelKey != null && onAction != null) ...[
                    const SizedBox(height: 18),
                    FilledButton.icon(
                      onPressed: onAction,
                      icon: const Icon(Icons.add),
                      label: Text(actionLabelKey!.tr()),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
