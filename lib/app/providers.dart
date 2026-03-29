import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';

import 'core/extensions/iterable_x.dart';
import '../data/repositories/isar_app_list_repository.dart';
import '../data/repositories/isar_list_field_repository.dart';
import '../data/repositories/isar_list_record_repository.dart';
import '../data/repositories/isar_settings_repository.dart';
import '../data/repositories/template_repository.dart';
import '../domain/entities/app_list.dart';
import '../domain/entities/app_settings.dart';
import '../domain/entities/list_field.dart';
import '../domain/entities/list_record.dart';
import '../domain/entities/record_sort_option.dart';
import '../domain/entities/list_template.dart';
import '../domain/entities/search_result.dart';
import '../domain/repositories/app_list_repository.dart';
import '../domain/repositories/list_field_repository.dart';
import '../domain/repositories/list_record_repository.dart';
import '../domain/repositories/settings_repository.dart';
import 'router/app_router.dart';

final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('isarProvider must be overridden in main().');
});

final appListRepositoryProvider = Provider<AppListRepository>((ref) {
  return IsarAppListRepository(ref.watch(isarProvider));
});

final listFieldRepositoryProvider = Provider<ListFieldRepository>((ref) {
  return IsarListFieldRepository(ref.watch(isarProvider));
});

final listRecordRepositoryProvider = Provider<ListRecordRepository>((ref) {
  return IsarListRecordRepository(ref.watch(isarProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return IsarSettingsRepository(ref.watch(isarProvider));
});

final templateRepositoryProvider = Provider<TemplateRepository>((ref) {
  return const TemplateRepository();
});

final appRouterProvider = Provider<GoRouter>((ref) {
  return buildAppRouter(ref);
});

final settingsProvider = StreamProvider<AppSettings>((ref) {
  return ref.watch(settingsRepositoryProvider).watchSettings();
});

final activeListsProvider = StreamProvider<List<AppList>>((ref) {
  return ref
      .watch(appListRepositoryProvider)
      .watchLists(includeArchived: false);
});

final archivedListsProvider = StreamProvider<List<AppList>>((ref) {
  return ref.watch(appListRepositoryProvider).watchLists(includeArchived: true);
});

final appListProvider = FutureProvider.family<AppList?, int>((ref, listId) {
  return ref.watch(appListRepositoryProvider).getList(listId);
});

final listFieldsProvider = StreamProvider.family<List<ListField>, int>((
  ref,
  listId,
) {
  return ref.watch(listFieldRepositoryProvider).watchFields(listId);
});

final recordSortProvider = StateProvider.autoDispose
    .family<RecordSortOption, int>((ref, listId) {
      return RecordSortOption.updatedNewest;
    });

final pinnedOnlyProvider = StateProvider.autoDispose.family<bool, int>((
  ref,
  listId,
) {
  return false;
});

final recordQueryProvider = StateProvider.autoDispose.family<String, int>((
  ref,
  listId,
) {
  return '';
});

final listRecordsProvider = StreamProvider.family<List<ListRecord>, int>((
  ref,
  listId,
) {
  final query = ref.watch(recordQueryProvider(listId));
  final pinnedOnly = ref.watch(pinnedOnlyProvider(listId));
  final sort = ref.watch(recordSortProvider(listId));
  return ref
      .watch(listRecordRepositoryProvider)
      .watchRecords(listId, query: query, pinnedOnly: pinnedOnly, sort: sort);
});

final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

final searchResultsProvider = StreamProvider.autoDispose<List<SearchResult>>((
  ref,
) {
  final query = ref.watch(searchQueryProvider);
  return ref.watch(listRecordRepositoryProvider).watchSearchResults(query);
});

final templatesProvider = Provider<List<ListTemplate>>((ref) {
  return ref.watch(templateRepositoryProvider).templates;
});

final templateByIdProvider = Provider.family<ListTemplate?, String>((
  ref,
  templateId,
) {
  return ref
      .watch(templateRepositoryProvider)
      .templates
      .where((template) => template.id == templateId)
      .cast<ListTemplate?>()
      .firstOrNull;
});
