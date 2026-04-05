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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final description = list.description.isEmpty
        ? 'home.list_card_fallback'.tr()
        : list.description;

    return Material(
      color: colors.surfaceContainerLowest.withValues(alpha: isDark ? 0.9 : 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: color.withValues(alpha: isDark ? 0.22 : 0.12)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: isDark ? 0.16 : 0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(_iconForKey(list.iconKey), color: color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            list.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        if (list.isArchived)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: _Badge(
                              label: 'common.archive'.tr(),
                              color: colors.surfaceContainerHigh,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _MetaPill(
                          icon: Icons.auto_awesome_outlined,
                          label: 'home.your_lists'.tr(),
                        ),
                        if (list.isArchived)
                          _MetaPill(
                            icon: Icons.archive_outlined,
                            label: 'common.unarchive'.tr(),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
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

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  const _MetaPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colors.onSurfaceVariant),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
