// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finca_isar_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFincaIsarModelCollection on Isar {
  IsarCollection<FincaIsarModel> get fincaIsarModels => this.collection();
}

const FincaIsarModelSchema = CollectionSchema(
  name: r'FincaIsarModel',
  id: 6323746290294179637,
  properties: {
    r'areaTotalHectareas': PropertySchema(
      id: 0,
      name: r'areaTotalHectareas',
      type: IsarType.double,
    ),
    r'nombre': PropertySchema(
      id: 1,
      name: r'nombre',
      type: IsarType.string,
    ),
    r'veredaUbicacion': PropertySchema(
      id: 2,
      name: r'veredaUbicacion',
      type: IsarType.string,
    )
  },
  estimateSize: _fincaIsarModelEstimateSize,
  serialize: _fincaIsarModelSerialize,
  deserialize: _fincaIsarModelDeserialize,
  deserializeProp: _fincaIsarModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _fincaIsarModelGetId,
  getLinks: _fincaIsarModelGetLinks,
  attach: _fincaIsarModelAttach,
  version: '3.1.0+1',
);

int _fincaIsarModelEstimateSize(
  FincaIsarModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nombre.length * 3;
  {
    final value = object.veredaUbicacion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _fincaIsarModelSerialize(
  FincaIsarModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.areaTotalHectareas);
  writer.writeString(offsets[1], object.nombre);
  writer.writeString(offsets[2], object.veredaUbicacion);
}

FincaIsarModel _fincaIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FincaIsarModel();
  object.areaTotalHectareas = reader.readDoubleOrNull(offsets[0]);
  object.id = id;
  object.nombre = reader.readString(offsets[1]);
  object.veredaUbicacion = reader.readStringOrNull(offsets[2]);
  return object;
}

P _fincaIsarModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _fincaIsarModelGetId(FincaIsarModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _fincaIsarModelGetLinks(FincaIsarModel object) {
  return [];
}

void _fincaIsarModelAttach(
    IsarCollection<dynamic> col, Id id, FincaIsarModel object) {
  object.id = id;
}

extension FincaIsarModelQueryWhereSort
    on QueryBuilder<FincaIsarModel, FincaIsarModel, QWhere> {
  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FincaIsarModelQueryWhere
    on QueryBuilder<FincaIsarModel, FincaIsarModel, QWhereClause> {
  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterWhereClause> idBetween(
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

extension FincaIsarModelQueryFilter
    on QueryBuilder<FincaIsarModel, FincaIsarModel, QFilterCondition> {
  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      areaTotalHectareasIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'areaTotalHectareas',
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      areaTotalHectareasIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'areaTotalHectareas',
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      areaTotalHectareasEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'areaTotalHectareas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      areaTotalHectareasGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'areaTotalHectareas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      areaTotalHectareasLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'areaTotalHectareas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      areaTotalHectareasBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'areaTotalHectareas',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
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

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
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

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
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

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
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

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
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

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
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

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
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

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
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

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      nombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      nombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      veredaUbicacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'veredaUbicacion',
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      veredaUbicacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'veredaUbicacion',
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      veredaUbicacionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'veredaUbicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      veredaUbicacionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'veredaUbicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      veredaUbicacionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'veredaUbicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      veredaUbicacionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'veredaUbicacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      veredaUbicacionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'veredaUbicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      veredaUbicacionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'veredaUbicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      veredaUbicacionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'veredaUbicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      veredaUbicacionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'veredaUbicacion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      veredaUbicacionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'veredaUbicacion',
        value: '',
      ));
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterFilterCondition>
      veredaUbicacionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'veredaUbicacion',
        value: '',
      ));
    });
  }
}

extension FincaIsarModelQueryObject
    on QueryBuilder<FincaIsarModel, FincaIsarModel, QFilterCondition> {}

extension FincaIsarModelQueryLinks
    on QueryBuilder<FincaIsarModel, FincaIsarModel, QFilterCondition> {}

extension FincaIsarModelQuerySortBy
    on QueryBuilder<FincaIsarModel, FincaIsarModel, QSortBy> {
  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterSortBy>
      sortByAreaTotalHectareas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaTotalHectareas', Sort.asc);
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterSortBy>
      sortByAreaTotalHectareasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaTotalHectareas', Sort.desc);
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterSortBy>
      sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterSortBy>
      sortByVeredaUbicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'veredaUbicacion', Sort.asc);
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterSortBy>
      sortByVeredaUbicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'veredaUbicacion', Sort.desc);
    });
  }
}

extension FincaIsarModelQuerySortThenBy
    on QueryBuilder<FincaIsarModel, FincaIsarModel, QSortThenBy> {
  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterSortBy>
      thenByAreaTotalHectareas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaTotalHectareas', Sort.asc);
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterSortBy>
      thenByAreaTotalHectareasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaTotalHectareas', Sort.desc);
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterSortBy>
      thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterSortBy>
      thenByVeredaUbicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'veredaUbicacion', Sort.asc);
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QAfterSortBy>
      thenByVeredaUbicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'veredaUbicacion', Sort.desc);
    });
  }
}

extension FincaIsarModelQueryWhereDistinct
    on QueryBuilder<FincaIsarModel, FincaIsarModel, QDistinct> {
  QueryBuilder<FincaIsarModel, FincaIsarModel, QDistinct>
      distinctByAreaTotalHectareas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'areaTotalHectareas');
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QDistinct> distinctByNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FincaIsarModel, FincaIsarModel, QDistinct>
      distinctByVeredaUbicacion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'veredaUbicacion',
          caseSensitive: caseSensitive);
    });
  }
}

extension FincaIsarModelQueryProperty
    on QueryBuilder<FincaIsarModel, FincaIsarModel, QQueryProperty> {
  QueryBuilder<FincaIsarModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FincaIsarModel, double?, QQueryOperations>
      areaTotalHectareasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'areaTotalHectareas');
    });
  }

  QueryBuilder<FincaIsarModel, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<FincaIsarModel, String?, QQueryOperations>
      veredaUbicacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'veredaUbicacion');
    });
  }
}
