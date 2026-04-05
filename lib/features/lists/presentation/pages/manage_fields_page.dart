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
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text('fields.title'.tr())),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showFieldSheet(context, ref),
        icon: const Icon(Icons.add),
        label: Text('fields.add'.tr()),
      ),
      body: fieldsAsync.when(
        data: (fields) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              AppSectionCard(
                accentColor: colors.primary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'fields.title'.tr(),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Fields define the shape of every record. Keep the set lean so the list stays fast to fill in.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (fields.isEmpty)
                AppEmptyState(
                  icon: Icons.tune,
                  titleKey: 'fields.empty_title',
                  descriptionKey: 'fields.empty_description',
                  actionLabelKey: 'fields.add',
                  onAction: () => _showFieldSheet(context, ref),
                )
              else
                ...fields.asMap().entries.map((entry) {
                  final index = entry.key;
                  final field = entry.value;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AppSectionCard(
                      accentColor: _fieldColor(field.type, colors),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: _fieldColor(
                                field.type,
                                colors,
                              ).withValues(alpha: 0.14),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              _fieldIcon(field.type),
                              color: _fieldColor(field.type, colors),
                              size: 20,
                            ),
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
                                        field.name,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      ),
                                    ),
                                    if (field.isRequired)
                                      _FieldBadge(
                                        label: 'Required',
                                        color: colors.secondaryContainer,
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  fieldTypeLabel(field.type),
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: colors.onSurfaceVariant,
                                      ),
                                ),
                                if (field.options.isNotEmpty) ...[
                                  const SizedBox(height: 10),
                                  Wrap(
                                    spacing: 6,
                                    runSpacing: 6,
                                    children: field.options
                                        .map(
                                          (option) => _FieldBadge(
                                            label: option,
                                            color: colors.surfaceContainerHigh,
                                          ),
                                        )
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
                                    : () => _moveField(
                                        ref,
                                        fields,
                                        index,
                                        index - 1,
                                      ),
                                icon: const Icon(Icons.keyboard_arrow_up),
                              ),
                              IconButton(
                                onPressed: index == fields.length - 1
                                    ? null
                                    : () => _moveField(
                                        ref,
                                        fields,
                                        index,
                                        index + 1,
                                      ),
                                icon: const Icon(Icons.keyboard_arrow_down),
                              ),
                            ],
                          ),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                _showFieldSheet(context, ref, field: field);
                              } else if (value == 'delete') {
                                ref
                                    .read(listActionsProvider)
                                    .deleteField(field.id!);
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
                    ),
                  );
                }),
            ],
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
      useSafeArea: true,
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

    return AnimatedPadding(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutQuart,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: fieldsAsync.when(
        data: (fields) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  widget.field == null ? 'fields.add'.tr() : 'fields.edit'.tr(),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Keep the field name simple. The type controls how each record value is entered.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 16),
                AppSectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'fields.name'.tr(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<FieldType>(
                        initialValue: _fieldType,
                        decoration: InputDecoration(
                          labelText: 'fields.type'.tr(),
                        ),
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
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                FilledButton(
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
              ],
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Text('$error'),
      ),
    );
  }
}

Color _fieldColor(FieldType type, ColorScheme colors) {
  switch (type) {
    case FieldType.checkbox:
      return colors.secondary;
    case FieldType.date:
    case FieldType.dateTime:
      return colors.primary;
    case FieldType.singleSelect:
    case FieldType.multiSelect:
      return colors.tertiary;
    case FieldType.rating:
      return colors.error;
    default:
      return colors.primary;
  }
}

IconData _fieldIcon(FieldType type) {
  switch (type) {
    case FieldType.multilineText:
      return Icons.subject;
    case FieldType.number:
      return Icons.numbers;
    case FieldType.currency:
      return Icons.payments_outlined;
    case FieldType.checkbox:
      return Icons.check_box_outlined;
    case FieldType.date:
      return Icons.calendar_today_outlined;
    case FieldType.dateTime:
      return Icons.schedule_outlined;
    case FieldType.singleSelect:
      return Icons.radio_button_checked_outlined;
    case FieldType.multiSelect:
      return Icons.checklist_outlined;
    case FieldType.rating:
      return Icons.star_outline;
    case FieldType.url:
      return Icons.link_outlined;
    case FieldType.phone:
      return Icons.phone_outlined;
    case FieldType.email:
      return Icons.email_outlined;
    case FieldType.text:
      return Icons.text_fields;
  }
}

class _FieldBadge extends StatelessWidget {
  const _FieldBadge({required this.label, required this.color});

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
