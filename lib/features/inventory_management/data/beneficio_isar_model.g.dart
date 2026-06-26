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
    r'beneficiaderoId': PropertySchema(
      id: 0,
      name: r'beneficiaderoId',
      type: IsarType.long,
    ),
    r'beneficiaderoNombre': PropertySchema(
      id: 1,
      name: r'beneficiaderoNombre',
      type: IsarType.string,
    ),
    r'costoProcesamiento': PropertySchema(
      id: 2,
      name: r'costoProcesamiento',
      type: IsarType.double,
    ),
    r'estaMolido': PropertySchema(
      id: 3,
      name: r'estaMolido',
      type: IsarType.bool,
    ),
    r'estaTostado': PropertySchema(
      id: 4,
      name: r'estaTostado',
      type: IsarType.bool,
    ),
    r'estado': PropertySchema(
      id: 5,
      name: r'estado',
      type: IsarType.byte,
      enumMap: _BeneficioIsarModelestadoEnumValueMap,
    ),
    r'fechaInicio': PropertySchema(
      id: 6,
      name: r'fechaInicio',
      type: IsarType.dateTime,
    ),
    r'fincaId': PropertySchema(
      id: 7,
      name: r'fincaId',
      type: IsarType.long,
    ),
    r'kilosCereza': PropertySchema(
      id: 8,
      name: r'kilosCereza',
      type: IsarType.double,
    ),
    r'kilosFinales': PropertySchema(
      id: 9,
      name: r'kilosFinales',
      type: IsarType.double,
    ),
    r'loteOrigenNombre': PropertySchema(
      id: 10,
      name: r'loteOrigenNombre',
      type: IsarType.string,
    ),
    r'secaderoId': PropertySchema(
      id: 11,
      name: r'secaderoId',
      type: IsarType.long,
    ),
    r'secaderoNombre': PropertySchema(
      id: 12,
      name: r'secaderoNombre',
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
    final value = object.beneficiaderoNombre;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.loteOrigenNombre;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.secaderoNombre;
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
  writer.writeLong(offsets[0], object.beneficiaderoId);
  writer.writeString(offsets[1], object.beneficiaderoNombre);
  writer.writeDouble(offsets[2], object.costoProcesamiento);
  writer.writeBool(offsets[3], object.estaMolido);
  writer.writeBool(offsets[4], object.estaTostado);
  writer.writeByte(offsets[5], object.estado.index);
  writer.writeDateTime(offsets[6], object.fechaInicio);
  writer.writeLong(offsets[7], object.fincaId);
  writer.writeDouble(offsets[8], object.kilosCereza);
  writer.writeDouble(offsets[9], object.kilosFinales);
  writer.writeString(offsets[10], object.loteOrigenNombre);
  writer.writeLong(offsets[11], object.secaderoId);
  writer.writeString(offsets[12], object.secaderoNombre);
}

BeneficioIsarModel _beneficioIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BeneficioIsarModel();
  object.beneficiaderoId = reader.readLongOrNull(offsets[0]);
  object.beneficiaderoNombre = reader.readStringOrNull(offsets[1]);
  object.costoProcesamiento = reader.readDouble(offsets[2]);
  object.estaMolido = reader.readBool(offsets[3]);
  object.estaTostado = reader.readBool(offsets[4]);
  object.estado = _BeneficioIsarModelestadoValueEnumMap[
          reader.readByteOrNull(offsets[5])] ??
      EstadoBeneficio.cereza;
  object.fechaInicio = reader.readDateTime(offsets[6]);
  object.fincaId = reader.readLongOrNull(offsets[7]);
  object.id = id;
  object.kilosCereza = reader.readDouble(offsets[8]);
  object.kilosFinales = reader.readDoubleOrNull(offsets[9]);
  object.loteOrigenNombre = reader.readStringOrNull(offsets[10]);
  object.secaderoId = reader.readLongOrNull(offsets[11]);
  object.secaderoNombre = reader.readStringOrNull(offsets[12]);
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
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (_BeneficioIsarModelestadoValueEnumMap[
              reader.readByteOrNull(offset)] ??
          EstadoBeneficio.cereza) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readDouble(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readLongOrNull(offset)) as P;
    case 12:
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
  'tostado': 4,
  'molido': 5,
  'vendido': 6,
};
const _BeneficioIsarModelestadoValueEnumMap = {
  0: EstadoBeneficio.cereza,
  1: EstadoBeneficio.lavado,
  2: EstadoBeneficio.secado,
  3: EstadoBeneficio.listo,
  4: EstadoBeneficio.tostado,
  5: EstadoBeneficio.molido,
  6: EstadoBeneficio.vendido,
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
      beneficiaderoIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'beneficiaderoId',
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      beneficiaderoIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'beneficiaderoId',
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      beneficiaderoIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'beneficiaderoId',
        value: value,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      beneficiaderoIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'beneficiaderoId',
        value: value,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      beneficiaderoIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'beneficiaderoId',
        value: value,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      beneficiaderoIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'beneficiaderoId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      beneficiaderoNombreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'beneficiaderoNombre',
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      beneficiaderoNombreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'beneficiaderoNombre',
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      beneficiaderoNombreEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'beneficiaderoNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      beneficiaderoNombreGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'beneficiaderoNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      beneficiaderoNombreLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'beneficiaderoNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      beneficiaderoNombreBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'beneficiaderoNombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      beneficiaderoNombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'beneficiaderoNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      beneficiaderoNombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'beneficiaderoNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      beneficiaderoNombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'beneficiaderoNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      beneficiaderoNombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'beneficiaderoNombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      beneficiaderoNombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'beneficiaderoNombre',
        value: '',
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      beneficiaderoNombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'beneficiaderoNombre',
        value: '',
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      costoProcesamientoEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'costoProcesamiento',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      costoProcesamientoGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'costoProcesamiento',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      costoProcesamientoLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'costoProcesamiento',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      costoProcesamientoBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'costoProcesamiento',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      estaMolidoEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estaMolido',
        value: value,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      estaTostadoEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estaTostado',
        value: value,
      ));
    });
  }

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

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      secaderoIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'secaderoId',
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      secaderoIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'secaderoId',
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      secaderoIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secaderoId',
        value: value,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      secaderoIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'secaderoId',
        value: value,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      secaderoIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'secaderoId',
        value: value,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      secaderoIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'secaderoId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      secaderoNombreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'secaderoNombre',
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      secaderoNombreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'secaderoNombre',
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      secaderoNombreEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secaderoNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      secaderoNombreGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'secaderoNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      secaderoNombreLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'secaderoNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      secaderoNombreBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'secaderoNombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      secaderoNombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'secaderoNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      secaderoNombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'secaderoNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      secaderoNombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'secaderoNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      secaderoNombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'secaderoNombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      secaderoNombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secaderoNombre',
        value: '',
      ));
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterFilterCondition>
      secaderoNombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'secaderoNombre',
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
      sortByBeneficiaderoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'beneficiaderoId', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByBeneficiaderoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'beneficiaderoId', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByBeneficiaderoNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'beneficiaderoNombre', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByBeneficiaderoNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'beneficiaderoNombre', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByCostoProcesamiento() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costoProcesamiento', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByCostoProcesamientoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costoProcesamiento', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByEstaMolido() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estaMolido', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByEstaMolidoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estaMolido', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByEstaTostado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estaTostado', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortByEstaTostadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estaTostado', Sort.desc);
    });
  }

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

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortBySecaderoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secaderoId', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortBySecaderoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secaderoId', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortBySecaderoNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secaderoNombre', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      sortBySecaderoNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secaderoNombre', Sort.desc);
    });
  }
}

extension BeneficioIsarModelQuerySortThenBy
    on QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QSortThenBy> {
  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByBeneficiaderoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'beneficiaderoId', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByBeneficiaderoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'beneficiaderoId', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByBeneficiaderoNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'beneficiaderoNombre', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByBeneficiaderoNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'beneficiaderoNombre', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByCostoProcesamiento() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costoProcesamiento', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByCostoProcesamientoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costoProcesamiento', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByEstaMolido() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estaMolido', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByEstaMolidoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estaMolido', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByEstaTostado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estaTostado', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenByEstaTostadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estaTostado', Sort.desc);
    });
  }

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

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenBySecaderoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secaderoId', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenBySecaderoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secaderoId', Sort.desc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenBySecaderoNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secaderoNombre', Sort.asc);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QAfterSortBy>
      thenBySecaderoNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secaderoNombre', Sort.desc);
    });
  }
}

extension BeneficioIsarModelQueryWhereDistinct
    on QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QDistinct> {
  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QDistinct>
      distinctByBeneficiaderoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'beneficiaderoId');
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QDistinct>
      distinctByBeneficiaderoNombre({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'beneficiaderoNombre',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QDistinct>
      distinctByCostoProcesamiento() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'costoProcesamiento');
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QDistinct>
      distinctByEstaMolido() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estaMolido');
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QDistinct>
      distinctByEstaTostado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estaTostado');
    });
  }

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

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QDistinct>
      distinctBySecaderoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'secaderoId');
    });
  }

  QueryBuilder<BeneficioIsarModel, BeneficioIsarModel, QDistinct>
      distinctBySecaderoNombre({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'secaderoNombre',
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

  QueryBuilder<BeneficioIsarModel, int?, QQueryOperations>
      beneficiaderoIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'beneficiaderoId');
    });
  }

  QueryBuilder<BeneficioIsarModel, String?, QQueryOperations>
      beneficiaderoNombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'beneficiaderoNombre');
    });
  }

  QueryBuilder<BeneficioIsarModel, double, QQueryOperations>
      costoProcesamientoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'costoProcesamiento');
    });
  }

  QueryBuilder<BeneficioIsarModel, bool, QQueryOperations>
      estaMolidoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estaMolido');
    });
  }

  QueryBuilder<BeneficioIsarModel, bool, QQueryOperations>
      estaTostadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estaTostado');
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

  QueryBuilder<BeneficioIsarModel, int?, QQueryOperations>
      secaderoIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'secaderoId');
    });
  }

  QueryBuilder<BeneficioIsarModel, String?, QQueryOperations>
      secaderoNombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'secaderoNombre');
    });
  }
}
