import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/core/widgets/app_section_card.dart';
import '../../../../app/providers.dart';

class TemplatePickerPage extends ConsumerWidget {
  const TemplatePickerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templates = ref.watch(templatesProvider);

    return Scaffold(
      appBar: AppBar(title: Text('templates.title'.tr())),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: templates.length,
        separatorBuilder: (_, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final template = templates[index];
          return AppSectionCard(
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => context.pop(template.id),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(
                      template.colorValue,
                    ).withValues(alpha: 0.15),
                    child: Icon(
                      Icons.auto_awesome,
                      color: Color(template.colorValue),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          template.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          template.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: template.fields
                              .map((field) => Chip(label: Text(field.name)))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
