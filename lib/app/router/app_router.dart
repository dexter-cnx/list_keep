import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/lists/presentation/pages/create_edit_list_page.dart';
import '../../features/lists/presentation/pages/create_edit_record_page.dart';
import '../../features/lists/presentation/pages/list_detail_page.dart';
import '../../features/lists/presentation/pages/manage_fields_page.dart';
import '../../features/lists/presentation/pages/template_picker_page.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';

enum AppRoute {
  home('/'),
  createList('/lists/create'),
  editList('/lists/:listId/edit'),
  templatePicker('/templates'),
  listDetail('/lists/:listId'),
  manageFields('/lists/:listId/fields'),
  createRecord('/lists/:listId/records/new'),
  editRecord('/lists/:listId/records/:recordId/edit'),
  search('/search'),
  settings('/settings');

  const AppRoute(this.path);

  final String path;
}

GoRouter buildAppRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoute.home.path,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoute.createList.path,
        name: AppRoute.createList.name,
        builder: (context, state) => const CreateEditListPage(),
      ),
      GoRoute(
        path: AppRoute.editList.path,
        name: AppRoute.editList.name,
        builder: (context, state) =>
            CreateEditListPage(listId: _intParam(state, 'listId')),
      ),
      GoRoute(
        path: AppRoute.templatePicker.path,
        name: AppRoute.templatePicker.name,
        builder: (context, state) => const TemplatePickerPage(),
      ),
      GoRoute(
        path: AppRoute.listDetail.path,
        name: AppRoute.listDetail.name,
        builder: (context, state) =>
            ListDetailPage(listId: _intParam(state, 'listId')),
      ),
      GoRoute(
        path: AppRoute.manageFields.path,
        name: AppRoute.manageFields.name,
        builder: (context, state) =>
            ManageFieldsPage(listId: _intParam(state, 'listId')),
      ),
      GoRoute(
        path: AppRoute.createRecord.path,
        name: AppRoute.createRecord.name,
        builder: (context, state) =>
            CreateEditRecordPage(listId: _intParam(state, 'listId')),
      ),
      GoRoute(
        path: AppRoute.editRecord.path,
        name: AppRoute.editRecord.name,
        builder: (context, state) => CreateEditRecordPage(
          listId: _intParam(state, 'listId'),
          recordId: _intParam(state, 'recordId'),
        ),
      ),
      GoRoute(
        path: AppRoute.search.path,
        name: AppRoute.search.name,
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        path: AppRoute.settings.path,
        name: AppRoute.settings.name,
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
}

int _intParam(GoRouterState state, String key) {
  return int.parse(state.pathParameters[key]!);
}
