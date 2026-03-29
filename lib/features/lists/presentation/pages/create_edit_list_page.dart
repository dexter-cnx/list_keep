import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/core/extensions/build_context_x.dart';
import '../../../../app/core/widgets/app_section_card.dart';
import '../../../../app/providers.dart';
import '../../../../app/router/app_router.dart';
import '../../../../domain/entities/list_template.dart';
import '../providers/list_actions.dart';

class CreateEditListPage extends ConsumerStatefulWidget {
  const CreateEditListPage({super.key, this.listId});

  final int? listId;

  @override
  ConsumerState<CreateEditListPage> createState() => _CreateEditListPageState();
}

class _CreateEditListPageState extends ConsumerState<CreateEditListPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _icons = const [
    'checklist',
    'payments',
    'inventory_2',
    'task_alt',
    'favorite',
  ];
  final _colors = const [
    0xFF0A7E8C,
    0xFF2563EB,
    0xFF7C3AED,
    0xFFD97706,
    0xFFDB2777,
  ];

  String _iconKey = 'checklist';
  int _colorValue = 0xFF0A7E8C;
  ListTemplate? _selectedTemplate;
  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.listId != null;
    final listAsync = widget.listId != null
        ? ref.watch(appListProvider(widget.listId!))
        : const AsyncValue.data(null);

    final existingList = listAsync.valueOrNull;
    if (existingList != null && !_initialized) {
      _nameController.text = existingList.name;
      _descriptionController.text = existingList.description;
      _iconKey = existingList.iconKey;
      _colorValue = existingList.colorValue;
      _initialized = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing
              ? 'list_editor.edit_title'.tr()
              : 'list_editor.create_title'.tr(),
        ),
      ),
      body: listAsync.when(
        data: (_) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppSectionCard(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'list_editor.name'.tr(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'validation.required'.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'list_editor.description'.tr(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'list_editor.pick_icon'.tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _icons.map((iconKey) {
                        final selected = _iconKey == iconKey;
                        return ChoiceChip(
                          label: Icon(_icon(iconKey)),
                          selected: selected,
                          onSelected: (_) => setState(() => _iconKey = iconKey),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'list_editor.pick_color'.tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      children: _colors.map((value) {
                        final selected = _colorValue == value;
                        return GestureDetector(
                          onTap: () => setState(() => _colorValue = value),
                          child: CircleAvatar(
                            radius: selected ? 24 : 20,
                            backgroundColor: Color(value),
                            child: selected
                                ? const Icon(Icons.check, color: Colors.white)
                                : null,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            if (!isEditing) ...[
              const SizedBox(height: 16),
              AppSectionCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'list_editor.template_title'.tr(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _selectedTemplate?.name ??
                                'list_editor.template_none'.tr(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: _pickTemplate,
                      child: Text('list_editor.choose_template'.tr()),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('$error')),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: FilledButton(onPressed: _save, child: Text('common.save'.tr())),
      ),
    );
  }

  Future<void> _pickTemplate() async {
    final templateId = await context.pushNamed<String>(
      AppRoute.templatePicker.name,
    );
    if (!mounted || templateId == null) return;
    setState(() {
      _selectedTemplate = ref.read(templateByIdProvider(templateId));
      if (_selectedTemplate != null) {
        _nameController.text = _selectedTemplate!.name;
        _descriptionController.text = _selectedTemplate!.description;
        _iconKey = _selectedTemplate!.iconKey;
        _colorValue = _selectedTemplate!.colorValue;
      }
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final listId = await ref
        .read(listActionsProvider)
        .saveList(
          listId: widget.listId,
          name: _nameController.text,
          description: _descriptionController.text,
          iconKey: _iconKey,
          colorValue: _colorValue,
          template: widget.listId == null ? _selectedTemplate : null,
        );

    if (!mounted) return;

    context.showSnack('list_editor.saved'.tr());
    context.goNamed(
      AppRoute.listDetail.name,
      pathParameters: {'listId': '$listId'},
    );
  }
}

IconData _icon(String iconKey) {
  switch (iconKey) {
    case 'payments':
      return Icons.payments_outlined;
    case 'inventory_2':
      return Icons.inventory_2_outlined;
    case 'task_alt':
      return Icons.task_alt;
    case 'favorite':
      return Icons.favorite_outline;
    default:
      return Icons.checklist_outlined;
  }
}
