import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/core/extensions/build_context_x.dart';
import '../../../../app/core/widgets/app_empty_state.dart';
import '../../../../app/core/widgets/app_section_card.dart';
import '../../../../app/providers.dart';
import '../../../../app/router/app_router.dart';
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

            return ListView(
              key: ValueKey('list-detail-${list.id}'),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
              children: [
                AppSectionCard(
                  accentColor: listColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: listColor.withValues(alpha: 0.14),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Icon(_iconForKey(list.iconKey), color: listColor),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              list.description.isEmpty
                                  ? 'list_detail.no_description'.tr()
                                  : list.description,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
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
                                  .state = value;
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
                                    .read(recordSortProvider(listId).notifier)
                                    .state = value;
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

                      return Column(
                        children: records.asMap().entries.map((entry) {
                          final index = entry.key;
                          final record = entry.value;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: TweenAnimationBuilder<double>(
                              duration: Duration(milliseconds: 220 + index * 35),
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
                                fields: fields,
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
                  loading: () => const Center(child: CircularProgressIndicator()),
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
    final valuesByField = {
      for (final value in record.values) value.fieldId: value.value,
    };

    return AppSectionCard(
      accentColor: accentColor,
      padding: const EdgeInsets.all(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
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
                IconButton(
                  onPressed: onPin,
                  icon: Icon(
                    record.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                  ),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...fields.take(3).map((field) {
              final value = valuesByField[field.id];
              if (value == null || '$value'.trim().isEmpty) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  '${field.name}: ${formatRecordValue(field.type, value)}',
                ),
              );
            }),
          ],
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
