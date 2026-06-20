// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarea_isar_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTareaIsarModelCollection on Isar {
  IsarCollection<TareaIsarModel> get tareaIsarModels => this.collection();
}

const TareaIsarModelSchema = CollectionSchema(
  name: r'TareaIsarModel',
  id: 695328471068824889,
  properties: {
    r'estaCompletada': PropertySchema(
      id: 0,
      name: r'estaCompletada',
      type: IsarType.bool,
    ),
    r'fechaFinEstimada': PropertySchema(
      id: 1,
      name: r'fechaFinEstimada',
      type: IsarType.dateTime,
    ),
    r'fechaInicio': PropertySchema(
      id: 2,
      name: r'fechaInicio',
      type: IsarType.dateTime,
    ),
    r'fincaId': PropertySchema(
      id: 3,
      name: r'fincaId',
      type: IsarType.long,
    ),
    r'loteId': PropertySchema(
      id: 4,
      name: r'loteId',
      type: IsarType.long,
    ),
    r'tipoActividad': PropertySchema(
      id: 5,
      name: r'tipoActividad',
      type: IsarType.string,
    ),
    r'titulo': PropertySchema(
      id: 6,
      name: r'titulo',
      type: IsarType.string,
    )
  },
  estimateSize: _tareaIsarModelEstimateSize,
  serialize: _tareaIsarModelSerialize,
  deserialize: _tareaIsarModelDeserialize,
  deserializeProp: _tareaIsarModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _tareaIsarModelGetId,
  getLinks: _tareaIsarModelGetLinks,
  attach: _tareaIsarModelAttach,
  version: '3.1.0+1',
);

int _tareaIsarModelEstimateSize(
  TareaIsarModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.tipoActividad.length * 3;
  bytesCount += 3 + object.titulo.length * 3;
  return bytesCount;
}

void _tareaIsarModelSerialize(
  TareaIsarModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.estaCompletada);
  writer.writeDateTime(offsets[1], object.fechaFinEstimada);
  writer.writeDateTime(offsets[2], object.fechaInicio);
  writer.writeLong(offsets[3], object.fincaId);
  writer.writeLong(offsets[4], object.loteId);
  writer.writeString(offsets[5], object.tipoActividad);
  writer.writeString(offsets[6], object.titulo);
}

TareaIsarModel _tareaIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TareaIsarModel();
  object.estaCompletada = reader.readBool(offsets[0]);
  object.fechaFinEstimada = reader.readDateTime(offsets[1]);
  object.fechaInicio = reader.readDateTime(offsets[2]);
  object.fincaId = reader.readLongOrNull(offsets[3]);
  object.id = id;
  object.loteId = reader.readLongOrNull(offsets[4]);
  object.tipoActividad = reader.readString(offsets[5]);
  object.titulo = reader.readString(offsets[6]);
  return object;
}

P _tareaIsarModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tareaIsarModelGetId(TareaIsarModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tareaIsarModelGetLinks(TareaIsarModel object) {
  return [];
}

void _tareaIsarModelAttach(
    IsarCollection<dynamic> col, Id id, TareaIsarModel object) {
  object.id = id;
}

extension TareaIsarModelQueryWhereSort
    on QueryBuilder<TareaIsarModel, TareaIsarModel, QWhere> {
  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TareaIsarModelQueryWhere
    on QueryBuilder<TareaIsarModel, TareaIsarModel, QWhereClause> {
  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterWhereClause> idBetween(
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

extension TareaIsarModelQueryFilter
    on QueryBuilder<TareaIsarModel, TareaIsarModel, QFilterCondition> {
  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      estaCompletadaEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estaCompletada',
        value: value,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      fechaFinEstimadaEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaFinEstimada',
        value: value,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      fechaFinEstimadaGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaFinEstimada',
        value: value,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      fechaFinEstimadaLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaFinEstimada',
        value: value,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      fechaFinEstimadaBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaFinEstimada',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      fechaInicioEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaInicio',
        value: value,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
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

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
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

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
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

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      fincaIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      fincaIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      fincaIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fincaId',
        value: value,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
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

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
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

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
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

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
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

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
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

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      loteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'loteId',
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      loteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'loteId',
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      loteIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loteId',
        value: value,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
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

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
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

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
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

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tipoActividadEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoActividad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tipoActividadGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipoActividad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tipoActividadLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipoActividad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tipoActividadBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipoActividad',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tipoActividadStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tipoActividad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tipoActividadEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tipoActividad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tipoActividadContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipoActividad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tipoActividadMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipoActividad',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tipoActividadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoActividad',
        value: '',
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tipoActividadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoActividad',
        value: '',
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tituloEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tituloGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tituloLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tituloBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'titulo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tituloStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tituloEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tituloContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tituloMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'titulo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tituloIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titulo',
        value: '',
      ));
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterFilterCondition>
      tituloIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'titulo',
        value: '',
      ));
    });
  }
}

extension TareaIsarModelQueryObject
    on QueryBuilder<TareaIsarModel, TareaIsarModel, QFilterCondition> {}

extension TareaIsarModelQueryLinks
    on QueryBuilder<TareaIsarModel, TareaIsarModel, QFilterCondition> {}

extension TareaIsarModelQuerySortBy
    on QueryBuilder<TareaIsarModel, TareaIsarModel, QSortBy> {
  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      sortByEstaCompletada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estaCompletada', Sort.asc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      sortByEstaCompletadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estaCompletada', Sort.desc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      sortByFechaFinEstimada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFinEstimada', Sort.asc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      sortByFechaFinEstimadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFinEstimada', Sort.desc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      sortByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.asc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      sortByFechaInicioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.desc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy> sortByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      sortByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy> sortByLoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.asc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      sortByLoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.desc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      sortByTipoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoActividad', Sort.asc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      sortByTipoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoActividad', Sort.desc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy> sortByTitulo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.asc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      sortByTituloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.desc);
    });
  }
}

extension TareaIsarModelQuerySortThenBy
    on QueryBuilder<TareaIsarModel, TareaIsarModel, QSortThenBy> {
  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      thenByEstaCompletada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estaCompletada', Sort.asc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      thenByEstaCompletadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estaCompletada', Sort.desc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      thenByFechaFinEstimada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFinEstimada', Sort.asc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      thenByFechaFinEstimadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFinEstimada', Sort.desc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      thenByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.asc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      thenByFechaInicioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.desc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy> thenByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      thenByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy> thenByLoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.asc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      thenByLoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.desc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      thenByTipoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoActividad', Sort.asc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      thenByTipoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoActividad', Sort.desc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy> thenByTitulo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.asc);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QAfterSortBy>
      thenByTituloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.desc);
    });
  }
}

extension TareaIsarModelQueryWhereDistinct
    on QueryBuilder<TareaIsarModel, TareaIsarModel, QDistinct> {
  QueryBuilder<TareaIsarModel, TareaIsarModel, QDistinct>
      distinctByEstaCompletada() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estaCompletada');
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QDistinct>
      distinctByFechaFinEstimada() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaFinEstimada');
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QDistinct>
      distinctByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaInicio');
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QDistinct> distinctByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fincaId');
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QDistinct> distinctByLoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loteId');
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QDistinct>
      distinctByTipoActividad({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoActividad',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TareaIsarModel, TareaIsarModel, QDistinct> distinctByTitulo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'titulo', caseSensitive: caseSensitive);
    });
  }
}

extension TareaIsarModelQueryProperty
    on QueryBuilder<TareaIsarModel, TareaIsarModel, QQueryProperty> {
  QueryBuilder<TareaIsarModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TareaIsarModel, bool, QQueryOperations>
      estaCompletadaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estaCompletada');
    });
  }

  QueryBuilder<TareaIsarModel, DateTime, QQueryOperations>
      fechaFinEstimadaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaFinEstimada');
    });
  }

  QueryBuilder<TareaIsarModel, DateTime, QQueryOperations>
      fechaInicioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaInicio');
    });
  }

  QueryBuilder<TareaIsarModel, int?, QQueryOperations> fincaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fincaId');
    });
  }

  QueryBuilder<TareaIsarModel, int?, QQueryOperations> loteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loteId');
    });
  }

  QueryBuilder<TareaIsarModel, String, QQueryOperations>
      tipoActividadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoActividad');
    });
  }

  QueryBuilder<TareaIsarModel, String, QQueryOperations> tituloProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'titulo');
    });
  }
}
