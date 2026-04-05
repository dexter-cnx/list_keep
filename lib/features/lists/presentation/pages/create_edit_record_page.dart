import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/core/extensions/build_context_x.dart';
import '../../../../app/core/widgets/app_section_card.dart';
import '../../../../app/providers.dart';
import '../../../../domain/entities/field_type.dart';
import '../../../../domain/entities/list_field.dart';
import '../../../../domain/entities/record_value.dart';
import '../providers/list_actions.dart';

class CreateEditRecordPage extends ConsumerStatefulWidget {
  const CreateEditRecordPage({super.key, required this.listId, this.recordId});

  final int listId;
  final int? recordId;

  @override
  ConsumerState<CreateEditRecordPage> createState() =>
      _CreateEditRecordPageState();
}

class _CreateEditRecordPageState extends ConsumerState<CreateEditRecordPage> {
  final Map<int, dynamic> _draftValues = {};
  bool _isPinned = false;
  bool _seeded = false;

  @override
  Widget build(BuildContext context) {
    final fieldsAsync = ref.watch(listFieldsProvider(widget.listId));
    final recordAsync = widget.recordId == null
        ? const AsyncValue.data(null)
        : ref.watch(_recordProvider(widget.recordId!));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recordId == null ? 'records.create'.tr() : 'records.edit'.tr(),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        switchInCurve: Curves.easeOutQuart,
        switchOutCurve: Curves.easeIn,
        child: fieldsAsync.when(
          data: (fields) => recordAsync.when(
            data: (record) {
              if (!_seeded && record != null) {
                for (final value in record.values) {
                  _draftValues[value.fieldId] = value.value;
                }
                _isPinned = record.isPinned;
                _seeded = true;
              }

              return ListView(
                key: ValueKey('record-form-${widget.recordId ?? 'new'}'),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 104),
                children: [
                  AppSectionCard(
                    accentColor: Theme.of(context).colorScheme.primary,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.recordId == null
                              ? 'Create record'
                              : 'Edit record',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Capture the values for this list in one place. Fields stay local and easy to edit later.',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                                height: 1.45,
                              ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _StatusPill(
                              label: _isPinned ? 'Pinned' : 'Not pinned',
                              color: Theme.of(
                                context,
                              ).colorScheme.secondaryContainer,
                            ),
                            _StatusPill(
                              label: '${fields.length} fields',
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHigh,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppSectionCard(
                    accentColor: Theme.of(context).colorScheme.secondary,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text('records.pin'.tr()),
                          value: _isPinned,
                          onChanged: (value) =>
                              setState(() => _isPinned = value),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Pinned records stay near the top when browsing.',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                                height: 1.45,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppSectionCard(
                    accentColor: Theme.of(context).colorScheme.tertiary,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fields',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Fill in each value below. The layout adapts to the field type automatically.',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                                height: 1.45,
                              ),
                        ),
                        const SizedBox(height: 12),
                        ...fields.asMap().entries.map((entry) {
                          final index = entry.key;
                          final field = entry.value;

                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: index == fields.length - 1 ? 0 : 14,
                            ),
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
                                    offset: Offset(0, 12 * (1 - value)),
                                    child: child,
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                child: _FieldInput(
                                  field: field,
                                  initialValue: _draftValues[field.id ?? -1],
                                  onChanged: (value) =>
                                      _draftValues[field.id ?? -1] = value,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('$error')),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('$error')),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: FilledButton(
          onPressed: () => _save(fieldsAsync.value ?? const []),
          child: Text('common.save'.tr()),
        ),
      ),
    );
  }

  Future<void> _save(List<ListField> fields) async {
    if (fields.isEmpty) return;

    final values = <RecordValue>[];
    for (final field in fields) {
      final value = _draftValues[field.id];
      if (field.isRequired && (value == null || '$value'.trim().isEmpty)) {
        if (mounted) {
          context.showSnack('validation.required'.tr());
        }
        return;
      }
      values.add(RecordValue(fieldId: field.id!, value: value));
    }

    final createdAt = widget.recordId == null
        ? null
        : (await ref
                  .read(listRecordRepositoryProvider)
                  .getRecord(widget.recordId!))
              ?.createdAt;

    final record = ref
        .read(listActionsProvider)
        .buildRecord(
          recordId: widget.recordId,
          listId: widget.listId,
          values: values,
          isPinned: _isPinned,
          createdAt: createdAt,
        );
    await ref.read(listActionsProvider).saveRecord(record);

    if (!mounted) return;
    context.showSnack('records.saved'.tr());
    context.pop();
  }
}

final _recordProvider = FutureProvider.family((ref, int recordId) {
  return ref.watch(listRecordRepositoryProvider).getRecord(recordId);
});

class _FieldInput extends StatefulWidget {
  const _FieldInput({
    required this.field,
    required this.initialValue,
    required this.onChanged,
  });

  final ListField field;
  final dynamic initialValue;
  final ValueChanged<dynamic> onChanged;

  @override
  State<_FieldInput> createState() => _FieldInputState();
}

class _FieldInputState extends State<_FieldInput> {
  late final TextEditingController _controller;
  late dynamic _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _controller = TextEditingController(
      text: _initialText(widget.initialValue),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final field = widget.field;

    switch (field.type) {
      case FieldType.multilineText:
        return TextField(
          controller: _controller,
          maxLines: 4,
          decoration: InputDecoration(labelText: field.name),
          onChanged: widget.onChanged,
        );
      case FieldType.checkbox:
        return SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: (_currentValue as bool?) ?? false,
          onChanged: (value) {
            setState(() => _currentValue = value);
            widget.onChanged(value);
          },
          title: Text(field.name),
        );
      case FieldType.singleSelect:
        return DropdownButtonFormField<String>(
          initialValue: _currentValue as String?,
          decoration: InputDecoration(labelText: field.name),
          items: field.options
              .map(
                (option) =>
                    DropdownMenuItem(value: option, child: Text(option)),
              )
              .toList(),
          onChanged: (value) {
            setState(() => _currentValue = value);
            widget.onChanged(value);
          },
        );
      case FieldType.multiSelect:
        final selected = ((_currentValue as List?) ?? const []).cast<String>();
        return InputDecorator(
          decoration: InputDecoration(labelText: field.name),
          child: Wrap(
            spacing: 8,
            children: field.options.map((option) {
              final active = selected.contains(option);
              return FilterChip(
                label: Text(option),
                selected: active,
                onSelected: (value) {
                  final next = [...selected];
                  if (value) {
                    next.add(option);
                  } else {
                    next.remove(option);
                  }
                  setState(() => _currentValue = next);
                  widget.onChanged(next);
                },
              );
            }).toList(),
          ),
        );
      case FieldType.rating:
        final rating = (((_currentValue as num?)?.toDouble() ?? 0.0).clamp(
          0.0,
          5.0,
        )).toDouble();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(field.name),
            Slider(
              value: rating,
              min: 0,
              max: 5,
              divisions: 5,
              label: '${rating.round()}',
              onChanged: (value) {
                setState(() => _currentValue = value.round());
                widget.onChanged(value.round());
              },
            ),
          ],
        );
      case FieldType.date:
        return _DateField(
          label: field.name,
          initialValue: _currentValue,
          includeTime: false,
          onChanged: widget.onChanged,
        );
      case FieldType.dateTime:
        return _DateField(
          label: field.name,
          initialValue: _currentValue,
          includeTime: true,
          onChanged: widget.onChanged,
        );
      case FieldType.number:
      case FieldType.currency:
      case FieldType.phone:
      case FieldType.email:
      case FieldType.url:
      case FieldType.text:
        return TextField(
          controller: _controller,
          keyboardType: _keyboardType(field.type),
          decoration: InputDecoration(labelText: field.name),
          onChanged: (value) {
            widget.onChanged(_parseValue(field.type, value));
          },
        );
    }
  }

  static String _initialText(dynamic value) {
    if (value == null) return '';
    if (value is List) return value.join(', ');
    return '$value';
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

class _DateField extends StatefulWidget {
  const _DateField({
    required this.label,
    required this.initialValue,
    required this.includeTime,
    required this.onChanged,
  });

  final String label;
  final dynamic initialValue;
  final bool includeTime;
  final ValueChanged<String?> onChanged;

  @override
  State<_DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<_DateField> {
  DateTime? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue is String
        ? DateTime.tryParse(widget.initialValue)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: colors.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colors.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            initialDate: _value ?? DateTime.now(),
          );
          if (date == null || !context.mounted) return;

          DateTime next = date;
          if (widget.includeTime) {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(_value ?? DateTime.now()),
            );
            if (time != null) {
              next = DateTime(
                date.year,
                date.month,
                date.day,
                time.hour,
                time.minute,
              );
            }
          }

          setState(() => _value = next);
          widget.onChanged(next.toIso8601String());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.calendar_today_outlined,
                  color: colors.primary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.label),
                    const SizedBox(height: 4),
                    Text(
                      _value == null
                          ? 'records.pick_date'.tr()
                          : widget.includeTime
                          ? DateFormat.yMMMd().add_jm().format(_value!)
                          : DateFormat.yMMMd().format(_value!),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

TextInputType _keyboardType(FieldType type) {
  switch (type) {
    case FieldType.number:
    case FieldType.currency:
      return const TextInputType.numberWithOptions(decimal: true);
    case FieldType.phone:
      return TextInputType.phone;
    case FieldType.email:
      return TextInputType.emailAddress;
    case FieldType.url:
      return TextInputType.url;
    default:
      return TextInputType.text;
  }
}

dynamic _parseValue(FieldType type, String value) {
  switch (type) {
    case FieldType.number:
    case FieldType.currency:
      return num.tryParse(value) ?? value;
    default:
      return value;
  }
}
