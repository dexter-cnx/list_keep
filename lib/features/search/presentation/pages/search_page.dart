import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/core/widgets/app_empty_state.dart';
import '../../../../app/providers.dart';
import '../../../../app/router/app_router.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final resultsAsync = ref.watch(searchResultsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('search.title'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: (value) =>
                  ref.read(searchQueryProvider.notifier).state = value,
              decoration: InputDecoration(
                hintText: 'search.hint'.tr(),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: resultsAsync.when(
                data: (results) {
                  if (query.trim().isEmpty) {
                    return AppEmptyState(
                      icon: Icons.search,
                      titleKey: 'search.empty_title',
                      descriptionKey: 'search.empty_description',
                    );
                  }

                  if (results.isEmpty) {
                    return AppEmptyState(
                      icon: Icons.manage_search,
                      titleKey: 'search.no_results_title',
                      descriptionKey: 'search.no_results_description',
                    );
                  }

                  return ListView.separated(
                    itemCount: results.length,
                    separatorBuilder: (_, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final result = results[index];
                      return Card(
                        child: ListTile(
                          title: Text(result.record.title),
                          subtitle: Text(result.list.name),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.pushNamed(
                            AppRoute.editRecord.name,
                            pathParameters: {
                              'listId': '${result.list.id}',
                              'recordId': '${result.record.id}',
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(child: Text('$error')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
