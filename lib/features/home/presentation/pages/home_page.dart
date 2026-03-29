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
import '../../../lists/presentation/providers/list_actions.dart';
import '../widgets/app_list_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeLists = ref.watch(activeListsProvider);
    final archivedLists = ref.watch(archivedListsProvider);
    final actions = ref.watch(listActionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('home.title'.tr()),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(AppRoute.search.name),
            icon: const Icon(Icons.search),
            tooltip: 'search.title'.tr(),
          ),
          IconButton(
            onPressed: () => context.pushNamed(AppRoute.settings.name),
            icon: const Icon(Icons.tune),
            tooltip: 'settings.title'.tr(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(AppRoute.createList.name),
        icon: const Icon(Icons.add),
        label: Text('home.create_list'.tr()),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
        children: [
          const _HeroCard(),
          const SizedBox(height: 16),
          activeLists.when(
            data: (lists) => _ListSection(
              title: 'home.your_lists'.tr(),
              lists: lists,
              empty: AppEmptyState(
                icon: Icons.library_add_check,
                titleKey: 'home.empty_title',
                descriptionKey: 'home.empty_description',
                actionLabelKey: 'home.create_list',
                onAction: () => context.pushNamed(AppRoute.createList.name),
              ),
              onTap: (list) => context.pushNamed(
                AppRoute.listDetail.name,
                pathParameters: {'listId': '${list.id}'},
              ),
              onEdit: (list) => context.pushNamed(
                AppRoute.editList.name,
                pathParameters: {'listId': '${list.id}'},
              ),
              onArchiveToggle: (list) async {
                await actions.archiveList(list.id!, !list.isArchived);
                if (context.mounted) {
                  context.showSnack('home.list_archived'.tr());
                }
              },
              onDelete: (list) => _deleteList(context, actions, list),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => _ErrorCard(message: '$error'),
          ),
          const SizedBox(height: 20),
          AppSectionCard(
            child: archivedLists.when(
              data: (lists) {
                final archived = lists
                    .where((list) => list.isArchived)
                    .toList();
                if (archived.isEmpty) {
                  return Text(
                    'home.archived_empty'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'home.archived_lists'.tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    ...archived.map(
                      (list) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AppListCard(
                          list: list,
                          onTap: () => context.pushNamed(
                            AppRoute.listDetail.name,
                            pathParameters: {'listId': '${list.id}'},
                          ),
                          onEdit: () => context.pushNamed(
                            AppRoute.editList.name,
                            pathParameters: {'listId': '${list.id}'},
                          ),
                          onArchiveToggle: () =>
                              actions.archiveList(list.id!, false),
                          onDelete: () => _deleteList(context, actions, list),
                        ),
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => _ErrorCard(message: '$error'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteList(
    BuildContext context,
    ListActions actions,
    AppList list,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('common.delete'.tr()),
        content: Text('home.delete_confirm'.tr(args: [list.name])),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('common.cancel'.tr()),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('common.delete'.tr()),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await actions.deleteList(list.id!);
      if (context.mounted) {
        context.showSnack('home.list_deleted'.tr());
      }
    }
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [scheme.primary, scheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'home.hero_title'.tr(),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: scheme.onPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'home.hero_description'.tr(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: scheme.onPrimary.withValues(alpha: 0.92),
            ),
          ),
        ],
      ),
    );
  }
}

class _ListSection extends StatelessWidget {
  const _ListSection({
    required this.title,
    required this.lists,
    required this.empty,
    required this.onTap,
    required this.onEdit,
    required this.onArchiveToggle,
    required this.onDelete,
  });

  final String title;
  final List<AppList> lists;
  final Widget empty;
  final ValueChanged<AppList> onTap;
  final ValueChanged<AppList> onEdit;
  final ValueChanged<AppList> onArchiveToggle;
  final ValueChanged<AppList> onDelete;

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          if (lists.isEmpty)
            empty
          else
            ...lists.map(
              (list) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppListCard(
                  list: list,
                  onTap: () => onTap(list),
                  onEdit: () => onEdit(list),
                  onArchiveToggle: () => onArchiveToggle(list),
                  onDelete: () => onDelete(list),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(child: Text(message));
  }
}
