import 'package:flutter/material.dart';

class AppSectionCard extends StatelessWidget {
  const AppSectionCard({
    super.key,
    this.padding = const EdgeInsets.all(20),
    required this.child,
  });

  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(padding: padding, child: child),
    );
  }
}
