import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/core/extensions/build_context_x.dart';
import '../../../../app/core/widgets/app_empty_state.dart';
import '../../../../app/core/widgets/app_section_card.dart';
import '../../../../app/providers.dart';
import '../../../../domain/entities/field_type.dart';
import '../../../../domain/entities/list_field.dart';
import '../providers/list_actions.dart';
import '../widgets/field_type_label.dart';

class ManageFieldsPage extends ConsumerWidget {
  const ManageFieldsPage({super.key, required this.listId});

  final int listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldsAsync = ref.watch(listFieldsProvider(listId));

    return Scaffold(
      appBar: AppBar(title: Text('fields.title'.tr())),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showFieldSheet(context, ref),
        icon: const Icon(Icons.add),
        label: Text('fields.add'.tr()),
      ),
      body: fieldsAsync.when(
        data: (fields) {
          if (fields.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: AppEmptyState(
                icon: Icons.tune,
                titleKey: 'fields.empty_title',
                descriptionKey: 'fields.empty_description',
                actionLabelKey: 'fields.add',
                onAction: () => _showFieldSheet(context, ref),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: fields.length,
            separatorBuilder: (_, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final field = fields[index];
              return AppSectionCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            field.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 6),
                          Text(fieldTypeLabel(field.type)),
                          if (field.options.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              children: field.options
                                  .map((option) => Chip(label: Text(option)))
                                  .toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: index == 0
                              ? null
                              : () => _moveField(ref, fields, index, index - 1),
                          icon: const Icon(Icons.keyboard_arrow_up),
                        ),
                        IconButton(
                          onPressed: index == fields.length - 1
                              ? null
                              : () => _moveField(ref, fields, index, index + 1),
                          icon: const Icon(Icons.keyboard_arrow_down),
                        ),
                      ],
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          _showFieldSheet(context, ref, field: field);
                        } else if (value == 'delete') {
                          ref.read(listActionsProvider).deleteField(field.id!);
                          context.showSnack('fields.deleted'.tr());
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Text('common.edit'.tr()),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text('common.delete'.tr()),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('$error')),
      ),
    );
  }

  void _moveField(WidgetRef ref, List<ListField> fields, int from, int to) {
    final reordered = [...fields];
    final item = reordered.removeAt(from);
    reordered.insert(to, item);
    ref
        .read(listActionsProvider)
        .reorderFields(listId, reordered.map((field) => field.id!).toList());
  }

  Future<void> _showFieldSheet(
    BuildContext context,
    WidgetRef ref, {
    ListField? field,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _FieldEditorSheet(listId: listId, field: field),
    );
  }
}

class _FieldEditorSheet extends ConsumerStatefulWidget {
  const _FieldEditorSheet({required this.listId, this.field});

  final int listId;
  final ListField? field;

  @override
  ConsumerState<_FieldEditorSheet> createState() => _FieldEditorSheetState();
}

class _FieldEditorSheetState extends ConsumerState<_FieldEditorSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _optionsController;
  late FieldType _fieldType;
  late bool _required;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.field?.name ?? '');
    _optionsController = TextEditingController(
      text: widget.field?.options.join(', ') ?? '',
    );
    _fieldType = widget.field?.type ?? FieldType.text;
    _required = widget.field?.isRequired ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _optionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fieldsAsync = ref.watch(listFieldsProvider(widget.listId));

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: fieldsAsync.when(
        data: (fields) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.field == null ? 'fields.add'.tr() : 'fields.edit'.tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'fields.name'.tr()),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<FieldType>(
              initialValue: _fieldType,
              decoration: InputDecoration(labelText: 'fields.type'.tr()),
              items: FieldType.values
                  .map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(fieldTypeLabel(type)),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _fieldType = value);
                }
              },
            ),
            if (_fieldType.usesOptions) ...[
              const SizedBox(height: 12),
              TextField(
                controller: _optionsController,
                decoration: InputDecoration(
                  labelText: 'fields.options'.tr(),
                  helperText: 'fields.options_hint'.tr(),
                ),
              ),
            ],
            SwitchListTile(
              value: _required,
              onChanged: (value) => setState(() => _required = value),
              contentPadding: EdgeInsets.zero,
              title: Text('fields.required'.tr()),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  final name = _nameController.text.trim();
                  if (name.isEmpty) return;

                  final options = _optionsController.text
                      .split(',')
                      .map((item) => item.trim())
                      .where((item) => item.isNotEmpty)
                      .toList();

                  await ref
                      .read(listActionsProvider)
                      .saveField(
                        ListField(
                          id: widget.field?.id,
                          listId: widget.listId,
                          name: name,
                          type: _fieldType,
                          sortOrder: widget.field?.sortOrder ?? fields.length,
                          isRequired: _required,
                          options: options,
                        ),
                      );

                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                },
                child: Text('common.save'.tr()),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Text('$error'),
      ),
    );
  }
}
