import '../../domain/entities/field_type.dart';
import '../../domain/entities/list_template.dart';

class TemplateRepository {
  const TemplateRepository();

  List<ListTemplate> get templates => const [
    ListTemplate(
      id: 'expense-tracker',
      name: 'Expense Tracker',
      description: 'Track where money goes with clear categories and dates.',
      iconKey: 'payments',
      colorValue: 0xFF2563EB,
      fields: [
        TemplateField(name: 'Item', type: FieldType.text, isRequired: true),
        TemplateField(
          name: 'Amount',
          type: FieldType.currency,
          isRequired: true,
        ),
        TemplateField(
          name: 'Category',
          type: FieldType.singleSelect,
          options: ['Food', 'Transport', 'Shopping', 'Bills', 'Other'],
        ),
        TemplateField(name: 'Paid on', type: FieldType.date),
        TemplateField(name: 'Notes', type: FieldType.multilineText),
      ],
    ),
    ListTemplate(
      id: 'inventory',
      name: 'Inventory',
      description: 'Keep a lightweight catalog of items, stock, and value.',
      iconKey: 'inventory_2',
      colorValue: 0xFF7C3AED,
      fields: [
        TemplateField(name: 'Item', type: FieldType.text, isRequired: true),
        TemplateField(name: 'SKU', type: FieldType.text),
        TemplateField(name: 'Quantity', type: FieldType.number),
        TemplateField(name: 'Unit price', type: FieldType.currency),
        TemplateField(name: 'Location', type: FieldType.text),
      ],
    ),
    ListTemplate(
      id: 'checklist',
      name: 'Checklist',
      description: 'Turn repeating tasks into a structured checklist.',
      iconKey: 'task_alt',
      colorValue: 0xFF059669,
      fields: [
        TemplateField(name: 'Task', type: FieldType.text, isRequired: true),
        TemplateField(name: 'Done', type: FieldType.checkbox),
        TemplateField(name: 'Due', type: FieldType.date),
        TemplateField(name: 'Priority', type: FieldType.rating),
      ],
    ),
    ListTemplate(
      id: 'collection-tracker',
      name: 'Collection Tracker',
      description: 'Catalog books, cards, figures, or anything collectible.',
      iconKey: 'collections_bookmark',
      colorValue: 0xFFD97706,
      fields: [
        TemplateField(name: 'Item', type: FieldType.text, isRequired: true),
        TemplateField(
          name: 'Status',
          type: FieldType.singleSelect,
          options: ['Owned', 'Wishlist', 'Sold'],
        ),
        TemplateField(name: 'Rating', type: FieldType.rating),
        TemplateField(name: 'Source URL', type: FieldType.url),
        TemplateField(name: 'Notes', type: FieldType.multilineText),
      ],
    ),
    ListTemplate(
      id: 'warranty-tracker',
      name: 'Warranty Tracker',
      description: 'Remember expiry dates, support contacts, and receipts.',
      iconKey: 'verified_user',
      colorValue: 0xFFDB2777,
      fields: [
        TemplateField(name: 'Product', type: FieldType.text, isRequired: true),
        TemplateField(name: 'Purchase date', type: FieldType.date),
        TemplateField(name: 'Warranty until', type: FieldType.date),
        TemplateField(name: 'Support email', type: FieldType.email),
        TemplateField(name: 'Receipt URL', type: FieldType.url),
      ],
    ),
    ListTemplate(
      id: 'maintenance-log',
      name: 'Maintenance Log',
      description: 'Log service history, schedules, and next reminders.',
      iconKey: 'build_circle',
      colorValue: 0xFFDC2626,
      fields: [
        TemplateField(name: 'Task', type: FieldType.text, isRequired: true),
        TemplateField(name: 'Completed on', type: FieldType.dateTime),
        TemplateField(name: 'Cost', type: FieldType.currency),
        TemplateField(name: 'Vendor phone', type: FieldType.phone),
        TemplateField(name: 'Notes', type: FieldType.multilineText),
      ],
    ),
  ];
}
