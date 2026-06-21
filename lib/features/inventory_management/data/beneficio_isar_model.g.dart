// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficio_isar_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBeneficioIsarModelCollection on Isar {
  IsarCollection<BeneficioIsarModel> get beneficioIsarModels =>
      this.collection();
}

const BeneficioIsarModelSchema = CollectionSchema(
  name: r'BeneficioIsarModel',
  id: 7450458984209709136,
  properties: {
    r'estado': PropertySchema(
      id: 0,
      name: r'estado',
      type: IsarType.byte,
      enumMap: _BeneficioIsarModelestadoEnumValueMap,
    ),
    r'fechaInicio': PropertySchema(
      id: 1,
      name: r'fechaInicio',
      type: IsarType.dateTime,
    ),
    r'fincaId': PropertySchema(
      id: 2,
      name: r'fincaId',
      type: IsarType.long,
    ),
    r'kilosCereza': PropertySchema(
      id: 3,
      name: r'kilosCereza',
      type: IsarType.double,
    ),
    r'kilosFinales': PropertySchema(
      id: 4,
      name: r'kilosFinales',
      type: IsarType.double,
    ),
    r'loteOrigenNombre': PropertySchema(
      id: 5,
      name: r'loteOrigenNombre',
      type: IsarType.string,
    )
  },
  estimateSize: _beneficioIsarModelEstimateSize,
  serialize: _beneficioIsarModelSerialize,
  deserialize: _beneficioIsarModelDeserialize,
  deserializeProp: _beneficioIsarModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _beneficioIsarModelGetId,
  getLinks: _beneficioIsarModelGetLinks,
  attach: _beneficioIsarModelAttach,
  version: '3.1.0+1',
);

int _beneficioIsarModelEstimateSize(
  BeneficioIsarModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.loteOrigenNombre;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _beneficioIsarModelSerialize(
  BeneficioIsarModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.estado.index);
  writer.writeDateTime(offsets[1], object.fechaInicio);
  writer.writeLong(offsets[2], object.fincaId);
  writer.writeDouble(offsets[3], object.kilosCereza);
  writer.writeDouble(offsets[4], object.kilosFinales);
  writer.writeString(offsets[5], object.loteOrigenNombre);
}

BeneficioIsarModel _beneficioIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BeneficioIsarModel();
  object.estado = _BeneficioIsarModelestadoValueEnumMap[
          reader.readByteOrNull(offsets[0])] ??
      EstadoBeneficio.cereza;
  object.fechaInicio = reader.readDateTime(offsets[1]);
  object.fincaId = reader.readLongOrNull(offsets[2]);
  object.id = id;
  object.kilosCereza = reader.readDouble(offsets[3]);
  object.kilosFinales = reader.readDoubleOrNull(offsets[4]);
  object.loteOrigenNombre = reader.readStringOrNull(offsets[5]);
  return object;
}

P _beneficioIsarModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_BeneficioIsarModelestadoValueEnumMap[
              reader.readByteOrNull(offset)] ??
          EstadoBeneficio.cereza) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _BeneficioIsarModelestadoEnumValueMap = {
  'cereza': 0,
  'lavado': 1,
  'secado': 2,
  'listo': 3,
  'vendido': 4,
};
const _BeneficioIsarModelestadoValueEnumMap = {
  0: EstadoBeneficio.cereza,
  1: EstadoBeneficio.lavado,
  2: EstadoBeneficio.secado,
  3: EstadoBeneficio.listo,
  4: EstadoBeneficio.vendido,
};

Id _beneficioIsarModelGetId(BeneficioIsarModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _beneficioIsarModelGetLinks(
    BeneficioIsarModel object) {
  return [];
}

void _beneficioIsarModelAttach(
    IsarCollection<dynamic> col, Id id, BeneficioIsarModel object) {
  object.id = id;
}

extension BeneficioIsarModelQueryWhereSort
    on QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QWhere> {
  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BeneficioIsarModelQueryWhere
    on QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QWhereClause> {
  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterWhereClause>
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

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterWhereClause>
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

extension BeneficioIsarModelQueryFilter
    on QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QFilterCondition> {
  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      estadoEqualTo(EstadoBeneficio value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estado',
        value: value,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      estadoGreaterThan(
    EstadoBeneficio value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estado',
        value: value,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      estadoLessThan(
    EstadoBeneficio value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estado',
        value: value,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      estadoBetween(
    EstadoBeneficio lower,
    EstadoBeneficio upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estado',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      fechaInicioEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaInicio',
        value: value,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      fechaInicioGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaInicio',
        value: value,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      fechaInicioLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaInicio',
        value: value,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      fechaInicioBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaInicio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      fincaIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      fincaIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      fincaIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fincaId',
        value: value,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
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

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
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

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
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

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
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

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
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

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
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

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      kilosCerezaEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kilosCereza',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      kilosCerezaGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kilosCereza',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      kilosCerezaLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kilosCereza',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      kilosCerezaBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kilosCereza',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      kilosFinalesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'kilosFinales',
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      kilosFinalesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'kilosFinales',
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      kilosFinalesEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kilosFinales',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      kilosFinalesGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kilosFinales',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      kilosFinalesLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kilosFinales',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      kilosFinalesBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kilosFinales',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      loteOrigenNombreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'loteOrigenNombre',
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      loteOrigenNombreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'loteOrigenNombre',
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      loteOrigenNombreEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loteOrigenNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      loteOrigenNombreGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loteOrigenNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      loteOrigenNombreLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loteOrigenNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      loteOrigenNombreBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loteOrigenNombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      loteOrigenNombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'loteOrigenNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      loteOrigenNombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'loteOrigenNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      loteOrigenNombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'loteOrigenNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      loteOrigenNombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'loteOrigenNombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      loteOrigenNombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loteOrigenNombre',
        value: '',
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      loteOrigenNombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'loteOrigenNombre',
        value: '',
      ));
    });
  }
}

extension BeneficioIsarModelQueryObject
    on QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QFilterCondition> {}

extension BeneficioIsarModelQueryLinks
    on QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QFilterCondition> {}

extension BeneficioIsarModelQuerySortBy
    on QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QSortBy> {
  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByFechaInicioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByKilosCereza() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilosCereza', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByKilosCerezaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilosCereza', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByKilosFinales() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilosFinales', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByKilosFinalesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilosFinales', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByLoteOrigenNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteOrigenNombre', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByLoteOrigenNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteOrigenNombre', Sort.desc);
    });
  }
}

extension BeneficioIsarModelQuerySortThenBy
    on QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QSortThenBy> {
  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByFechaInicioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByKilosCereza() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilosCereza', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByKilosCerezaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilosCereza', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByKilosFinales() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilosFinales', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByKilosFinalesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilosFinales', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByLoteOrigenNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteOrigenNombre', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByLoteOrigenNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteOrigenNombre', Sort.desc);
    });
  }
}

extension BeneficioIsarModelQueryWhereDistinct
    on QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QDistinct> {
  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QDistinct>
      distinctByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estado');
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QDistinct>
      distinctByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaInicio');
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QDistinct>
      distinctByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fincaId');
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QDistinct>
      distinctByKilosCereza() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kilosCereza');
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QDistinct>
      distinctByKilosFinales() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kilosFinales');
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QDistinct>
      distinctByLoteOrigenNombre({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loteOrigenNombre',
          caseSensitive: caseSensitive);
    });
  }
}

extension BeneficioIsarModelQueryProperty
    on QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QQueryProperty> {
  QueryBuilder<BeneficioIsarModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BeneficioIsarModel, EstadoBeneficio, QQueryOperations>
      estadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estado');
    });
  }

  QueryBuilder<BeneficioIsarModel, DateTime, QQueryOperations>
      fechaInicioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaInicio');
    });
  }

  QueryBuilder<BeneficioIsarModel, int?, QQueryOperations> fincaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fincaId');
    });
  }

  QueryBuilder<BeneficioIsarModel, double, QQueryOperations>
      kilosCerezaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kilosCereza');
    });
  }

  QueryBuilder<BeneficioIsarModel, double?, QQueryOperations>
      kilosFinalesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kilosFinales');
    });
  }

  QueryBuilder<BeneficioIsarModel, String?, QQueryOperations>
      loteOrigenNombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loteOrigenNombre');
    });
  }
}
