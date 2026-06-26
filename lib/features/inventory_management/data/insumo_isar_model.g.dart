// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insumo_isar_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetInsumoIsarModelCollection on Isar {
  IsarCollection<InsumoIsarModel> get insumoIsarModels => this.collection();
}

const InsumoIsarModelSchema = CollectionSchema(
  name: r'InsumoIsarModel',
  id: 3846634146623603141,
  properties: {
    r'beneficioId': PropertySchema(
      id: 0,
      name: r'beneficioId',
      type: IsarType.long,
    ),
    r'cantidadActual': PropertySchema(
      id: 1,
      name: r'cantidadActual',
      type: IsarType.double,
    ),
    r'categoria': PropertySchema(
      id: 2,
      name: r'categoria',
      type: IsarType.byte,
      enumMap: _InsumoIsarModelcategoriaEnumValueMap,
    ),
    r'esParaSecado': PropertySchema(
      id: 3,
      name: r'esParaSecado',
      type: IsarType.bool,
    ),
    r'fincaId': PropertySchema(
      id: 4,
      name: r'fincaId',
      type: IsarType.long,
    ),
    r'loteId': PropertySchema(
      id: 5,
      name: r'loteId',
      type: IsarType.long,
    ),
    r'nombre': PropertySchema(
      id: 6,
      name: r'nombre',
      type: IsarType.string,
    ),
    r'umbralMinimo': PropertySchema(
      id: 7,
      name: r'umbralMinimo',
      type: IsarType.double,
    ),
    r'unidadMedida': PropertySchema(
      id: 8,
      name: r'unidadMedida',
      type: IsarType.string,
    ),
    r'valorTotal': PropertySchema(
      id: 9,
      name: r'valorTotal',
      type: IsarType.double,
    ),
    r'valorUnitario': PropertySchema(
      id: 10,
      name: r'valorUnitario',
      type: IsarType.double,
    )
  },
  estimateSize: _insumoIsarModelEstimateSize,
  serialize: _insumoIsarModelSerialize,
  deserialize: _insumoIsarModelDeserialize,
  deserializeProp: _insumoIsarModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _insumoIsarModelGetId,
  getLinks: _insumoIsarModelGetLinks,
  attach: _insumoIsarModelAttach,
  version: '3.1.0+1',
);

int _insumoIsarModelEstimateSize(
  InsumoIsarModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nombre.length * 3;
  bytesCount += 3 + object.unidadMedida.length * 3;
  return bytesCount;
}

void _insumoIsarModelSerialize(
  InsumoIsarModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.beneficioId);
  writer.writeDouble(offsets[1], object.cantidadActual);
  writer.writeByte(offsets[2], object.categoria.index);
  writer.writeBool(offsets[3], object.esParaSecado);
  writer.writeLong(offsets[4], object.fincaId);
  writer.writeLong(offsets[5], object.loteId);
  writer.writeString(offsets[6], object.nombre);
  writer.writeDouble(offsets[7], object.umbralMinimo);
  writer.writeString(offsets[8], object.unidadMedida);
  writer.writeDouble(offsets[9], object.valorTotal);
  writer.writeDouble(offsets[10], object.valorUnitario);
}

InsumoIsarModel _insumoIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InsumoIsarModel();
  object.beneficioId = reader.readLongOrNull(offsets[0]);
  object.cantidadActual = reader.readDouble(offsets[1]);
  object.categoria = _InsumoIsarModelcategoriaValueEnumMap[
          reader.readByteOrNull(offsets[2])] ??
      CategoriaInsumo.operativo;
  object.esParaSecado = reader.readBool(offsets[3]);
  object.fincaId = reader.readLongOrNull(offsets[4]);
  object.id = id;
  object.loteId = reader.readLongOrNull(offsets[5]);
  object.nombre = reader.readString(offsets[6]);
  object.umbralMinimo = reader.readDouble(offsets[7]);
  object.unidadMedida = reader.readString(offsets[8]);
  object.valorTotal = reader.readDouble(offsets[9]);
  object.valorUnitario = reader.readDouble(offsets[10]);
  return object;
}

P _insumoIsarModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (_InsumoIsarModelcategoriaValueEnumMap[
              reader.readByteOrNull(offset)] ??
          CategoriaInsumo.operativo) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _InsumoIsarModelcategoriaEnumValueMap = {
  'operativo': 0,
  'veterinaria': 1,
  'maquinaria': 2,
  'consumibles': 3,
  'cosecha': 4,
};
const _InsumoIsarModelcategoriaValueEnumMap = {
  0: CategoriaInsumo.operativo,
  1: CategoriaInsumo.veterinaria,
  2: CategoriaInsumo.maquinaria,
  3: CategoriaInsumo.consumibles,
  4: CategoriaInsumo.cosecha,
};

Id _insumoIsarModelGetId(InsumoIsarModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _insumoIsarModelGetLinks(InsumoIsarModel object) {
  return [];
}

void _insumoIsarModelAttach(
    IsarCollection<dynamic> col, Id id, InsumoIsarModel object) {
  object.id = id;
}

extension InsumoIsarModelQueryWhereSort
    on QueryBuilder<InsumoIsarModel, InsumoIsarModel, QWhere> {
  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension InsumoIsarModelQueryWhere
    on QueryBuilder<InsumoIsarModel, InsumoIsarModel, QWhereClause> {
  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterWhereClause>
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

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterWhereClause> idBetween(
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

extension InsumoIsarModelQueryFilter
    on QueryBuilder<InsumoIsarModel, InsumoIsarModel, QFilterCondition> {
  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      beneficioIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'beneficioId',
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      beneficioIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'beneficioId',
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      beneficioIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'beneficioId',
        value: value,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      beneficioIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'beneficioId',
        value: value,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      beneficioIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'beneficioId',
        value: value,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      beneficioIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'beneficioId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      cantidadActualEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantidadActual',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      cantidadActualGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cantidadActual',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      cantidadActualLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cantidadActual',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      cantidadActualBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cantidadActual',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      categoriaEqualTo(CategoriaInsumo value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoria',
        value: value,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      categoriaGreaterThan(
    CategoriaInsumo value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoria',
        value: value,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      categoriaLessThan(
    CategoriaInsumo value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoria',
        value: value,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      categoriaBetween(
    CategoriaInsumo lower,
    CategoriaInsumo upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoria',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      esParaSecadoEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'esParaSecado',
        value: value,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      fincaIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      fincaIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      fincaIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fincaId',
        value: value,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      loteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'loteId',
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      loteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'loteId',
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      loteIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loteId',
        value: value,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      nombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      nombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      umbralMinimoEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'umbralMinimo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      umbralMinimoGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'umbralMinimo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      umbralMinimoLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'umbralMinimo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      umbralMinimoBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'umbralMinimo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      unidadMedidaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unidadMedida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      unidadMedidaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unidadMedida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      unidadMedidaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unidadMedida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      unidadMedidaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unidadMedida',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      unidadMedidaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unidadMedida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      unidadMedidaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unidadMedida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      unidadMedidaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unidadMedida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      unidadMedidaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unidadMedida',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      unidadMedidaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unidadMedida',
        value: '',
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      unidadMedidaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unidadMedida',
        value: '',
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      valorTotalEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valorTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      valorTotalGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valorTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      valorTotalLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valorTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
      valorTotalBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valorTotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
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

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterFilterCondition>
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

extension InsumoIsarModelQueryObject
    on QueryBuilder<InsumoIsarModel, InsumoIsarModel, QFilterCondition> {}

extension InsumoIsarModelQueryLinks
    on QueryBuilder<InsumoIsarModel, InsumoIsarModel, QFilterCondition> {}

extension InsumoIsarModelQuerySortBy
    on QueryBuilder<InsumoIsarModel, InsumoIsarModel, QSortBy> {
  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      sortByBeneficioId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'beneficioId', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      sortByBeneficioIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'beneficioId', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      sortByCantidadActual() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadActual', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      sortByCantidadActualDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadActual', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      sortByCategoria() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      sortByCategoriaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      sortByEsParaSecado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esParaSecado', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      sortByEsParaSecadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esParaSecado', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy> sortByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      sortByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy> sortByLoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      sortByLoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      sortByUmbralMinimo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'umbralMinimo', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      sortByUmbralMinimoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'umbralMinimo', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      sortByUnidadMedida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidadMedida', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      sortByUnidadMedidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidadMedida', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      sortByValorTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorTotal', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      sortByValorTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorTotal', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      sortByValorUnitario() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorUnitario', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      sortByValorUnitarioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorUnitario', Sort.desc);
    });
  }
}

extension InsumoIsarModelQuerySortThenBy
    on QueryBuilder<InsumoIsarModel, InsumoIsarModel, QSortThenBy> {
  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      thenByBeneficioId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'beneficioId', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      thenByBeneficioIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'beneficioId', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      thenByCantidadActual() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadActual', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      thenByCantidadActualDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadActual', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      thenByCategoria() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      thenByCategoriaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      thenByEsParaSecado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esParaSecado', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      thenByEsParaSecadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esParaSecado', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy> thenByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      thenByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy> thenByLoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      thenByLoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loteId', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      thenByUmbralMinimo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'umbralMinimo', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      thenByUmbralMinimoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'umbralMinimo', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      thenByUnidadMedida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidadMedida', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      thenByUnidadMedidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidadMedida', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      thenByValorTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorTotal', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      thenByValorTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorTotal', Sort.desc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      thenByValorUnitario() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorUnitario', Sort.asc);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QAfterSortBy>
      thenByValorUnitarioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorUnitario', Sort.desc);
    });
  }
}

extension InsumoIsarModelQueryWhereDistinct
    on QueryBuilder<InsumoIsarModel, InsumoIsarModel, QDistinct> {
  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QDistinct>
      distinctByBeneficioId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'beneficioId');
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QDistinct>
      distinctByCantidadActual() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cantidadActual');
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QDistinct>
      distinctByCategoria() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoria');
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QDistinct>
      distinctByEsParaSecado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'esParaSecado');
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QDistinct>
      distinctByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fincaId');
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QDistinct> distinctByLoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loteId');
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QDistinct> distinctByNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QDistinct>
      distinctByUmbralMinimo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'umbralMinimo');
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QDistinct>
      distinctByUnidadMedida({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unidadMedida', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QDistinct>
      distinctByValorTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valorTotal');
    });
  }

  QueryBuilder<InsumoIsarModel, InsumoIsarModel, QDistinct>
      distinctByValorUnitario() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valorUnitario');
    });
  }
}

extension InsumoIsarModelQueryProperty
    on QueryBuilder<InsumoIsarModel, InsumoIsarModel, QQueryProperty> {
  QueryBuilder<InsumoIsarModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<InsumoIsarModel, int?, QQueryOperations> beneficioIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'beneficioId');
    });
  }

  QueryBuilder<InsumoIsarModel, double, QQueryOperations>
      cantidadActualProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cantidadActual');
    });
  }

  QueryBuilder<InsumoIsarModel, CategoriaInsumo, QQueryOperations>
      categoriaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoria');
    });
  }

  QueryBuilder<InsumoIsarModel, bool, QQueryOperations> esParaSecadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'esParaSecado');
    });
  }

  QueryBuilder<InsumoIsarModel, int?, QQueryOperations> fincaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fincaId');
    });
  }

  QueryBuilder<InsumoIsarModel, int?, QQueryOperations> loteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loteId');
    });
  }

  QueryBuilder<InsumoIsarModel, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<InsumoIsarModel, double, QQueryOperations>
      umbralMinimoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'umbralMinimo');
    });
  }

  QueryBuilder<InsumoIsarModel, String, QQueryOperations>
      unidadMedidaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unidadMedida');
    });
  }

  QueryBuilder<InsumoIsarModel, double, QQueryOperations> valorTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valorTotal');
    });
  }

  QueryBuilder<InsumoIsarModel, double, QQueryOperations>
      valorUnitarioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valorUnitario');
    });
  }
}
