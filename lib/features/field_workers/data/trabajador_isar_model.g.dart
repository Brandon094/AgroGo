// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trabajador_isar_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTrabajadorIsarModelCollection on Isar {
  IsarCollection<TrabajadorIsarModel> get trabajadorIsarModels =>
      this.collection();
}

const TrabajadorIsarModelSchema = CollectionSchema(
  name: r'TrabajadorIsarModel',
  id: -3740996394879744344,
  properties: {
    r'fechaIngreso': PropertySchema(
      id: 0,
      name: r'fechaIngreso',
      type: IsarType.dateTime,
    ),
    r'fincaId': PropertySchema(
      id: 1,
      name: r'fincaId',
      type: IsarType.long,
    ),
    r'nombreCompleto': PropertySchema(
      id: 2,
      name: r'nombreCompleto',
      type: IsarType.string,
    ),
    r'tarifaBase': PropertySchema(
      id: 3,
      name: r'tarifaBase',
      type: IsarType.double,
    ),
    r'tipoTrabajador': PropertySchema(
      id: 4,
      name: r'tipoTrabajador',
      type: IsarType.string,
    )
  },
  estimateSize: _trabajadorIsarModelEstimateSize,
  serialize: _trabajadorIsarModelSerialize,
  deserialize: _trabajadorIsarModelDeserialize,
  deserializeProp: _trabajadorIsarModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _trabajadorIsarModelGetId,
  getLinks: _trabajadorIsarModelGetLinks,
  attach: _trabajadorIsarModelAttach,
  version: '3.1.0+1',
);

int _trabajadorIsarModelEstimateSize(
  TrabajadorIsarModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nombreCompleto.length * 3;
  bytesCount += 3 + object.tipoTrabajador.length * 3;
  return bytesCount;
}

void _trabajadorIsarModelSerialize(
  TrabajadorIsarModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.fechaIngreso);
  writer.writeLong(offsets[1], object.fincaId);
  writer.writeString(offsets[2], object.nombreCompleto);
  writer.writeDouble(offsets[3], object.tarifaBase);
  writer.writeString(offsets[4], object.tipoTrabajador);
}

TrabajadorIsarModel _trabajadorIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TrabajadorIsarModel();
  object.fechaIngreso = reader.readDateTime(offsets[0]);
  object.fincaId = reader.readLongOrNull(offsets[1]);
  object.id = id;
  object.nombreCompleto = reader.readString(offsets[2]);
  object.tarifaBase = reader.readDouble(offsets[3]);
  object.tipoTrabajador = reader.readString(offsets[4]);
  return object;
}

P _trabajadorIsarModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _trabajadorIsarModelGetId(TrabajadorIsarModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _trabajadorIsarModelGetLinks(
    TrabajadorIsarModel object) {
  return [];
}

void _trabajadorIsarModelAttach(
    IsarCollection<dynamic> col, Id id, TrabajadorIsarModel object) {
  object.id = id;
}

extension TrabajadorIsarModelQueryWhereSort
    on QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QWhere> {
  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TrabajadorIsarModelQueryWhere
    on QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QWhereClause> {
  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterWhereClause>
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

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterWhereClause>
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

extension TrabajadorIsarModelQueryFilter on QueryBuilder<TrabajadorIsarModel,
    TrabajadorIsarModel, QFilterCondition> {
  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      fechaIngresoEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaIngreso',
        value: value,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      fechaIngresoGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaIngreso',
        value: value,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      fechaIngresoLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaIngreso',
        value: value,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      fechaIngresoBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaIngreso',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      fincaIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      fincaIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      fincaIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fincaId',
        value: value,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
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

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
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

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
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

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
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

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
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

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
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

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      nombreCompletoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombreCompleto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      nombreCompletoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nombreCompleto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      nombreCompletoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nombreCompleto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      nombreCompletoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nombreCompleto',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      nombreCompletoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nombreCompleto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      nombreCompletoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nombreCompleto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      nombreCompletoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombreCompleto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      nombreCompletoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombreCompleto',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      nombreCompletoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombreCompleto',
        value: '',
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      nombreCompletoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombreCompleto',
        value: '',
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      tarifaBaseEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tarifaBase',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      tarifaBaseGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tarifaBase',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      tarifaBaseLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tarifaBase',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      tarifaBaseBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tarifaBase',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      tipoTrabajadorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoTrabajador',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      tipoTrabajadorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipoTrabajador',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      tipoTrabajadorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipoTrabajador',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      tipoTrabajadorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipoTrabajador',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      tipoTrabajadorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tipoTrabajador',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      tipoTrabajadorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tipoTrabajador',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      tipoTrabajadorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipoTrabajador',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      tipoTrabajadorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipoTrabajador',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      tipoTrabajadorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoTrabajador',
        value: '',
      ));
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterFilterCondition>
      tipoTrabajadorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoTrabajador',
        value: '',
      ));
    });
  }
}

extension TrabajadorIsarModelQueryObject on QueryBuilder<TrabajadorIsarModel,
    TrabajadorIsarModel, QFilterCondition> {}

extension TrabajadorIsarModelQueryLinks on QueryBuilder<TrabajadorIsarModel,
    TrabajadorIsarModel, QFilterCondition> {}

extension TrabajadorIsarModelQuerySortBy
    on QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QSortBy> {
  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      sortByFechaIngreso() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaIngreso', Sort.asc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      sortByFechaIngresoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaIngreso', Sort.desc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      sortByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      sortByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      sortByNombreCompleto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreCompleto', Sort.asc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      sortByNombreCompletoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreCompleto', Sort.desc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      sortByTarifaBase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tarifaBase', Sort.asc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      sortByTarifaBaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tarifaBase', Sort.desc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      sortByTipoTrabajador() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoTrabajador', Sort.asc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      sortByTipoTrabajadorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoTrabajador', Sort.desc);
    });
  }
}

extension TrabajadorIsarModelQuerySortThenBy
    on QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QSortThenBy> {
  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      thenByFechaIngreso() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaIngreso', Sort.asc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      thenByFechaIngresoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaIngreso', Sort.desc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      thenByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      thenByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      thenByNombreCompleto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreCompleto', Sort.asc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      thenByNombreCompletoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreCompleto', Sort.desc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      thenByTarifaBase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tarifaBase', Sort.asc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      thenByTarifaBaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tarifaBase', Sort.desc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      thenByTipoTrabajador() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoTrabajador', Sort.asc);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QAfterSortBy>
      thenByTipoTrabajadorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoTrabajador', Sort.desc);
    });
  }
}

extension TrabajadorIsarModelQueryWhereDistinct
    on QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QDistinct> {
  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QDistinct>
      distinctByFechaIngreso() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaIngreso');
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QDistinct>
      distinctByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fincaId');
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QDistinct>
      distinctByNombreCompleto({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombreCompleto',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QDistinct>
      distinctByTarifaBase() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tarifaBase');
    });
  }

  QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QDistinct>
      distinctByTipoTrabajador({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoTrabajador',
          caseSensitive: caseSensitive);
    });
  }
}

extension TrabajadorIsarModelQueryProperty
    on QueryBuilder<TrabajadorIsarModel, TrabajadorIsarModel, QQueryProperty> {
  QueryBuilder<TrabajadorIsarModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TrabajadorIsarModel, DateTime, QQueryOperations>
      fechaIngresoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaIngreso');
    });
  }

  QueryBuilder<TrabajadorIsarModel, int?, QQueryOperations> fincaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fincaId');
    });
  }

  QueryBuilder<TrabajadorIsarModel, String, QQueryOperations>
      nombreCompletoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombreCompleto');
    });
  }

  QueryBuilder<TrabajadorIsarModel, double, QQueryOperations>
      tarifaBaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tarifaBase');
    });
  }

  QueryBuilder<TrabajadorIsarModel, String, QQueryOperations>
      tipoTrabajadorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoTrabajador');
    });
  }
}
