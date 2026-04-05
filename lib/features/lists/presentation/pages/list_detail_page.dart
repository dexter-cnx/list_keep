import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/core/extensions/build_context_x.dart';
import '../../../../app/core/widgets/app_empty_state.dart';
import '../../../../app/core/widgets/app_section_card.dart';
import '../../../../app/providers.dart';
import '../../../../app/router/app_router.dart';
import '../../../../domain/entities/app_list.dart';
import '../../../../domain/entities/list_field.dart';
import '../../../../domain/entities/list_record.dart';
import '../../../../domain/entities/record_sort_option.dart';
import '../providers/list_actions.dart';
import '../widgets/record_value_formatter.dart';

class ListDetailPage extends ConsumerWidget {
  const ListDetailPage({super.key, required this.listId});

  final int listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(appListProvider(listId));
    final fieldsAsync = ref.watch(listFieldsProvider(listId));
    final recordsAsync = ref.watch(listRecordsProvider(listId));
    final sort = ref.watch(recordSortProvider(listId));
    final pinnedOnly = ref.watch(pinnedOnlyProvider(listId));

    return Scaffold(
      appBar: AppBar(
        title: listAsync.when(
          data: (list) => Text(list?.name ?? 'list_detail.title'.tr()),
          loading: () => Text('list_detail.title'.tr()),
          error: (error, stackTrace) => Text('list_detail.title'.tr()),
        ),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(
              AppRoute.manageFields.name,
              pathParameters: {'listId': '$listId'},
            ),
            icon: const Icon(Icons.view_sidebar_outlined),
            tooltip: 'fields.title'.tr(),
          ),
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'edit') {
                context.pushNamed(
                  AppRoute.editList.name,
                  pathParameters: {'listId': '$listId'},
                );
              } else if (value == 'archive') {
                await ref.read(listActionsProvider).archiveList(listId, true);
                if (context.mounted) {
                  context.goNamed(AppRoute.home.name);
                }
              } else if (value == 'delete') {
                await ref.read(listActionsProvider).deleteList(listId);
                if (context.mounted) {
                  context.goNamed(AppRoute.home.name);
                }
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'edit', child: Text('common.edit'.tr())),
              PopupMenuItem(
                value: 'archive',
                child: Text('common.archive'.tr()),
              ),
              PopupMenuItem(value: 'delete', child: Text('common.delete'.tr())),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(
          AppRoute.createRecord.name,
          pathParameters: {'listId': '$listId'},
        ),
        icon: const Icon(Icons.note_add_outlined),
        label: Text('records.add'.tr()),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        switchInCurve: Curves.easeOutQuart,
        switchOutCurve: Curves.easeIn,
        child: listAsync.when(
          data: (list) {
            if (list == null) {
              return Center(
                key: const ValueKey('list-not-found'),
                child: Text('list_detail.not_found'.tr()),
              );
            }

            final listColor = Color(list.colorValue);
            final records = recordsAsync.valueOrNull ?? const <ListRecord>[];
            final fields = fieldsAsync.valueOrNull ?? const <ListField>[];
            final pinnedCount = records
                .where((record) => record.isPinned)
                .length;
            final visibleCount = records.length;

            return ListView(
              key: ValueKey('list-detail-${list.id}'),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 104),
              children: [
                _HeaderCard(
                  list: list,
                  listColor: listColor,
                  recordCount: visibleCount,
                  fieldCount: fields.length,
                  pinnedCount: pinnedCount,
                ),
                const SizedBox(height: 16),
                AppSectionCard(
                  accentColor: listColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'list_detail.filters'.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilterChip(
                            label: Text('list_detail.pinned_only'.tr()),
                            selected: pinnedOnly,
                            onSelected: (value) {
                              ref
                                      .read(pinnedOnlyProvider(listId).notifier)
                                      .state =
                                  value;
                            },
                          ),
                          DropdownButton<RecordSortOption>(
                            value: sort,
                            items: [
                              DropdownMenuItem(
                                value: RecordSortOption.updatedNewest,
                                child: Text('sort.updated_newest'.tr()),
                              ),
                              DropdownMenuItem(
                                value: RecordSortOption.updatedOldest,
                                child: Text('sort.updated_oldest'.tr()),
                              ),
                              DropdownMenuItem(
                                value: RecordSortOption.alphabetical,
                                child: Text('sort.alphabetical'.tr()),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                ref
                                        .read(
                                          recordSortProvider(listId).notifier,
                                        )
                                        .state =
                                    value;
                              }
                            },
                          ),
                          OutlinedButton.icon(
                            onPressed: () =>
                                context.pushNamed(AppRoute.search.name),
                            icon: const Icon(Icons.search),
                            label: Text('search.title'.tr()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                fieldsAsync.when(
                  data: (fields) => recordsAsync.when(
                    data: (records) {
                      if (records.isEmpty) {
                        return AppEmptyState(
                          icon: Icons.inbox_outlined,
                          titleKey: 'records.empty_title',
                          descriptionKey: 'records.empty_description',
                          actionLabelKey: 'records.add',
                          onAction: () => context.pushNamed(
                            AppRoute.createRecord.name,
                            pathParameters: {'listId': '$listId'},
                          ),
                        );
                      }

                      final listFields = fields;
                      return Column(
                        children: records.asMap().entries.map((entry) {
                          final index = entry.key;
                          final record = entry.value;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: TweenAnimationBuilder<double>(
                              duration: Duration(
                                milliseconds: 220 + index * 35,
                              ),
                              curve: Curves.easeOutQuart,
                              tween: Tween(begin: 0, end: 1),
                              builder: (context, value, child) {
                                return Opacity(
                                  opacity: value,
                                  child: Transform.translate(
                                    offset: Offset(0, 14 * (1 - value)),
                                    child: child,
                                  ),
                                );
                              },
                              child: _RecordCard(
                                accentColor: listColor,
                                record: record,
                                fields: listFields,
                                onTap: () => context.pushNamed(
                                  AppRoute.editRecord.name,
                                  pathParameters: {
                                    'listId': '$listId',
                                    'recordId': '${record.id}',
                                  },
                                ),
                                onPin: () => ref
                                    .read(listActionsProvider)
                                    .setRecordPinned(
                                      record.id!,
                                      !record.isPinned,
                                    ),
                                onDelete: () async {
                                  await ref
                                      .read(listActionsProvider)
                                      .deleteRecord(record.id!);
                                  if (context.mounted) {
                                    context.showSnack('records.deleted'.tr());
                                  }
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) => Text('$error'),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => Text('$error'),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('$error')),
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({
    required this.list,
    required this.listColor,
    required this.recordCount,
    required this.fieldCount,
    required this.pinnedCount,
  });

  final AppList list;
  final Color listColor;
  final int recordCount;
  final int fieldCount;
  final int pinnedCount;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final description = list.description.isEmpty
        ? 'list_detail.no_description'.tr()
        : list.description;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: colors.surfaceContainerLowest,
        border: Border.all(
          color: listColor.withValues(alpha: isDark ? 0.26 : 0.18),
        ),
        boxShadow: [
          BoxShadow(
            color: listColor.withValues(alpha: isDark ? 0.08 : 0.05),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -12,
            top: -18,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: listColor.withValues(alpha: 0.08),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: listColor.withValues(alpha: isDark ? 0.16 : 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(_iconForKey(list.iconKey), color: listColor),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          list.name,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: colors.onSurfaceVariant,
                                height: 1.45,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  const _StatChipLabel(label: 'Records'),
                  _StatChip(value: '$recordCount'),
                  const _StatChipLabel(label: 'Fields'),
                  _StatChip(value: '$fieldCount'),
                  const _StatChipLabel(label: 'Pinned'),
                  _StatChip(value: '$pinnedCount'),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _StatusPill(
                    label: list.isArchived ? 'Archived' : 'Active',
                    color: list.isArchived
                        ? colors.surfaceContainerHigh
                        : colors.secondaryContainer,
                  ),
                  _StatusPill(
                    label: 'Offline first',
                    color: colors.surfaceContainerHigh,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecordCard extends StatelessWidget {
  const _RecordCard({
    required this.accentColor,
    required this.record,
    required this.fields,
    required this.onTap,
    required this.onPin,
    required this.onDelete,
  });

  final Color accentColor;
  final ListRecord record;
  final List<ListField> fields;
  final VoidCallback onTap;
  final VoidCallback onPin;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final valuesByField = {
      for (final value in record.values) value.fieldId: value.value,
    };

    return Material(
      color: colors.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: accentColor.withValues(alpha: 0.12)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                record.title,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            if (record.isPinned)
                              _StatusPill(
                                label: 'records.pin'.tr(),
                                color: colors.secondaryContainer,
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'records.updated'.tr(),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: onPin,
                    icon: Icon(
                      record.isPinned
                          ? Icons.push_pin
                          : Icons.push_pin_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (fields.isEmpty)
                Text(
                  'list_detail.no_description'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                )
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: fields
                      .take(4)
                      .where((field) {
                        final value = valuesByField[field.id];
                        return value != null && '$value'.trim().isNotEmpty;
                      })
                      .map((field) {
                        final value = valuesByField[field.id];
                        return _FieldPill(
                          label: field.name,
                          value: formatRecordValue(field.type, value),
                        );
                      })
                      .toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.45),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _StatChipLabel extends StatelessWidget {
  const _StatChipLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
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

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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

class _FieldPill extends StatelessWidget {
  const _FieldPill({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: colors.onSurfaceVariant),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
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
