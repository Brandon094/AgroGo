// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_costo_isar_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetItemCostoIsarModelCollection on Isar {
  IsarCollection<ItemCostoIsarModel> get itemCostoIsarModels =>
      this.collection();
}

const ItemCostoIsarModelSchema = CollectionSchema(
  name: r'ItemCostoIsarModel',
  id: -7401874801052834564,
  properties: {
    r'categoria': PropertySchema(
      id: 0,
      name: r'categoria',
      type: IsarType.string,
    ),
    r'fechaCompra': PropertySchema(
      id: 1,
      name: r'fechaCompra',
      type: IsarType.dateTime,
    ),
    r'fincaId': PropertySchema(
      id: 2,
      name: r'fincaId',
      type: IsarType.long,
    ),
    r'loteId': PropertySchema(
      id: 3,
      name: r'loteId',
      type: IsarType.long,
    ),
    r'nombreItem': PropertySchema(
      id: 4,
      name: r'nombreItem',
      type: IsarType.string,
    ),
    r'precioTotal': PropertySchema(
      id: 5,
      name: r'precioTotal',
      type: IsarType.double,
    )
  },
  estimateSize: _itemCostoIsarModelEstimateSize,
  serialize: _itemCostoIsarModelSerialize,
  deserialize: _itemCostoIsarModelDeserialize,
  deserializeProp: _itemCostoIsarModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _itemCostoIsarModelGetId,
  getLinks: _itemCostoIsarModelGetLinks,
  attach: _itemCostoIsarModelAttach,
  version: '3.1.0+1',
);

int _itemCostoIsarModelEstimateSize(
  ItemCostoIsarModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.categoria.length * 3;
  bytesCount += 3 + object.nombreItem.length * 3;
  return bytesCount;
}

void _itemCostoIsarModelSerialize(
  ItemCostoIsarModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.categoria);
  writer.writeDateTime(offsets[1], object.fechaCompra);
  writer.writeLong(offsets[2], object.fincaId);
  writer.writeLong(offsets[3], object.loteId);
  writer.writeString(offsets[4], object.nombreItem);
  writer.writeDouble(offsets[5], object.precioTotal);
}

ItemCostoIsarModel _itemCostoIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ItemCostoIsarModel();
  object.categoria = reader.readString(offsets[0]);
  object.fechaCompra = reader.readDateTime(offsets[1]);
  object.fincaId = reader.readLongOrNull(offsets[2]);
  object.id = id;
  object.loteId = reader.readLongOrNull(offsets[3]);
  object.nombreItem = reader.readString(offsets[4]);
  object.precioTotal = reader.readDouble(offsets[5]);
  return object;
}

P _itemCostoIsarModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _itemCostoIsarModelGetId(ItemCostoIsarModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _itemCostoIsarModelGetLinks(
    ItemCostoIsarModel object) {
  return [];
}

void _itemCostoIsarModelAttach(
    IsarCollection<dynamic> col, Id id, ItemCostoIsarModel object) {
  object.id = id;
}

extension ItemCostoIsarModelQueryWhereSort
    on QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QWhere> {
  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ItemCostoIsarModelQueryWhere
    on QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QWhereClause> {
  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterWhereClause>
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

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ItemCostoIsarModelQueryFilter
    on QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QFilterCondition> {
  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      categoriaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      categoriaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      categoriaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      categoriaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoria',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      categoriaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      categoriaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      categoriaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      categoriaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'categoria',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      categoriaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoria',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      categoriaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'categoria',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      fechaCompraEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaCompra',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      fechaCompraGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaCompra',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      fechaCompraLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaCompra',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      fechaCompraBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaCompra',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      fincaIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      fincaIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      fincaIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fincaId',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      fincaIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fincaId',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      fincaIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fincaId',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      fincaIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fincaId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      loteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'loteId',
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      loteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'loteId',
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      loteIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loteId',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      loteIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loteId',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      loteIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loteId',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      loteIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loteId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      nombreItemEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombreItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      nombreItemGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nombreItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      nombreItemLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nombreItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      nombreItemBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nombreItem',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      nombreItemStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nombreItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      nombreItemEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nombreItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      nombreItemContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombreItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      nombreItemMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombreItem',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      nombreItemIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombreItem',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      nombreItemIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombreItem',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      precioTotalEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'precioTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      precioTotalGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'precioTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      precioTotalLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'precioTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterFilterCondition>
      precioTotalBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'precioTotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension ItemCostoIsarModelQueryObject
    on QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QFilterCondition> {}

extension ItemCostoIsarModelQueryLinks
    on QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QFilterCondition> {}

extension ItemCostoIsarModelQuerySortBy
    on QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QSortBy> {
  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      sortByCategoria() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.asc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      sortByCategoriaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.desc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      sortByFechaCompra() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCompra', Sort.asc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      sortByFechaCompraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCompra', Sort.desc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      sortByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      sortByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      sortByLoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.asc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      sortByLoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.desc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      sortByNombreItem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreItem', Sort.asc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      sortByNombreItemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreItem', Sort.desc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      sortByPrecioTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'precioTotal', Sort.asc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      sortByPrecioTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'precioTotal', Sort.desc);
    });
  }
}

extension ItemCostoIsarModelQuerySortThenBy
    on QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QSortThenBy> {
  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      thenByCategoria() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.asc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      thenByCategoriaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.desc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      thenByFechaCompra() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCompra', Sort.asc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      thenByFechaCompraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCompra', Sort.desc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      thenByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      thenByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      thenByLoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.asc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      thenByLoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.desc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      thenByNombreItem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreItem', Sort.asc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      thenByNombreItemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreItem', Sort.desc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      thenByPrecioTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'precioTotal', Sort.asc);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QAfterSortBy>
      thenByPrecioTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'precioTotal', Sort.desc);
    });
  }
}

extension ItemCostoIsarModelQueryWhereDistinct
    on QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QDistinct> {
  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QDistinct>
      distinctByCategoria({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoria', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QDistinct>
      distinctByFechaCompra() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaCompra');
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QDistinct>
      distinctByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fincaId');
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QDistinct>
      distinctByLoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loteId');
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QDistinct>
      distinctByNombreItem({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombreItem', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QDistinct>
      distinctByPrecioTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'precioTotal');
    });
  }
}

extension ItemCostoIsarModelQueryProperty
    on QueryBuilder<ItemCostoIsarModel, ItemCostoIsarModel, QQueryProperty> {
  QueryBuilder<ItemCostoIsarModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ItemCostoIsarModel, String, QQueryOperations>
      categoriaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoria');
    });
  }

  QueryBuilder<ItemCostoIsarModel, DateTime, QQueryOperations>
      fechaCompraProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaCompra');
    });
  }

  QueryBuilder<ItemCostoIsarModel, int?, QQueryOperations> fincaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fincaId');
    });
  }

  QueryBuilder<ItemCostoIsarModel, int?, QQueryOperations> loteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loteId');
    });
  }

  QueryBuilder<ItemCostoIsarModel, String, QQueryOperations>
      nombreItemProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombreItem');
    });
  }

  QueryBuilder<ItemCostoIsarModel, double, QQueryOperations>
      precioTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'precioTotal');
    });
  }
}
