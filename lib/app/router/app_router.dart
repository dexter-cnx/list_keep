import 'package:flutter/material.dart';
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
        pageBuilder: (context, state) => _page(const HomePage(), state),
      ),
      GoRoute(
        path: AppRoute.createList.path,
        name: AppRoute.createList.name,
        pageBuilder: (context, state) => _page(const CreateEditListPage(), state),
      ),
      GoRoute(
        path: AppRoute.editList.path,
        name: AppRoute.editList.name,
        pageBuilder: (context, state) => _page(
          CreateEditListPage(listId: _intParam(state, 'listId')),
          state,
        ),
      ),
      GoRoute(
        path: AppRoute.templatePicker.path,
        name: AppRoute.templatePicker.name,
        pageBuilder: (context, state) => _page(const TemplatePickerPage(), state),
      ),
      GoRoute(
        path: AppRoute.listDetail.path,
        name: AppRoute.listDetail.name,
        pageBuilder: (context, state) => _page(
          ListDetailPage(listId: _intParam(state, 'listId')),
          state,
        ),
      ),
      GoRoute(
        path: AppRoute.manageFields.path,
        name: AppRoute.manageFields.name,
        pageBuilder: (context, state) => _page(
          ManageFieldsPage(listId: _intParam(state, 'listId')),
          state,
        ),
      ),
      GoRoute(
        path: AppRoute.createRecord.path,
        name: AppRoute.createRecord.name,
        pageBuilder: (context, state) => _page(
          CreateEditRecordPage(listId: _intParam(state, 'listId')),
          state,
        ),
      ),
      GoRoute(
        path: AppRoute.editRecord.path,
        name: AppRoute.editRecord.name,
        pageBuilder: (context, state) => _page(
          CreateEditRecordPage(
          listId: _intParam(state, 'listId'),
          recordId: _intParam(state, 'recordId'),
          ),
          state,
        ),
      ),
      GoRoute(
        path: AppRoute.search.path,
        name: AppRoute.search.name,
        pageBuilder: (context, state) => _page(const SearchPage(), state),
      ),
      GoRoute(
        path: AppRoute.settings.path,
        name: AppRoute.settings.name,
        pageBuilder: (context, state) => _page(const SettingsPage(), state),
      ),
    ],
  );
}

Page<T> _page<T>(Widget child, GoRouterState state) {
  if (WidgetsBinding.instance.platformDispatcher.accessibilityFeatures.disableAnimations) {
    return NoTransitionPage<T>(key: state.pageKey, child: child);
  }

  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 240),
    reverseTransitionDuration: const Duration(milliseconds: 180),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curve = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutQuart,
      );

      return FadeTransition(
        opacity: curve,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.04, 0.02),
            end: Offset.zero,
          ).animate(curve),
          child: child,
        ),
      );
    },
  );
}

int _intParam(GoRouterState state, String key) {
  return int.parse(state.pathParameters[key]!);
}
