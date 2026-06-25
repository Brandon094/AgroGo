// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelos_pecuario_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEspecieIsarModelCollection on Isar {
  IsarCollection<EspecieIsarModel> get especieIsarModels => this.collection();
}

const EspecieIsarModelSchema = CollectionSchema(
  name: r'EspecieIsarModel',
  id: -3563745316565312096,
  properties: {
    r'cantidadActual': PropertySchema(
      id: 0,
      name: r'cantidadActual',
      type: IsarType.long,
    ),
    r'fincaId': PropertySchema(
      id: 1,
      name: r'fincaId',
      type: IsarType.long,
    ),
    r'loteId': PropertySchema(
      id: 2,
      name: r'loteId',
      type: IsarType.long,
    ),
    r'nombre': PropertySchema(
      id: 3,
      name: r'nombre',
      type: IsarType.string,
    ),
    r'tipoEspecie': PropertySchema(
      id: 4,
      name: r'tipoEspecie',
      type: IsarType.string,
    ),
    r'valorTotalInversion': PropertySchema(
      id: 5,
      name: r'valorTotalInversion',
      type: IsarType.double,
    ),
    r'valorUnitario': PropertySchema(
      id: 6,
      name: r'valorUnitario',
      type: IsarType.double,
    )
  },
  estimateSize: _especieIsarModelEstimateSize,
  serialize: _especieIsarModelSerialize,
  deserialize: _especieIsarModelDeserialize,
  deserializeProp: _especieIsarModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _especieIsarModelGetId,
  getLinks: _especieIsarModelGetLinks,
  attach: _especieIsarModelAttach,
  version: '3.1.0+1',
);

int _especieIsarModelEstimateSize(
  EspecieIsarModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nombre.length * 3;
  bytesCount += 3 + object.tipoEspecie.length * 3;
  return bytesCount;
}

void _especieIsarModelSerialize(
  EspecieIsarModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.cantidadActual);
  writer.writeLong(offsets[1], object.fincaId);
  writer.writeLong(offsets[2], object.loteId);
  writer.writeString(offsets[3], object.nombre);
  writer.writeString(offsets[4], object.tipoEspecie);
  writer.writeDouble(offsets[5], object.valorTotalInversion);
  writer.writeDouble(offsets[6], object.valorUnitario);
}

EspecieIsarModel _especieIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EspecieIsarModel();
  object.cantidadActual = reader.readLong(offsets[0]);
  object.fincaId = reader.readLongOrNull(offsets[1]);
  object.id = id;
  object.loteId = reader.readLongOrNull(offsets[2]);
  object.nombre = reader.readString(offsets[3]);
  object.tipoEspecie = reader.readString(offsets[4]);
  object.valorTotalInversion = reader.readDouble(offsets[5]);
  object.valorUnitario = reader.readDouble(offsets[6]);
  return object;
}

P _especieIsarModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _especieIsarModelGetId(EspecieIsarModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _especieIsarModelGetLinks(EspecieIsarModel object) {
  return [];
}

void _especieIsarModelAttach(
    IsarCollection<dynamic> col, Id id, EspecieIsarModel object) {
  object.id = id;
}

extension EspecieIsarModelQueryWhereSort
    on QueryBuilder<EspecieIsarModel, EspecieIsarModel, QWhere> {
  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EspecieIsarModelQueryWhere
    on QueryBuilder<EspecieIsarModel, EspecieIsarModel, QWhereClause> {
  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterWhereClause>
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

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterWhereClause> idBetween(
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

extension EspecieIsarModelQueryFilter
    on QueryBuilder<EspecieIsarModel, EspecieIsarModel, QFilterCondition> {
  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      cantidadActualEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantidadActual',
        value: value,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      cantidadActualGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cantidadActual',
        value: value,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      cantidadActualLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cantidadActual',
        value: value,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      cantidadActualBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cantidadActual',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      fincaIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      fincaIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      fincaIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fincaId',
        value: value,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
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

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
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

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
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

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
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

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
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

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
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

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      loteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'loteId',
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      loteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'loteId',
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      loteIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loteId',
        value: value,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
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

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
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

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
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

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      nombreEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      nombreGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      nombreLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      nombreBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      nombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      nombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      nombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      nombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      tipoEspecieEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoEspecie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      tipoEspecieGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipoEspecie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      tipoEspecieLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipoEspecie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      tipoEspecieBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipoEspecie',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      tipoEspecieStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tipoEspecie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      tipoEspecieEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tipoEspecie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      tipoEspecieContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipoEspecie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      tipoEspecieMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipoEspecie',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      tipoEspecieIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoEspecie',
        value: '',
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      tipoEspecieIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoEspecie',
        value: '',
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      valorTotalInversionEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valorTotalInversion',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      valorTotalInversionGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valorTotalInversion',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      valorTotalInversionLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valorTotalInversion',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      valorTotalInversionBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valorTotalInversion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      valorUnitarioEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valorUnitario',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      valorUnitarioGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valorUnitario',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      valorUnitarioLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valorUnitario',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterFilterCondition>
      valorUnitarioBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valorUnitario',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension EspecieIsarModelQueryObject
    on QueryBuilder<EspecieIsarModel, EspecieIsarModel, QFilterCondition> {}

extension EspecieIsarModelQueryLinks
    on QueryBuilder<EspecieIsarModel, EspecieIsarModel, QFilterCondition> {}

extension EspecieIsarModelQuerySortBy
    on QueryBuilder<EspecieIsarModel, EspecieIsarModel, QSortBy> {
  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      sortByCantidadActual() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadActual', Sort.asc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      sortByCantidadActualDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadActual', Sort.desc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      sortByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      sortByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      sortByLoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.asc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      sortByLoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.desc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      sortByTipoEspecie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEspecie', Sort.asc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      sortByTipoEspecieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEspecie', Sort.desc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      sortByValorTotalInversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorTotalInversion', Sort.asc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      sortByValorTotalInversionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorTotalInversion', Sort.desc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      sortByValorUnitario() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorUnitario', Sort.asc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      sortByValorUnitarioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorUnitario', Sort.desc);
    });
  }
}

extension EspecieIsarModelQuerySortThenBy
    on QueryBuilder<EspecieIsarModel, EspecieIsarModel, QSortThenBy> {
  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      thenByCantidadActual() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadActual', Sort.asc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      thenByCantidadActualDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadActual', Sort.desc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      thenByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      thenByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      thenByLoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.asc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      thenByLoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.desc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      thenByTipoEspecie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEspecie', Sort.asc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      thenByTipoEspecieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEspecie', Sort.desc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      thenByValorTotalInversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorTotalInversion', Sort.asc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      thenByValorTotalInversionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorTotalInversion', Sort.desc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      thenByValorUnitario() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorUnitario', Sort.asc);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QAfterSortBy>
      thenByValorUnitarioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorUnitario', Sort.desc);
    });
  }
}

extension EspecieIsarModelQueryWhereDistinct
    on QueryBuilder<EspecieIsarModel, EspecieIsarModel, QDistinct> {
  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QDistinct>
      distinctByCantidadActual() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cantidadActual');
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QDistinct>
      distinctByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fincaId');
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QDistinct>
      distinctByLoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loteId');
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QDistinct> distinctByNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QDistinct>
      distinctByTipoEspecie({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoEspecie', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QDistinct>
      distinctByValorTotalInversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valorTotalInversion');
    });
  }

  QueryBuilder<EspecieIsarModel, EspecieIsarModel, QDistinct>
      distinctByValorUnitario() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valorUnitario');
    });
  }
}

extension EspecieIsarModelQueryProperty
    on QueryBuilder<EspecieIsarModel, EspecieIsarModel, QQueryProperty> {
  QueryBuilder<EspecieIsarModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EspecieIsarModel, int, QQueryOperations>
      cantidadActualProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cantidadActual');
    });
  }

  QueryBuilder<EspecieIsarModel, int?, QQueryOperations> fincaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fincaId');
    });
  }

  QueryBuilder<EspecieIsarModel, int?, QQueryOperations> loteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loteId');
    });
  }

  QueryBuilder<EspecieIsarModel, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<EspecieIsarModel, String, QQueryOperations>
      tipoEspecieProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoEspecie');
    });
  }

  QueryBuilder<EspecieIsarModel, double, QQueryOperations>
      valorTotalInversionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valorTotalInversion');
    });
  }

  QueryBuilder<EspecieIsarModel, double, QQueryOperations>
      valorUnitarioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valorUnitario');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetControlSanitarioIsarModelCollection on Isar {
  IsarCollection<ControlSanitarioIsarModel> get controlSanitarioIsarModels =>
      this.collection();
}

const ControlSanitarioIsarModelSchema = CollectionSchema(
  name: r'ControlSanitarioIsarModel',
  id: -3413995857545359881,
  properties: {
    r'especieId': PropertySchema(
      id: 0,
      name: r'especieId',
      type: IsarType.long,
    ),
    r'fechaAplicacion': PropertySchema(
      id: 1,
      name: r'fechaAplicacion',
      type: IsarType.dateTime,
    ),
    r'fincaId': PropertySchema(
      id: 2,
      name: r'fincaId',
      type: IsarType.long,
    ),
    r'producto': PropertySchema(
      id: 3,
      name: r'producto',
      type: IsarType.string,
    ),
    r'proximaDosis': PropertySchema(
      id: 4,
      name: r'proximaDosis',
      type: IsarType.dateTime,
    ),
    r'tipo': PropertySchema(
      id: 5,
      name: r'tipo',
      type: IsarType.string,
    )
  },
  estimateSize: _controlSanitarioIsarModelEstimateSize,
  serialize: _controlSanitarioIsarModelSerialize,
  deserialize: _controlSanitarioIsarModelDeserialize,
  deserializeProp: _controlSanitarioIsarModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _controlSanitarioIsarModelGetId,
  getLinks: _controlSanitarioIsarModelGetLinks,
  attach: _controlSanitarioIsarModelAttach,
  version: '3.1.0+1',
);

int _controlSanitarioIsarModelEstimateSize(
  ControlSanitarioIsarModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.producto.length * 3;
  bytesCount += 3 + object.tipo.length * 3;
  return bytesCount;
}

void _controlSanitarioIsarModelSerialize(
  ControlSanitarioIsarModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.especieId);
  writer.writeDateTime(offsets[1], object.fechaAplicacion);
  writer.writeLong(offsets[2], object.fincaId);
  writer.writeString(offsets[3], object.producto);
  writer.writeDateTime(offsets[4], object.proximaDosis);
  writer.writeString(offsets[5], object.tipo);
}

ControlSanitarioIsarModel _controlSanitarioIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ControlSanitarioIsarModel();
  object.especieId = reader.readLong(offsets[0]);
  object.fechaAplicacion = reader.readDateTime(offsets[1]);
  object.fincaId = reader.readLongOrNull(offsets[2]);
  object.id = id;
  object.producto = reader.readString(offsets[3]);
  object.proximaDosis = reader.readDateTime(offsets[4]);
  object.tipo = reader.readString(offsets[5]);
  return object;
}

P _controlSanitarioIsarModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _controlSanitarioIsarModelGetId(ControlSanitarioIsarModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _controlSanitarioIsarModelGetLinks(
    ControlSanitarioIsarModel object) {
  return [];
}

void _controlSanitarioIsarModelAttach(
    IsarCollection<dynamic> col, Id id, ControlSanitarioIsarModel object) {
  object.id = id;
}

extension ControlSanitarioIsarModelQueryWhereSort on QueryBuilder<
    ControlSanitarioIsarModel, ControlSanitarioIsarModel, QWhere> {
  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ControlSanitarioIsarModelQueryWhere on QueryBuilder<
    ControlSanitarioIsarModel, ControlSanitarioIsarModel, QWhereClause> {
  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
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

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
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

extension ControlSanitarioIsarModelQueryFilter on QueryBuilder<
    ControlSanitarioIsarModel, ControlSanitarioIsarModel, QFilterCondition> {
  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> especieIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'especieId',
        value: value,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> especieIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'especieId',
        value: value,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> especieIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'especieId',
        value: value,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> especieIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'especieId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> fechaAplicacionEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaAplicacion',
        value: value,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> fechaAplicacionGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaAplicacion',
        value: value,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> fechaAplicacionLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaAplicacion',
        value: value,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> fechaAplicacionBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaAplicacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> fincaIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> fincaIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> fincaIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fincaId',
        value: value,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
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

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
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

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
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

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
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

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
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

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
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

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> productoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'producto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> productoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'producto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> productoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'producto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> productoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'producto',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> productoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'producto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> productoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'producto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
          QAfterFilterCondition>
      productoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'producto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
          QAfterFilterCondition>
      productoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'producto',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> productoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'producto',
        value: '',
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> productoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'producto',
        value: '',
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> proximaDosisEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proximaDosis',
        value: value,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> proximaDosisGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proximaDosis',
        value: value,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> proximaDosisLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proximaDosis',
        value: value,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> proximaDosisBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proximaDosis',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> tipoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> tipoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> tipoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> tipoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> tipoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> tipoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
          QAfterFilterCondition>
      tipoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
          QAfterFilterCondition>
      tipoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> tipoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipo',
        value: '',
      ));
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterFilterCondition> tipoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipo',
        value: '',
      ));
    });
  }
}

extension ControlSanitarioIsarModelQueryObject on QueryBuilder<
    ControlSanitarioIsarModel, ControlSanitarioIsarModel, QFilterCondition> {}

extension ControlSanitarioIsarModelQueryLinks on QueryBuilder<
    ControlSanitarioIsarModel, ControlSanitarioIsarModel, QFilterCondition> {}

extension ControlSanitarioIsarModelQuerySortBy on QueryBuilder<
    ControlSanitarioIsarModel, ControlSanitarioIsarModel, QSortBy> {
  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> sortByEspecieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'especieId', Sort.asc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> sortByEspecieIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'especieId', Sort.desc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> sortByFechaAplicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaAplicacion', Sort.asc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> sortByFechaAplicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaAplicacion', Sort.desc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> sortByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> sortByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> sortByProducto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'producto', Sort.asc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> sortByProductoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'producto', Sort.desc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> sortByProximaDosis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximaDosis', Sort.asc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> sortByProximaDosisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximaDosis', Sort.desc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> sortByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.asc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> sortByTipoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.desc);
    });
  }
}

extension ControlSanitarioIsarModelQuerySortThenBy on QueryBuilder<
    ControlSanitarioIsarModel, ControlSanitarioIsarModel, QSortThenBy> {
  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> thenByEspecieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'especieId', Sort.asc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> thenByEspecieIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'especieId', Sort.desc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> thenByFechaAplicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaAplicacion', Sort.asc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> thenByFechaAplicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaAplicacion', Sort.desc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> thenByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> thenByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> thenByProducto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'producto', Sort.asc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> thenByProductoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'producto', Sort.desc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> thenByProximaDosis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximaDosis', Sort.asc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> thenByProximaDosisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximaDosis', Sort.desc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> thenByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.asc);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel,
      QAfterSortBy> thenByTipoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.desc);
    });
  }
}

extension ControlSanitarioIsarModelQueryWhereDistinct on QueryBuilder<
    ControlSanitarioIsarModel, ControlSanitarioIsarModel, QDistinct> {
  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel, QDistinct>
      distinctByEspecieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'especieId');
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel, QDistinct>
      distinctByFechaAplicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaAplicacion');
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel, QDistinct>
      distinctByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fincaId');
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel, QDistinct>
      distinctByProducto({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'producto', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel, QDistinct>
      distinctByProximaDosis() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proximaDosis');
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, ControlSanitarioIsarModel, QDistinct>
      distinctByTipo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipo', caseSensitive: caseSensitive);
    });
  }
}

extension ControlSanitarioIsarModelQueryProperty on QueryBuilder<
    ControlSanitarioIsarModel, ControlSanitarioIsarModel, QQueryProperty> {
  QueryBuilder<ControlSanitarioIsarModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, int, QQueryOperations>
      especieIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'especieId');
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, DateTime, QQueryOperations>
      fechaAplicacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaAplicacion');
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, int?, QQueryOperations>
      fincaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fincaId');
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, String, QQueryOperations>
      productoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'producto');
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, DateTime, QQueryOperations>
      proximaDosisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proximaDosis');
    });
  }

  QueryBuilder<ControlSanitarioIsarModel, String, QQueryOperations>
      tipoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipo');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAlimentacionIsarModelCollection on Isar {
  IsarCollection<AlimentacionIsarModel> get alimentacionIsarModels =>
      this.collection();
}

const AlimentacionIsarModelSchema = CollectionSchema(
  name: r'AlimentacionIsarModel',
  id: -2046891352500399773,
  properties: {
    r'cantidadKilos': PropertySchema(
      id: 0,
      name: r'cantidadKilos',
      type: IsarType.double,
    ),
    r'costoAsociado': PropertySchema(
      id: 1,
      name: r'costoAsociado',
      type: IsarType.double,
    ),
    r'especieId': PropertySchema(
      id: 2,
      name: r'especieId',
      type: IsarType.long,
    ),
    r'fecha': PropertySchema(
      id: 3,
      name: r'fecha',
      type: IsarType.dateTime,
    ),
    r'fincaId': PropertySchema(
      id: 4,
      name: r'fincaId',
      type: IsarType.long,
    ),
    r'producto': PropertySchema(
      id: 5,
      name: r'producto',
      type: IsarType.string,
    )
  },
  estimateSize: _alimentacionIsarModelEstimateSize,
  serialize: _alimentacionIsarModelSerialize,
  deserialize: _alimentacionIsarModelDeserialize,
  deserializeProp: _alimentacionIsarModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _alimentacionIsarModelGetId,
  getLinks: _alimentacionIsarModelGetLinks,
  attach: _alimentacionIsarModelAttach,
  version: '3.1.0+1',
);

int _alimentacionIsarModelEstimateSize(
  AlimentacionIsarModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.producto.length * 3;
  return bytesCount;
}

void _alimentacionIsarModelSerialize(
  AlimentacionIsarModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.cantidadKilos);
  writer.writeDouble(offsets[1], object.costoAsociado);
  writer.writeLong(offsets[2], object.especieId);
  writer.writeDateTime(offsets[3], object.fecha);
  writer.writeLong(offsets[4], object.fincaId);
  writer.writeString(offsets[5], object.producto);
}

AlimentacionIsarModel _alimentacionIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AlimentacionIsarModel();
  object.cantidadKilos = reader.readDouble(offsets[0]);
  object.costoAsociado = reader.readDoubleOrNull(offsets[1]);
  object.especieId = reader.readLong(offsets[2]);
  object.fecha = reader.readDateTime(offsets[3]);
  object.fincaId = reader.readLongOrNull(offsets[4]);
  object.id = id;
  object.producto = reader.readString(offsets[5]);
  return object;
}

P _alimentacionIsarModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _alimentacionIsarModelGetId(AlimentacionIsarModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _alimentacionIsarModelGetLinks(
    AlimentacionIsarModel object) {
  return [];
}

void _alimentacionIsarModelAttach(
    IsarCollection<dynamic> col, Id id, AlimentacionIsarModel object) {
  object.id = id;
}

extension AlimentacionIsarModelQueryWhereSort
    on QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QWhere> {
  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AlimentacionIsarModelQueryWhere on QueryBuilder<AlimentacionIsarModel,
    AlimentacionIsarModel, QWhereClause> {
  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterWhereClause>
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

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterWhereClause>
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

extension AlimentacionIsarModelQueryFilter on QueryBuilder<
    AlimentacionIsarModel, AlimentacionIsarModel, QFilterCondition> {
  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> cantidadKilosEqualTo(
    double value, {
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

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> cantidadKilosGreaterThan(
    double value, {
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

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> cantidadKilosLessThan(
    double value, {
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

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> cantidadKilosBetween(
    double lower,
    double upper, {
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

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> costoAsociadoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'costoAsociado',
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> costoAsociadoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'costoAsociado',
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> costoAsociadoEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'costoAsociado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> costoAsociadoGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'costoAsociado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> costoAsociadoLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'costoAsociado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> costoAsociadoBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'costoAsociado',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> especieIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'especieId',
        value: value,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> especieIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'especieId',
        value: value,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> especieIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'especieId',
        value: value,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> especieIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'especieId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> fechaEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> fechaGreaterThan(
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

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> fechaLessThan(
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

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> fechaBetween(
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

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> fincaIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> fincaIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> fincaIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fincaId',
        value: value,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
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

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
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

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
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

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
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

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
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

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
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

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> productoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'producto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> productoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'producto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> productoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'producto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> productoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'producto',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> productoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'producto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> productoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'producto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
          QAfterFilterCondition>
      productoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'producto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
          QAfterFilterCondition>
      productoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'producto',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> productoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'producto',
        value: '',
      ));
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel,
      QAfterFilterCondition> productoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'producto',
        value: '',
      ));
    });
  }
}

extension AlimentacionIsarModelQueryObject on QueryBuilder<
    AlimentacionIsarModel, AlimentacionIsarModel, QFilterCondition> {}

extension AlimentacionIsarModelQueryLinks on QueryBuilder<AlimentacionIsarModel,
    AlimentacionIsarModel, QFilterCondition> {}

extension AlimentacionIsarModelQuerySortBy
    on QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QSortBy> {
  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      sortByCantidadKilos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadKilos', Sort.asc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      sortByCantidadKilosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadKilos', Sort.desc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      sortByCostoAsociado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costoAsociado', Sort.asc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      sortByCostoAsociadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costoAsociado', Sort.desc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      sortByEspecieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'especieId', Sort.asc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      sortByEspecieIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'especieId', Sort.desc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      sortByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      sortByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      sortByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      sortByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      sortByProducto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'producto', Sort.asc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      sortByProductoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'producto', Sort.desc);
    });
  }
}

extension AlimentacionIsarModelQuerySortThenBy
    on QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QSortThenBy> {
  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      thenByCantidadKilos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadKilos', Sort.asc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      thenByCantidadKilosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadKilos', Sort.desc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      thenByCostoAsociado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costoAsociado', Sort.asc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      thenByCostoAsociadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costoAsociado', Sort.desc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      thenByEspecieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'especieId', Sort.asc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      thenByEspecieIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'especieId', Sort.desc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      thenByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      thenByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      thenByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      thenByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      thenByProducto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'producto', Sort.asc);
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QAfterSortBy>
      thenByProductoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'producto', Sort.desc);
    });
  }
}

extension AlimentacionIsarModelQueryWhereDistinct
    on QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QDistinct> {
  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QDistinct>
      distinctByCantidadKilos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cantidadKilos');
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QDistinct>
      distinctByCostoAsociado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'costoAsociado');
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QDistinct>
      distinctByEspecieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'especieId');
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QDistinct>
      distinctByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fecha');
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QDistinct>
      distinctByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fincaId');
    });
  }

  QueryBuilder<AlimentacionIsarModel, AlimentacionIsarModel, QDistinct>
      distinctByProducto({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'producto', caseSensitive: caseSensitive);
    });
  }
}

extension AlimentacionIsarModelQueryProperty on QueryBuilder<
    AlimentacionIsarModel, AlimentacionIsarModel, QQueryProperty> {
  QueryBuilder<AlimentacionIsarModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AlimentacionIsarModel, double, QQueryOperations>
      cantidadKilosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cantidadKilos');
    });
  }

  QueryBuilder<AlimentacionIsarModel, double?, QQueryOperations>
      costoAsociadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'costoAsociado');
    });
  }

  QueryBuilder<AlimentacionIsarModel, int, QQueryOperations>
      especieIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'especieId');
    });
  }

  QueryBuilder<AlimentacionIsarModel, DateTime, QQueryOperations>
      fechaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fecha');
    });
  }

  QueryBuilder<AlimentacionIsarModel, int?, QQueryOperations>
      fincaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fincaId');
    });
  }

  QueryBuilder<AlimentacionIsarModel, String, QQueryOperations>
      productoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'producto');
    });
  }
}
