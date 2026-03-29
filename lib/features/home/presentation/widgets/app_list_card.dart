import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/app_list.dart';

class AppListCard extends StatelessWidget {
  const AppListCard({
    super.key,
    required this.list,
    required this.onTap,
    required this.onEdit,
    required this.onArchiveToggle,
    required this.onDelete,
  });

  final AppList list;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onArchiveToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final color = Color(list.colorValue);
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: color.withValues(alpha: 0.14),
                child: Icon(_iconForKey(list.iconKey), color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      list.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      list.description.isEmpty
                          ? 'home.list_card_fallback'.tr()
                          : list.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    onEdit();
                  } else if (value == 'archive') {
                    onArchiveToggle();
                  } else if (value == 'delete') {
                    onDelete();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(value: 'edit', child: Text('common.edit'.tr())),
                  PopupMenuItem(
                    value: 'archive',
                    child: Text(
                      list.isArchived
                          ? 'common.unarchive'.tr()
                          : 'common.archive'.tr(),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('common.delete'.tr()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

IconData _iconForKey(String iconKey) {
  switch (iconKey) {
    case 'payments':
      return Icons.payments_outlined;
    case 'inventory_2':
      return Icons.inventory_2_outlined;
    case 'task_alt':
      return Icons.task_alt;
    case 'collections_bookmark':
      return Icons.collections_bookmark_outlined;
    case 'verified_user':
      return Icons.verified_user_outlined;
    case 'build_circle':
      return Icons.build_circle_outlined;
    case 'favorite':
      return Icons.favorite_outline;
    default:
      return Icons.checklist_rounded;
  }
}
