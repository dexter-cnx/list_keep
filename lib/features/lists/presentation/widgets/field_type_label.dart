import 'package:easy_localization/easy_localization.dart';

import '../../../../domain/entities/field_type.dart';

String fieldTypeLabel(FieldType type) {
  return 'field_type.${type.key}'.tr();
}
