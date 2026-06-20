// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registro_labor_isar_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRegistroLaborIsarModelCollection on Isar {
  IsarCollection<RegistroLaborIsarModel> get registroLaborIsarModels =>
      this.collection();
}

const RegistroLaborIsarModelSchema = CollectionSchema(
  name: r'RegistroLaborIsarModel',
  id: -3703910323857833448,
  properties: {
    r'cantidadKilos': PropertySchema(
      id: 0,
      name: r'cantidadKilos',
      type: IsarType.double,
    ),
    r'fechaRegistro': PropertySchema(
      id: 1,
      name: r'fechaRegistro',
      type: IsarType.dateTime,
    ),
    r'fincaId': PropertySchema(
      id: 2,
      name: r'fincaId',
      type: IsarType.long,
    ),
    r'incluyeAlimentacion': PropertySchema(
      id: 3,
      name: r'incluyeAlimentacion',
      type: IsarType.bool,
    ),
    r'loteId': PropertySchema(
      id: 4,
      name: r'loteId',
      type: IsarType.long,
    ),
    r'tipoPago': PropertySchema(
      id: 5,
      name: r'tipoPago',
      type: IsarType.string,
    ),
    r'totalPagar': PropertySchema(
      id: 6,
      name: r'totalPagar',
      type: IsarType.double,
    ),
    r'trabajadorId': PropertySchema(
      id: 7,
      name: r'trabajadorId',
      type: IsarType.long,
    )
  },
  estimateSize: _registroLaborIsarModelEstimateSize,
  serialize: _registroLaborIsarModelSerialize,
  deserialize: _registroLaborIsarModelDeserialize,
  deserializeProp: _registroLaborIsarModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _registroLaborIsarModelGetId,
  getLinks: _registroLaborIsarModelGetLinks,
  attach: _registroLaborIsarModelAttach,
  version: '3.1.0+1',
);

int _registroLaborIsarModelEstimateSize(
  RegistroLaborIsarModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.tipoPago.length * 3;
  return bytesCount;
}

void _registroLaborIsarModelSerialize(
  RegistroLaborIsarModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.cantidadKilos);
  writer.writeDateTime(offsets[1], object.fechaRegistro);
  writer.writeLong(offsets[2], object.fincaId);
  writer.writeBool(offsets[3], object.incluyeAlimentacion);
  writer.writeLong(offsets[4], object.loteId);
  writer.writeString(offsets[5], object.tipoPago);
  writer.writeDouble(offsets[6], object.totalPagar);
  writer.writeLong(offsets[7], object.trabajadorId);
}

RegistroLaborIsarModel _registroLaborIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RegistroLaborIsarModel();
  object.cantidadKilos = reader.readDoubleOrNull(offsets[0]);
  object.fechaRegistro = reader.readDateTime(offsets[1]);
  object.fincaId = reader.readLongOrNull(offsets[2]);
  object.id = id;
  object.incluyeAlimentacion = reader.readBool(offsets[3]);
  object.loteId = reader.readLong(offsets[4]);
  object.tipoPago = reader.readString(offsets[5]);
  object.totalPagar = reader.readDouble(offsets[6]);
  object.trabajadorId = reader.readLong(offsets[7]);
  return object;
}

P _registroLaborIsarModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _registroLaborIsarModelGetId(RegistroLaborIsarModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _registroLaborIsarModelGetLinks(
    RegistroLaborIsarModel object) {
  return [];
}

void _registroLaborIsarModelAttach(
    IsarCollection<dynamic> col, Id id, RegistroLaborIsarModel object) {
  object.id = id;
}

extension RegistroLaborIsarModelQueryWhereSort
    on QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QWhere> {
  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RegistroLaborIsarModelQueryWhere on QueryBuilder<
    RegistroLaborIsarModel, RegistroLaborIsarModel, QWhereClause> {
  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterWhereClause> idBetween(
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

extension RegistroLaborIsarModelQueryFilter on QueryBuilder<
    RegistroLaborIsarModel, RegistroLaborIsarModel, QFilterCondition> {
  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> cantidadKilosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cantidadKilos',
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> cantidadKilosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cantidadKilos',
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> cantidadKilosEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantidadKilos',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> cantidadKilosGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cantidadKilos',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> cantidadKilosLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cantidadKilos',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> cantidadKilosBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cantidadKilos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> fechaRegistroEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaRegistro',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> fechaRegistroGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaRegistro',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> fechaRegistroLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaRegistro',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> fechaRegistroBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaRegistro',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> fincaIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> fincaIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> fincaIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fincaId',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> fincaIdGreaterThan(
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

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> fincaIdLessThan(
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

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> fincaIdBetween(
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

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> incluyeAlimentacionEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'incluyeAlimentacion',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> loteIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loteId',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> loteIdGreaterThan(
    int value, {
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

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> loteIdLessThan(
    int value, {
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

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> loteIdBetween(
    int lower,
    int upper, {
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

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> tipoPagoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> tipoPagoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> tipoPagoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> tipoPagoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipoPago',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> tipoPagoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tipoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> tipoPagoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tipoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
          QAfterFilterCondition>
      tipoPagoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
          QAfterFilterCondition>
      tipoPagoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipoPago',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> tipoPagoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoPago',
        value: '',
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> tipoPagoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoPago',
        value: '',
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> totalPagarEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalPagar',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> totalPagarGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalPagar',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> totalPagarLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalPagar',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> totalPagarBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalPagar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> trabajadorIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trabajadorId',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> trabajadorIdGreaterThan(
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

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> trabajadorIdLessThan(
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

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel,
      QAfterFilterCondition> trabajadorIdBetween(
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

extension RegistroLaborIsarModelQueryObject on QueryBuilder<
    RegistroLaborIsarModel, RegistroLaborIsarModel, QFilterCondition> {}

extension RegistroLaborIsarModelQueryLinks on QueryBuilder<
    RegistroLaborIsarModel, RegistroLaborIsarModel, QFilterCondition> {}

extension RegistroLaborIsarModelQuerySortBy
    on QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QSortBy> {
  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      sortByCantidadKilos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadKilos', Sort.asc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      sortByCantidadKilosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadKilos', Sort.desc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      sortByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.asc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      sortByFechaRegistroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.desc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      sortByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      sortByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      sortByIncluyeAlimentacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incluyeAlimentacion', Sort.asc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      sortByIncluyeAlimentacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incluyeAlimentacion', Sort.desc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      sortByLoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.asc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      sortByLoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.desc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      sortByTipoPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoPago', Sort.asc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      sortByTipoPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoPago', Sort.desc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      sortByTotalPagar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPagar', Sort.asc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      sortByTotalPagarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPagar', Sort.desc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      sortByTrabajadorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajadorId', Sort.asc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      sortByTrabajadorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajadorId', Sort.desc);
    });
  }
}

extension RegistroLaborIsarModelQuerySortThenBy on QueryBuilder<
    RegistroLaborIsarModel, RegistroLaborIsarModel, QSortThenBy> {
  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      thenByCantidadKilos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadKilos', Sort.asc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      thenByCantidadKilosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadKilos', Sort.desc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      thenByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.asc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      thenByFechaRegistroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.desc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      thenByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      thenByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      thenByIncluyeAlimentacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incluyeAlimentacion', Sort.asc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      thenByIncluyeAlimentacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incluyeAlimentacion', Sort.desc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      thenByLoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.asc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      thenByLoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.desc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      thenByTipoPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoPago', Sort.asc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      thenByTipoPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoPago', Sort.desc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      thenByTotalPagar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPagar', Sort.asc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      thenByTotalPagarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPagar', Sort.desc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      thenByTrabajadorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajadorId', Sort.asc);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QAfterSortBy>
      thenByTrabajadorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajadorId', Sort.desc);
    });
  }
}

extension RegistroLaborIsarModelQueryWhereDistinct
    on QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QDistinct> {
  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QDistinct>
      distinctByCantidadKilos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cantidadKilos');
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QDistinct>
      distinctByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaRegistro');
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QDistinct>
      distinctByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fincaId');
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QDistinct>
      distinctByIncluyeAlimentacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'incluyeAlimentacion');
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QDistinct>
      distinctByLoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loteId');
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QDistinct>
      distinctByTipoPago({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoPago', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QDistinct>
      distinctByTotalPagar() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalPagar');
    });
  }

  QueryBuilder<RegistroLaborIsarModel, RegistroLaborIsarModel, QDistinct>
      distinctByTrabajadorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trabajadorId');
    });
  }
}

extension RegistroLaborIsarModelQueryProperty on QueryBuilder<
    RegistroLaborIsarModel, RegistroLaborIsarModel, QQueryProperty> {
  QueryBuilder<RegistroLaborIsarModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RegistroLaborIsarModel, double?, QQueryOperations>
      cantidadKilosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cantidadKilos');
    });
  }

  QueryBuilder<RegistroLaborIsarModel, DateTime, QQueryOperations>
      fechaRegistroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaRegistro');
    });
  }

  QueryBuilder<RegistroLaborIsarModel, int?, QQueryOperations>
      fincaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fincaId');
    });
  }

  QueryBuilder<RegistroLaborIsarModel, bool, QQueryOperations>
      incluyeAlimentacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'incluyeAlimentacion');
    });
  }

  QueryBuilder<RegistroLaborIsarModel, int, QQueryOperations> loteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loteId');
    });
  }

  QueryBuilder<RegistroLaborIsarModel, String, QQueryOperations>
      tipoPagoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoPago');
    });
  }

  QueryBuilder<RegistroLaborIsarModel, double, QQueryOperations>
      totalPagarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalPagar');
    });
  }

  QueryBuilder<RegistroLaborIsarModel, int, QQueryOperations>
      trabajadorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trabajadorId');
    });
  }
}
