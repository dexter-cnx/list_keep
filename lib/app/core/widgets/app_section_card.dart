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

    return Card(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: accent.withValues(alpha: 0.22),
              width: 1.1,
            ),
          ),
        ),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
