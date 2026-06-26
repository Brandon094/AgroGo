// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adelanto_isar_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAdelantoIsarModelCollection on Isar {
  IsarCollection<AdelantoIsarModel> get adelantoIsarModels => this.collection();
}

const AdelantoIsarModelSchema = CollectionSchema(
  name: r'AdelantoIsarModel',
  id: -1239317775193256228,
  properties: {
    r'fecha': PropertySchema(
      id: 0,
      name: r'fecha',
      type: IsarType.dateTime,
    ),
    r'fincaId': PropertySchema(
      id: 1,
      name: r'fincaId',
      type: IsarType.long,
    ),
    r'monto': PropertySchema(
      id: 2,
      name: r'monto',
      type: IsarType.double,
    ),
    r'motivo': PropertySchema(
      id: 3,
      name: r'motivo',
      type: IsarType.string,
    ),
    r'pagado': PropertySchema(
      id: 4,
      name: r'pagado',
      type: IsarType.bool,
    ),
    r'trabajadorId': PropertySchema(
      id: 5,
      name: r'trabajadorId',
      type: IsarType.long,
    )
  },
  estimateSize: _adelantoIsarModelEstimateSize,
  serialize: _adelantoIsarModelSerialize,
  deserialize: _adelantoIsarModelDeserialize,
  deserializeProp: _adelantoIsarModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _adelantoIsarModelGetId,
  getLinks: _adelantoIsarModelGetLinks,
  attach: _adelantoIsarModelAttach,
  version: '3.1.0+1',
);

int _adelantoIsarModelEstimateSize(
  AdelantoIsarModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.motivo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _adelantoIsarModelSerialize(
  AdelantoIsarModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.fecha);
  writer.writeLong(offsets[1], object.fincaId);
  writer.writeDouble(offsets[2], object.monto);
  writer.writeString(offsets[3], object.motivo);
  writer.writeBool(offsets[4], object.pagado);
  writer.writeLong(offsets[5], object.trabajadorId);
}

AdelantoIsarModel _adelantoIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AdelantoIsarModel();
  object.fecha = reader.readDateTime(offsets[0]);
  object.fincaId = reader.readLongOrNull(offsets[1]);
  object.id = id;
  object.monto = reader.readDouble(offsets[2]);
  object.motivo = reader.readStringOrNull(offsets[3]);
  object.pagado = reader.readBool(offsets[4]);
  object.trabajadorId = reader.readLong(offsets[5]);
  return object;
}

P _adelantoIsarModelDeserializeProp<P>(
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
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _adelantoIsarModelGetId(AdelantoIsarModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _adelantoIsarModelGetLinks(
    AdelantoIsarModel object) {
  return [];
}

void _adelantoIsarModelAttach(
    IsarCollection<dynamic> col, Id id, AdelantoIsarModel object) {
  object.id = id;
}

extension AdelantoIsarModelQueryWhereSort
    on QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QWhere> {
  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AdelantoIsarModelQueryWhere
    on QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QWhereClause> {
  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterWhereClause>
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

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterWhereClause>
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

extension AdelantoIsarModelQueryFilter
    on QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QFilterCondition> {
  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      fechaEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      fechaGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      fechaLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      fechaBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fecha',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      fincaIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      fincaIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      fincaIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fincaId',
        value: value,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      montoEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monto',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      montoGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'monto',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      montoLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'monto',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      montoBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'monto',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      motivoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motivo',
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      motivoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motivo',
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      motivoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      motivoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'motivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      motivoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'motivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      motivoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'motivo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      motivoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'motivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      motivoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'motivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      motivoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'motivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      motivoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'motivo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      motivoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivo',
        value: '',
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      motivoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motivo',
        value: '',
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      pagadoEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pagado',
        value: value,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      trabajadorIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trabajadorId',
        value: value,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      trabajadorIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trabajadorId',
        value: value,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      trabajadorIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trabajadorId',
        value: value,
      ));
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterFilterCondition>
      trabajadorIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trabajadorId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AdelantoIsarModelQueryObject
    on QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QFilterCondition> {}

extension AdelantoIsarModelQueryLinks
    on QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QFilterCondition> {}

extension AdelantoIsarModelQuerySortBy
    on QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QSortBy> {
  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      sortByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      sortByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      sortByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      sortByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      sortByMonto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monto', Sort.asc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      sortByMontoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monto', Sort.desc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      sortByMotivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivo', Sort.asc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      sortByMotivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivo', Sort.desc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      sortByPagado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pagado', Sort.asc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      sortByPagadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pagado', Sort.desc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      sortByTrabajadorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajadorId', Sort.asc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      sortByTrabajadorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajadorId', Sort.desc);
    });
  }
}

extension AdelantoIsarModelQuerySortThenBy
    on QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QSortThenBy> {
  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      thenByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      thenByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      thenByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      thenByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      thenByMonto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monto', Sort.asc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      thenByMontoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monto', Sort.desc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      thenByMotivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivo', Sort.asc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      thenByMotivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivo', Sort.desc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      thenByPagado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pagado', Sort.asc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      thenByPagadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pagado', Sort.desc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      thenByTrabajadorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajadorId', Sort.asc);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QAfterSortBy>
      thenByTrabajadorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajadorId', Sort.desc);
    });
  }
}

extension AdelantoIsarModelQueryWhereDistinct
    on QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QDistinct> {
  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QDistinct>
      distinctByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fecha');
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QDistinct>
      distinctByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fincaId');
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QDistinct>
      distinctByMonto() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monto');
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QDistinct>
      distinctByMotivo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QDistinct>
      distinctByPagado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pagado');
    });
  }

  QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QDistinct>
      distinctByTrabajadorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trabajadorId');
    });
  }
}

extension AdelantoIsarModelQueryProperty
    on QueryBuilder<AdelantoIsarModel, AdelantoIsarModel, QQueryProperty> {
  QueryBuilder<AdelantoIsarModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AdelantoIsarModel, DateTime, QQueryOperations> fechaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fecha');
    });
  }

  QueryBuilder<AdelantoIsarModel, int?, QQueryOperations> fincaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fincaId');
    });
  }

  QueryBuilder<AdelantoIsarModel, double, QQueryOperations> montoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monto');
    });
  }

  QueryBuilder<AdelantoIsarModel, String?, QQueryOperations> motivoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivo');
    });
  }

  QueryBuilder<AdelantoIsarModel, bool, QQueryOperations> pagadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pagado');
    });
  }

  QueryBuilder<AdelantoIsarModel, int, QQueryOperations>
      trabajadorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trabajadorId');
    });
  }
}
