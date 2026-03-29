// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_field_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetListFieldModelCollection on Isar {
  IsarCollection<ListFieldModel> get listFieldModels => this.collection();
}

const ListFieldModelSchema = CollectionSchema(
  name: r'ListFieldModel',
  id: 4105233171142219458,
  properties: {
    r'isRequired': PropertySchema(
      id: 0,
      name: r'isRequired',
      type: IsarType.bool,
    ),
    r'listId': PropertySchema(id: 1, name: r'listId', type: IsarType.long),
    r'name': PropertySchema(id: 2, name: r'name', type: IsarType.string),
    r'optionsJson': PropertySchema(
      id: 3,
      name: r'optionsJson',
      type: IsarType.string,
    ),
    r'sortOrder': PropertySchema(
      id: 4,
      name: r'sortOrder',
      type: IsarType.long,
    ),
    r'typeKey': PropertySchema(id: 5, name: r'typeKey', type: IsarType.string),
  },
  estimateSize: _listFieldModelEstimateSize,
  serialize: _listFieldModelSerialize,
  deserialize: _listFieldModelDeserialize,
  deserializeProp: _listFieldModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'listId': IndexSchema(
      id: -4312380808616005139,
      name: r'listId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'listId',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _listFieldModelGetId,
  getLinks: _listFieldModelGetLinks,
  attach: _listFieldModelAttach,
  version: '3.1.0+1',
);

int _listFieldModelEstimateSize(
  ListFieldModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.optionsJson.length * 3;
  bytesCount += 3 + object.typeKey.length * 3;
  return bytesCount;
}

void _listFieldModelSerialize(
  ListFieldModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isRequired);
  writer.writeLong(offsets[1], object.listId);
  writer.writeString(offsets[2], object.name);
  writer.writeString(offsets[3], object.optionsJson);
  writer.writeLong(offsets[4], object.sortOrder);
  writer.writeString(offsets[5], object.typeKey);
}

ListFieldModel _listFieldModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ListFieldModel();
  object.id = id;
  object.isRequired = reader.readBool(offsets[0]);
  object.listId = reader.readLong(offsets[1]);
  object.name = reader.readString(offsets[2]);
  object.optionsJson = reader.readString(offsets[3]);
  object.sortOrder = reader.readLong(offsets[4]);
  object.typeKey = reader.readString(offsets[5]);
  return object;
}

P _listFieldModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _listFieldModelGetId(ListFieldModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _listFieldModelGetLinks(ListFieldModel object) {
  return [];
}

void _listFieldModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  ListFieldModel object,
) {
  object.id = id;
}

extension ListFieldModelQueryWhereSort
    on QueryBuilder<ListFieldModel, ListFieldModel, QWhere> {
  QueryBuilder<ListFieldModel, ListFieldModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterWhere> anyListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'listId'),
      );
    });
  }
}

extension ListFieldModelQueryWhere
    on QueryBuilder<ListFieldModel, ListFieldModel, QWhereClause> {
  QueryBuilder<ListFieldModel, ListFieldModel, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterWhereClause> listIdEqualTo(
    int listId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'listId', value: [listId]),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterWhereClause>
  listIdNotEqualTo(int listId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'listId',
                lower: [],
                upper: [listId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'listId',
                lower: [listId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'listId',
                lower: [listId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'listId',
                lower: [],
                upper: [listId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterWhereClause>
  listIdGreaterThan(int listId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'listId',
          lower: [listId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterWhereClause>
  listIdLessThan(int listId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'listId',
          lower: [],
          upper: [listId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterWhereClause> listIdBetween(
    int lowerListId,
    int upperListId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'listId',
          lower: [lowerListId],
          includeLower: includeLower,
          upper: [upperListId],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ListFieldModelQueryFilter
    on QueryBuilder<ListFieldModel, ListFieldModel, QFilterCondition> {
  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  isRequiredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isRequired', value: value),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  listIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'listId', value: value),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  listIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'listId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  listIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'listId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  listIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'listId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  nameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  nameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  nameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  optionsJsonEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'optionsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  optionsJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'optionsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  optionsJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'optionsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  optionsJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'optionsJson',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  optionsJsonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'optionsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  optionsJsonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'optionsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  optionsJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'optionsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  optionsJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'optionsJson',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  optionsJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'optionsJson', value: ''),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  optionsJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'optionsJson', value: ''),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  sortOrderEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sortOrder', value: value),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  sortOrderGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sortOrder',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  sortOrderLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sortOrder',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  sortOrderBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sortOrder',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  typeKeyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'typeKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  typeKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'typeKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  typeKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'typeKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  typeKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'typeKey',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  typeKeyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'typeKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  typeKeyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'typeKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  typeKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'typeKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  typeKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'typeKey',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  typeKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'typeKey', value: ''),
      );
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterFilterCondition>
  typeKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'typeKey', value: ''),
      );
    });
  }
}

extension ListFieldModelQueryObject
    on QueryBuilder<ListFieldModel, ListFieldModel, QFilterCondition> {}

extension ListFieldModelQueryLinks
    on QueryBuilder<ListFieldModel, ListFieldModel, QFilterCondition> {}

extension ListFieldModelQuerySortBy
    on QueryBuilder<ListFieldModel, ListFieldModel, QSortBy> {
  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy>
  sortByIsRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRequired', Sort.asc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy>
  sortByIsRequiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRequired', Sort.desc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy> sortByListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listId', Sort.asc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy>
  sortByListIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listId', Sort.desc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy>
  sortByOptionsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionsJson', Sort.asc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy>
  sortByOptionsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionsJson', Sort.desc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy> sortBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.asc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy>
  sortBySortOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.desc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy> sortByTypeKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeKey', Sort.asc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy>
  sortByTypeKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeKey', Sort.desc);
    });
  }
}

extension ListFieldModelQuerySortThenBy
    on QueryBuilder<ListFieldModel, ListFieldModel, QSortThenBy> {
  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy>
  thenByIsRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRequired', Sort.asc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy>
  thenByIsRequiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRequired', Sort.desc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy> thenByListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listId', Sort.asc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy>
  thenByListIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listId', Sort.desc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy>
  thenByOptionsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionsJson', Sort.asc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy>
  thenByOptionsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionsJson', Sort.desc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy> thenBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.asc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy>
  thenBySortOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.desc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy> thenByTypeKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeKey', Sort.asc);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QAfterSortBy>
  thenByTypeKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeKey', Sort.desc);
    });
  }
}

extension ListFieldModelQueryWhereDistinct
    on QueryBuilder<ListFieldModel, ListFieldModel, QDistinct> {
  QueryBuilder<ListFieldModel, ListFieldModel, QDistinct>
  distinctByIsRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRequired');
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QDistinct> distinctByListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'listId');
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QDistinct>
  distinctByOptionsJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'optionsJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QDistinct>
  distinctBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sortOrder');
    });
  }

  QueryBuilder<ListFieldModel, ListFieldModel, QDistinct> distinctByTypeKey({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'typeKey', caseSensitive: caseSensitive);
    });
  }
}

extension ListFieldModelQueryProperty
    on QueryBuilder<ListFieldModel, ListFieldModel, QQueryProperty> {
  QueryBuilder<ListFieldModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ListFieldModel, bool, QQueryOperations> isRequiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRequired');
    });
  }

  QueryBuilder<ListFieldModel, int, QQueryOperations> listIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'listId');
    });
  }

  QueryBuilder<ListFieldModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ListFieldModel, String, QQueryOperations> optionsJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'optionsJson');
    });
  }

  QueryBuilder<ListFieldModel, int, QQueryOperations> sortOrderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sortOrder');
    });
  }

  QueryBuilder<ListFieldModel, String, QQueryOperations> typeKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'typeKey');
    });
  }
}
