// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuracion_finca_isar_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetConfiguracionFincaIsarModelCollection on Isar {
  IsarCollection<ConfiguracionFincaIsarModel>
      get configuracionFincaIsarModels => this.collection();
}

const ConfiguracionFincaIsarModelSchema = CollectionSchema(
  name: r'ConfiguracionFincaIsarModel',
  id: -3661936729704900863,
  properties: {
    r'costoAlimentacion': PropertySchema(
      id: 0,
      name: r'costoAlimentacion',
      type: IsarType.double,
    ),
    r'fincaId': PropertySchema(
      id: 1,
      name: r'fincaId',
      type: IsarType.long,
    )
  },
  estimateSize: _configuracionFincaIsarModelEstimateSize,
  serialize: _configuracionFincaIsarModelSerialize,
  deserialize: _configuracionFincaIsarModelDeserialize,
  deserializeProp: _configuracionFincaIsarModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'fincaId': IndexSchema(
      id: -6325133973747223468,
      name: r'fincaId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'fincaId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _configuracionFincaIsarModelGetId,
  getLinks: _configuracionFincaIsarModelGetLinks,
  attach: _configuracionFincaIsarModelAttach,
  version: '3.1.0+1',
);

int _configuracionFincaIsarModelEstimateSize(
  ConfiguracionFincaIsarModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _configuracionFincaIsarModelSerialize(
  ConfiguracionFincaIsarModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.costoAlimentacion);
  writer.writeLong(offsets[1], object.fincaId);
}

ConfiguracionFincaIsarModel _configuracionFincaIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ConfiguracionFincaIsarModel();
  object.costoAlimentacion = reader.readDouble(offsets[0]);
  object.fincaId = reader.readLong(offsets[1]);
  object.id = id;
  return object;
}

P _configuracionFincaIsarModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _configuracionFincaIsarModelGetId(ConfiguracionFincaIsarModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _configuracionFincaIsarModelGetLinks(
    ConfiguracionFincaIsarModel object) {
  return [];
}

void _configuracionFincaIsarModelAttach(
    IsarCollection<dynamic> col, Id id, ConfiguracionFincaIsarModel object) {
  object.id = id;
}

extension ConfiguracionFincaIsarModelByIndex
    on IsarCollection<ConfiguracionFincaIsarModel> {
  Future<ConfiguracionFincaIsarModel?> getByFincaId(int fincaId) {
    return getByIndex(r'fincaId', [fincaId]);
  }

  ConfiguracionFincaIsarModel? getByFincaIdSync(int fincaId) {
    return getByIndexSync(r'fincaId', [fincaId]);
  }

  Future<bool> deleteByFincaId(int fincaId) {
    return deleteByIndex(r'fincaId', [fincaId]);
  }

  bool deleteByFincaIdSync(int fincaId) {
    return deleteByIndexSync(r'fincaId', [fincaId]);
  }

  Future<List<ConfiguracionFincaIsarModel?>> getAllByFincaId(
      List<int> fincaIdValues) {
    final values = fincaIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'fincaId', values);
  }

  List<ConfiguracionFincaIsarModel?> getAllByFincaIdSync(
      List<int> fincaIdValues) {
    final values = fincaIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'fincaId', values);
  }

  Future<int> deleteAllByFincaId(List<int> fincaIdValues) {
    final values = fincaIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'fincaId', values);
  }

  int deleteAllByFincaIdSync(List<int> fincaIdValues) {
    final values = fincaIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'fincaId', values);
  }

  Future<Id> putByFincaId(ConfiguracionFincaIsarModel object) {
    return putByIndex(r'fincaId', object);
  }

  Id putByFincaIdSync(ConfiguracionFincaIsarModel object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'fincaId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByFincaId(List<ConfiguracionFincaIsarModel> objects) {
    return putAllByIndex(r'fincaId', objects);
  }

  List<Id> putAllByFincaIdSync(List<ConfiguracionFincaIsarModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'fincaId', objects, saveLinks: saveLinks);
  }
}

extension ConfiguracionFincaIsarModelQueryWhereSort on QueryBuilder<
    ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel, QWhere> {
  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterWhere> anyFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'fincaId'),
      );
    });
  }
}

extension ConfiguracionFincaIsarModelQueryWhere on QueryBuilder<
    ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel, QWhereClause> {
  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
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

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
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

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterWhereClause> fincaIdEqualTo(int fincaId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'fincaId',
        value: [fincaId],
      ));
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterWhereClause> fincaIdNotEqualTo(int fincaId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fincaId',
              lower: [],
              upper: [fincaId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fincaId',
              lower: [fincaId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fincaId',
              lower: [fincaId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fincaId',
              lower: [],
              upper: [fincaId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterWhereClause> fincaIdGreaterThan(
    int fincaId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fincaId',
        lower: [fincaId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterWhereClause> fincaIdLessThan(
    int fincaId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fincaId',
        lower: [],
        upper: [fincaId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterWhereClause> fincaIdBetween(
    int lowerFincaId,
    int upperFincaId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fincaId',
        lower: [lowerFincaId],
        includeLower: includeLower,
        upper: [upperFincaId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ConfiguracionFincaIsarModelQueryFilter on QueryBuilder<
    ConfiguracionFincaIsarModel,
    ConfiguracionFincaIsarModel,
    QFilterCondition> {
  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterFilterCondition> costoAlimentacionEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'costoAlimentacion',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterFilterCondition> costoAlimentacionGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'costoAlimentacion',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterFilterCondition> costoAlimentacionLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'costoAlimentacion',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterFilterCondition> costoAlimentacionBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'costoAlimentacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterFilterCondition> fincaIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fincaId',
        value: value,
      ));
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterFilterCondition> fincaIdGreaterThan(
    int value, {
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

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterFilterCondition> fincaIdLessThan(
    int value, {
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

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterFilterCondition> fincaIdBetween(
    int lower,
    int upper, {
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

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
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

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
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

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
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
}

extension ConfiguracionFincaIsarModelQueryObject on QueryBuilder<
    ConfiguracionFincaIsarModel,
    ConfiguracionFincaIsarModel,
    QFilterCondition> {}

extension ConfiguracionFincaIsarModelQueryLinks on QueryBuilder<
    ConfiguracionFincaIsarModel,
    ConfiguracionFincaIsarModel,
    QFilterCondition> {}

extension ConfiguracionFincaIsarModelQuerySortBy on QueryBuilder<
    ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel, QSortBy> {
  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterSortBy> sortByCostoAlimentacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costoAlimentacion', Sort.asc);
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterSortBy> sortByCostoAlimentacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costoAlimentacion', Sort.desc);
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterSortBy> sortByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterSortBy> sortByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }
}

extension ConfiguracionFincaIsarModelQuerySortThenBy on QueryBuilder<
    ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel, QSortThenBy> {
  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterSortBy> thenByCostoAlimentacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costoAlimentacion', Sort.asc);
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterSortBy> thenByCostoAlimentacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costoAlimentacion', Sort.desc);
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterSortBy> thenByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterSortBy> thenByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension ConfiguracionFincaIsarModelQueryWhereDistinct on QueryBuilder<
    ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel, QDistinct> {
  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QDistinct> distinctByCostoAlimentacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'costoAlimentacion');
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel,
      QDistinct> distinctByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fincaId');
    });
  }
}

extension ConfiguracionFincaIsarModelQueryProperty on QueryBuilder<
    ConfiguracionFincaIsarModel, ConfiguracionFincaIsarModel, QQueryProperty> {
  QueryBuilder<ConfiguracionFincaIsarModel, int, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, double, QQueryOperations>
      costoAlimentacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'costoAlimentacion');
    });
  }

  QueryBuilder<ConfiguracionFincaIsarModel, int, QQueryOperations>
      fincaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fincaId');
    });
  }
}
