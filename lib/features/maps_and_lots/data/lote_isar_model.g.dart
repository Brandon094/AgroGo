// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lote_isar_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLoteIsarModelCollection on Isar {
  IsarCollection<LoteIsarModel> get loteIsarModels => this.collection();
}

const LoteIsarModelSchema = CollectionSchema(
  name: r'LoteIsarModel',
  id: 21100672569688820,
  properties: {
    r'areaEnHectareas': PropertySchema(
      id: 0,
      name: r'areaEnHectareas',
      type: IsarType.double,
    ),
    r'capacidadAnimales': PropertySchema(
      id: 1,
      name: r'capacidadAnimales',
      type: IsarType.long,
    ),
    r'coordenadas': PropertySchema(
      id: 2,
      name: r'coordenadas',
      type: IsarType.objectList,
      target: r'CoordenadaLoteIsarModel',
    ),
    r'etapaCultivo': PropertySchema(
      id: 3,
      name: r'etapaCultivo',
      type: IsarType.string,
    ),
    r'fincaId': PropertySchema(
      id: 4,
      name: r'fincaId',
      type: IsarType.long,
    ),
    r'nombre': PropertySchema(
      id: 5,
      name: r'nombre',
      type: IsarType.string,
    ),
    r'numeroMatas': PropertySchema(
      id: 6,
      name: r'numeroMatas',
      type: IsarType.long,
    ),
    r'subCategoria': PropertySchema(
      id: 7,
      name: r'subCategoria',
      type: IsarType.string,
    ),
    r'uso': PropertySchema(
      id: 8,
      name: r'uso',
      type: IsarType.byte,
      enumMap: _LoteIsarModelusoEnumValueMap,
    )
  },
  estimateSize: _loteIsarModelEstimateSize,
  serialize: _loteIsarModelSerialize,
  deserialize: _loteIsarModelDeserialize,
  deserializeProp: _loteIsarModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'CoordenadaLoteIsarModel': CoordenadaLoteIsarModelSchema},
  getId: _loteIsarModelGetId,
  getLinks: _loteIsarModelGetLinks,
  attach: _loteIsarModelAttach,
  version: '3.1.0+1',
);

int _loteIsarModelEstimateSize(
  LoteIsarModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.coordenadas.length * 3;
  {
    final offsets = allOffsets[CoordenadaLoteIsarModel]!;
    for (var i = 0; i < object.coordenadas.length; i++) {
      final value = object.coordenadas[i];
      bytesCount += CoordenadaLoteIsarModelSchema.estimateSize(
          value, offsets, allOffsets);
    }
  }
  {
    final value = object.etapaCultivo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.nombre.length * 3;
  bytesCount += 3 + object.subCategoria.length * 3;
  return bytesCount;
}

void _loteIsarModelSerialize(
  LoteIsarModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.areaEnHectareas);
  writer.writeLong(offsets[1], object.capacidadAnimales);
  writer.writeObjectList<CoordenadaLoteIsarModel>(
    offsets[2],
    allOffsets,
    CoordenadaLoteIsarModelSchema.serialize,
    object.coordenadas,
  );
  writer.writeString(offsets[3], object.etapaCultivo);
  writer.writeLong(offsets[4], object.fincaId);
  writer.writeString(offsets[5], object.nombre);
  writer.writeLong(offsets[6], object.numeroMatas);
  writer.writeString(offsets[7], object.subCategoria);
  writer.writeByte(offsets[8], object.uso.index);
}

LoteIsarModel _loteIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LoteIsarModel();
  object.areaEnHectareas = reader.readDouble(offsets[0]);
  object.capacidadAnimales = reader.readLongOrNull(offsets[1]);
  object.coordenadas = reader.readObjectList<CoordenadaLoteIsarModel>(
        offsets[2],
        CoordenadaLoteIsarModelSchema.deserialize,
        allOffsets,
        CoordenadaLoteIsarModel(),
      ) ??
      [];
  object.etapaCultivo = reader.readStringOrNull(offsets[3]);
  object.fincaId = reader.readLongOrNull(offsets[4]);
  object.id = id;
  object.nombre = reader.readString(offsets[5]);
  object.numeroMatas = reader.readLong(offsets[6]);
  object.subCategoria = reader.readString(offsets[7]);
  object.uso =
      _LoteIsarModelusoValueEnumMap[reader.readByteOrNull(offsets[8])] ??
          TipoUsoLote.agricola;
  return object;
}

P _loteIsarModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readObjectList<CoordenadaLoteIsarModel>(
            offset,
            CoordenadaLoteIsarModelSchema.deserialize,
            allOffsets,
            CoordenadaLoteIsarModel(),
          ) ??
          []) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (_LoteIsarModelusoValueEnumMap[reader.readByteOrNull(offset)] ??
          TipoUsoLote.agricola) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _LoteIsarModelusoEnumValueMap = {
  'agricola': 0,
  'pecuario': 1,
  'forestal': 2,
  'infraestructura': 3,
  'perimetro': 4,
};
const _LoteIsarModelusoValueEnumMap = {
  0: TipoUsoLote.agricola,
  1: TipoUsoLote.pecuario,
  2: TipoUsoLote.forestal,
  3: TipoUsoLote.infraestructura,
  4: TipoUsoLote.perimetro,
};

Id _loteIsarModelGetId(LoteIsarModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _loteIsarModelGetLinks(LoteIsarModel object) {
  return [];
}

void _loteIsarModelAttach(
    IsarCollection<dynamic> col, Id id, LoteIsarModel object) {
  object.id = id;
}

extension LoteIsarModelQueryWhereSort
    on QueryBuilder<LoteIsarModel, LoteIsarModel, QWhere> {
  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LoteIsarModelQueryWhere
    on QueryBuilder<LoteIsarModel, LoteIsarModel, QWhereClause> {
  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterWhereClause> idBetween(
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

extension LoteIsarModelQueryFilter
    on QueryBuilder<LoteIsarModel, LoteIsarModel, QFilterCondition> {
  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      areaEnHectareasEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'areaEnHectareas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      areaEnHectareasGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'areaEnHectareas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      areaEnHectareasLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'areaEnHectareas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      areaEnHectareasBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'areaEnHectareas',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      capacidadAnimalesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'capacidadAnimales',
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      capacidadAnimalesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'capacidadAnimales',
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      capacidadAnimalesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'capacidadAnimales',
        value: value,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      capacidadAnimalesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'capacidadAnimales',
        value: value,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      capacidadAnimalesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'capacidadAnimales',
        value: value,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      capacidadAnimalesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'capacidadAnimales',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      coordenadasLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'coordenadas',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      coordenadasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'coordenadas',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      coordenadasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'coordenadas',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      coordenadasLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'coordenadas',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      coordenadasLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'coordenadas',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      coordenadasLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'coordenadas',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      etapaCultivoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'etapaCultivo',
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      etapaCultivoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'etapaCultivo',
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      etapaCultivoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'etapaCultivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      etapaCultivoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'etapaCultivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      etapaCultivoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'etapaCultivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      etapaCultivoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'etapaCultivo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      etapaCultivoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'etapaCultivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      etapaCultivoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'etapaCultivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      etapaCultivoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'etapaCultivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      etapaCultivoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'etapaCultivo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      etapaCultivoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'etapaCultivo',
        value: '',
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      etapaCultivoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'etapaCultivo',
        value: '',
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      fincaIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      fincaIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fincaId',
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      fincaIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fincaId',
        value: value,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
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

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
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

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
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

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
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

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
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

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
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

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
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

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
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

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
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

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
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

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      nombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      nombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      numeroMatasEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroMatas',
        value: value,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      numeroMatasGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numeroMatas',
        value: value,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      numeroMatasLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numeroMatas',
        value: value,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      numeroMatasBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numeroMatas',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      subCategoriaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subCategoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      subCategoriaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subCategoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      subCategoriaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subCategoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      subCategoriaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subCategoria',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      subCategoriaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subCategoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      subCategoriaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subCategoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      subCategoriaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subCategoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      subCategoriaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subCategoria',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      subCategoriaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subCategoria',
        value: '',
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      subCategoriaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subCategoria',
        value: '',
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition> usoEqualTo(
      TipoUsoLote value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uso',
        value: value,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      usoGreaterThan(
    TipoUsoLote value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uso',
        value: value,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition> usoLessThan(
    TipoUsoLote value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uso',
        value: value,
      ));
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition> usoBetween(
    TipoUsoLote lower,
    TipoUsoLote upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uso',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LoteIsarModelQueryObject
    on QueryBuilder<LoteIsarModel, LoteIsarModel, QFilterCondition> {
  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterFilterCondition>
      coordenadasElement(FilterQuery<CoordenadaLoteIsarModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'coordenadas');
    });
  }
}

extension LoteIsarModelQueryLinks
    on QueryBuilder<LoteIsarModel, LoteIsarModel, QFilterCondition> {}

extension LoteIsarModelQuerySortBy
    on QueryBuilder<LoteIsarModel, LoteIsarModel, QSortBy> {
  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy>
      sortByAreaEnHectareas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaEnHectareas', Sort.asc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy>
      sortByAreaEnHectareasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaEnHectareas', Sort.desc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy>
      sortByCapacidadAnimales() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capacidadAnimales', Sort.asc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy>
      sortByCapacidadAnimalesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capacidadAnimales', Sort.desc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy>
      sortByEtapaCultivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'etapaCultivo', Sort.asc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy>
      sortByEtapaCultivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'etapaCultivo', Sort.desc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy> sortByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy> sortByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy> sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy> sortByNumeroMatas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroMatas', Sort.asc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy>
      sortByNumeroMatasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroMatas', Sort.desc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy>
      sortBySubCategoria() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subCategoria', Sort.asc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy>
      sortBySubCategoriaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subCategoria', Sort.desc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy> sortByUso() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uso', Sort.asc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy> sortByUsoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uso', Sort.desc);
    });
  }
}

extension LoteIsarModelQuerySortThenBy
    on QueryBuilder<LoteIsarModel, LoteIsarModel, QSortThenBy> {
  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy>
      thenByAreaEnHectareas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaEnHectareas', Sort.asc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy>
      thenByAreaEnHectareasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaEnHectareas', Sort.desc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy>
      thenByCapacidadAnimales() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capacidadAnimales', Sort.asc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy>
      thenByCapacidadAnimalesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capacidadAnimales', Sort.desc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy>
      thenByEtapaCultivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'etapaCultivo', Sort.asc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy>
      thenByEtapaCultivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'etapaCultivo', Sort.desc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy> thenByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.asc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy> thenByFincaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fincaId', Sort.desc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy> thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy> thenByNumeroMatas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroMatas', Sort.asc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy>
      thenByNumeroMatasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroMatas', Sort.desc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy>
      thenBySubCategoria() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subCategoria', Sort.asc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy>
      thenBySubCategoriaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subCategoria', Sort.desc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy> thenByUso() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uso', Sort.asc);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QAfterSortBy> thenByUsoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uso', Sort.desc);
    });
  }
}

extension LoteIsarModelQueryWhereDistinct
    on QueryBuilder<LoteIsarModel, LoteIsarModel, QDistinct> {
  QueryBuilder<LoteIsarModel, LoteIsarModel, QDistinct>
      distinctByAreaEnHectareas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'areaEnHectareas');
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QDistinct>
      distinctByCapacidadAnimales() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'capacidadAnimales');
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QDistinct> distinctByEtapaCultivo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'etapaCultivo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QDistinct> distinctByFincaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fincaId');
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QDistinct> distinctByNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QDistinct>
      distinctByNumeroMatas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroMatas');
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QDistinct> distinctBySubCategoria(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subCategoria', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LoteIsarModel, LoteIsarModel, QDistinct> distinctByUso() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uso');
    });
  }
}

extension LoteIsarModelQueryProperty
    on QueryBuilder<LoteIsarModel, LoteIsarModel, QQueryProperty> {
  QueryBuilder<LoteIsarModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LoteIsarModel, double, QQueryOperations>
      areaEnHectareasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'areaEnHectareas');
    });
  }

  QueryBuilder<LoteIsarModel, int?, QQueryOperations>
      capacidadAnimalesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'capacidadAnimales');
    });
  }

  QueryBuilder<LoteIsarModel, List<CoordenadaLoteIsarModel>, QQueryOperations>
      coordenadasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coordenadas');
    });
  }

  QueryBuilder<LoteIsarModel, String?, QQueryOperations>
      etapaCultivoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'etapaCultivo');
    });
  }

  QueryBuilder<LoteIsarModel, int?, QQueryOperations> fincaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fincaId');
    });
  }

  QueryBuilder<LoteIsarModel, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<LoteIsarModel, int, QQueryOperations> numeroMatasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroMatas');
    });
  }

  QueryBuilder<LoteIsarModel, String, QQueryOperations> subCategoriaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subCategoria');
    });
  }

  QueryBuilder<LoteIsarModel, TipoUsoLote, QQueryOperations> usoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uso');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CoordenadaLoteIsarModelSchema = Schema(
  name: r'CoordenadaLoteIsarModel',
  id: -8040180917702130236,
  properties: {
    r'latitud': PropertySchema(
      id: 0,
      name: r'latitud',
      type: IsarType.double,
    ),
    r'longitud': PropertySchema(
      id: 1,
      name: r'longitud',
      type: IsarType.double,
    )
  },
  estimateSize: _coordenadaLoteIsarModelEstimateSize,
  serialize: _coordenadaLoteIsarModelSerialize,
  deserialize: _coordenadaLoteIsarModelDeserialize,
  deserializeProp: _coordenadaLoteIsarModelDeserializeProp,
);

int _coordenadaLoteIsarModelEstimateSize(
  CoordenadaLoteIsarModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _coordenadaLoteIsarModelSerialize(
  CoordenadaLoteIsarModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.latitud);
  writer.writeDouble(offsets[1], object.longitud);
}

CoordenadaLoteIsarModel _coordenadaLoteIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CoordenadaLoteIsarModel(
    latitud: reader.readDoubleOrNull(offsets[0]),
    longitud: reader.readDoubleOrNull(offsets[1]),
  );
  return object;
}

P _coordenadaLoteIsarModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CoordenadaLoteIsarModelQueryFilter on QueryBuilder<
    CoordenadaLoteIsarModel, CoordenadaLoteIsarModel, QFilterCondition> {
  QueryBuilder<CoordenadaLoteIsarModel, CoordenadaLoteIsarModel,
      QAfterFilterCondition> latitudIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'latitud',
      ));
    });
  }

  QueryBuilder<CoordenadaLoteIsarModel, CoordenadaLoteIsarModel,
      QAfterFilterCondition> latitudIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'latitud',
      ));
    });
  }

  QueryBuilder<CoordenadaLoteIsarModel, CoordenadaLoteIsarModel,
      QAfterFilterCondition> latitudEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CoordenadaLoteIsarModel, CoordenadaLoteIsarModel,
      QAfterFilterCondition> latitudGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CoordenadaLoteIsarModel, CoordenadaLoteIsarModel,
      QAfterFilterCondition> latitudLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CoordenadaLoteIsarModel, CoordenadaLoteIsarModel,
      QAfterFilterCondition> latitudBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latitud',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CoordenadaLoteIsarModel, CoordenadaLoteIsarModel,
      QAfterFilterCondition> longitudIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'longitud',
      ));
    });
  }

  QueryBuilder<CoordenadaLoteIsarModel, CoordenadaLoteIsarModel,
      QAfterFilterCondition> longitudIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'longitud',
      ));
    });
  }

  QueryBuilder<CoordenadaLoteIsarModel, CoordenadaLoteIsarModel,
      QAfterFilterCondition> longitudEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CoordenadaLoteIsarModel, CoordenadaLoteIsarModel,
      QAfterFilterCondition> longitudGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CoordenadaLoteIsarModel, CoordenadaLoteIsarModel,
      QAfterFilterCondition> longitudLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CoordenadaLoteIsarModel, CoordenadaLoteIsarModel,
      QAfterFilterCondition> longitudBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitud',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension CoordenadaLoteIsarModelQueryObject on QueryBuilder<
    CoordenadaLoteIsarModel, CoordenadaLoteIsarModel, QFilterCondition> {}
