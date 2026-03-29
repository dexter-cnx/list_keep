// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_record_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetListRecordModelCollection on Isar {
  IsarCollection<ListRecordModel> get listRecordModels => this.collection();
}

const ListRecordModelSchema = CollectionSchema(
  name: r'ListRecordModel',
  id: -420702561334386822,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'isPinned': PropertySchema(id: 1, name: r'isPinned', type: IsarType.bool),
    r'listId': PropertySchema(id: 2, name: r'listId', type: IsarType.long),
    r'searchIndex': PropertySchema(
      id: 3,
      name: r'searchIndex',
      type: IsarType.string,
    ),
    r'title': PropertySchema(id: 4, name: r'title', type: IsarType.string),
    r'updatedAt': PropertySchema(
      id: 5,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'valuesJson': PropertySchema(
      id: 6,
      name: r'valuesJson',
      type: IsarType.string,
    ),
  },
  estimateSize: _listRecordModelEstimateSize,
  serialize: _listRecordModelSerialize,
  deserialize: _listRecordModelDeserialize,
  deserializeProp: _listRecordModelDeserializeProp,
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
    r'searchIndex': IndexSchema(
      id: 8181981079648667170,
      name: r'searchIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'searchIndex',
          type: IndexType.hash,
          caseSensitive: false,
        ),
      ],
    ),
    r'isPinned': IndexSchema(
      id: 7607338673446676027,
      name: r'isPinned',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isPinned',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _listRecordModelGetId,
  getLinks: _listRecordModelGetLinks,
  attach: _listRecordModelAttach,
  version: '3.1.0+1',
);

int _listRecordModelEstimateSize(
  ListRecordModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.searchIndex.length * 3;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.valuesJson.length * 3;
  return bytesCount;
}

void _listRecordModelSerialize(
  ListRecordModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeBool(offsets[1], object.isPinned);
  writer.writeLong(offsets[2], object.listId);
  writer.writeString(offsets[3], object.searchIndex);
  writer.writeString(offsets[4], object.title);
  writer.writeDateTime(offsets[5], object.updatedAt);
  writer.writeString(offsets[6], object.valuesJson);
}

ListRecordModel _listRecordModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ListRecordModel();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.id = id;
  object.isPinned = reader.readBool(offsets[1]);
  object.listId = reader.readLong(offsets[2]);
  object.searchIndex = reader.readString(offsets[3]);
  object.title = reader.readString(offsets[4]);
  object.updatedAt = reader.readDateTime(offsets[5]);
  object.valuesJson = reader.readString(offsets[6]);
  return object;
}

P _listRecordModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _listRecordModelGetId(ListRecordModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _listRecordModelGetLinks(ListRecordModel object) {
  return [];
}

void _listRecordModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  ListRecordModel object,
) {
  object.id = id;
}

extension ListRecordModelQueryWhereSort
    on QueryBuilder<ListRecordModel, ListRecordModel, QWhere> {
  QueryBuilder<ListRecordModel, ListRecordModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterWhere> anyListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'listId'),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterWhere> anyIsPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isPinned'),
      );
    });
  }
}

extension ListRecordModelQueryWhere
    on QueryBuilder<ListRecordModel, ListRecordModel, QWhereClause> {
  QueryBuilder<ListRecordModel, ListRecordModel, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterWhereClause>
  idNotEqualTo(Id id) {
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

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterWhereClause>
  listIdEqualTo(int listId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'listId', value: [listId]),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterWhereClause>
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

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterWhereClause>
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

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterWhereClause>
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

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterWhereClause>
  listIdBetween(
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

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterWhereClause>
  searchIndexEqualTo(String searchIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'searchIndex',
          value: [searchIndex],
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterWhereClause>
  searchIndexNotEqualTo(String searchIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'searchIndex',
                lower: [],
                upper: [searchIndex],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'searchIndex',
                lower: [searchIndex],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'searchIndex',
                lower: [searchIndex],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'searchIndex',
                lower: [],
                upper: [searchIndex],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterWhereClause>
  isPinnedEqualTo(bool isPinned) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'isPinned', value: [isPinned]),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterWhereClause>
  isPinnedNotEqualTo(bool isPinned) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isPinned',
                lower: [],
                upper: [isPinned],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isPinned',
                lower: [isPinned],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isPinned',
                lower: [isPinned],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isPinned',
                lower: [],
                upper: [isPinned],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension ListRecordModelQueryFilter
    on QueryBuilder<ListRecordModel, ListRecordModel, QFilterCondition> {
  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
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

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
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

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  idBetween(
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

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  isPinnedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isPinned', value: value),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  listIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'listId', value: value),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
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

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
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

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
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

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  searchIndexEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'searchIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  searchIndexGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'searchIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  searchIndexLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'searchIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  searchIndexBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'searchIndex',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  searchIndexStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'searchIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  searchIndexEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'searchIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  searchIndexContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'searchIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  searchIndexMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'searchIndex',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  searchIndexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'searchIndex', value: ''),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  searchIndexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'searchIndex', value: ''),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  titleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'title',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  titleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  titleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'title',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  updatedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  updatedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'updatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  valuesJsonEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'valuesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  valuesJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'valuesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  valuesJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'valuesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  valuesJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'valuesJson',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  valuesJsonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'valuesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  valuesJsonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'valuesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  valuesJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'valuesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  valuesJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'valuesJson',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  valuesJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'valuesJson', value: ''),
      );
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterFilterCondition>
  valuesJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'valuesJson', value: ''),
      );
    });
  }
}

extension ListRecordModelQueryObject
    on QueryBuilder<ListRecordModel, ListRecordModel, QFilterCondition> {}

extension ListRecordModelQueryLinks
    on QueryBuilder<ListRecordModel, ListRecordModel, QFilterCondition> {}

extension ListRecordModelQuerySortBy
    on QueryBuilder<ListRecordModel, ListRecordModel, QSortBy> {
  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  sortByIsPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.asc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  sortByIsPinnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.desc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy> sortByListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listId', Sort.asc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  sortByListIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listId', Sort.desc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  sortBySearchIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchIndex', Sort.asc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  sortBySearchIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchIndex', Sort.desc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  sortByValuesJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuesJson', Sort.asc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  sortByValuesJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuesJson', Sort.desc);
    });
  }
}

extension ListRecordModelQuerySortThenBy
    on QueryBuilder<ListRecordModel, ListRecordModel, QSortThenBy> {
  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  thenByIsPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.asc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  thenByIsPinnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.desc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy> thenByListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listId', Sort.asc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  thenByListIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listId', Sort.desc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  thenBySearchIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchIndex', Sort.asc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  thenBySearchIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchIndex', Sort.desc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  thenByValuesJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuesJson', Sort.asc);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QAfterSortBy>
  thenByValuesJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuesJson', Sort.desc);
    });
  }
}

extension ListRecordModelQueryWhereDistinct
    on QueryBuilder<ListRecordModel, ListRecordModel, QDistinct> {
  QueryBuilder<ListRecordModel, ListRecordModel, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QDistinct>
  distinctByIsPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPinned');
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QDistinct> distinctByListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'listId');
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QDistinct>
  distinctBySearchIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'searchIndex', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QDistinct> distinctByTitle({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<ListRecordModel, ListRecordModel, QDistinct>
  distinctByValuesJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valuesJson', caseSensitive: caseSensitive);
    });
  }
}

extension ListRecordModelQueryProperty
    on QueryBuilder<ListRecordModel, ListRecordModel, QQueryProperty> {
  QueryBuilder<ListRecordModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ListRecordModel, DateTime, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<ListRecordModel, bool, QQueryOperations> isPinnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPinned');
    });
  }

  QueryBuilder<ListRecordModel, int, QQueryOperations> listIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'listId');
    });
  }

  QueryBuilder<ListRecordModel, String, QQueryOperations>
  searchIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'searchIndex');
    });
  }

  QueryBuilder<ListRecordModel, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<ListRecordModel, DateTime, QQueryOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<ListRecordModel, String, QQueryOperations> valuesJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valuesJson');
    });
  }
}
