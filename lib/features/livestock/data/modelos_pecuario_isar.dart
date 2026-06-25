import 'package:isar/isar.dart';
import '../domain/entidades_pecuario.dart';

part 'modelos_pecuario_isar.g.dart';

@collection
class EspecieIsarModel {
  Id id = Isar.autoIncrement;
  int? fincaId;
  late String nombre;
  late String tipoEspecie;
  late int cantidadActual;
  int? loteId;
  late double valorUnitario;
  late double valorTotalInversion;

  late double costoInsumosAcumulado;
  late bool estaActivo;
  DateTime? fechaSalida;
  double? precioVentaTotal;
  double? kilosSalida;

  @enumerated
  TipoSalidaPecuaria tipoSalida = TipoSalidaPecuaria.ninguno;

  EspecieEntity toEntity() {
    return EspecieEntity(
      id: id.toString(),
      fincaId: fincaId?.toString(),
      nombre: nombre,
      tipoEspecie: tipoEspecie,
      cantidadActual: cantidadActual,
      loteId: loteId?.toString(),
      valorUnitario: valorUnitario,
      valorTotalInversion: valorTotalInversion,
      costoInsumosAcumulado: costoInsumosAcumulado,
      estaActivo: estaActivo,
      fechaSalida: fechaSalida,
      precioVentaTotal: precioVentaTotal,
      kilosSalida: kilosSalida,
      tipoSalida: tipoSalida == TipoSalidaPecuaria.ninguno ? null : tipoSalida,
    );
  }

  static EspecieIsarModel fromEntity(EspecieEntity entidad) {
    final modelo = EspecieIsarModel()
      ..fincaId = entidad.fincaId != null ? int.tryParse(entidad.fincaId!) : null
      ..nombre = entidad.nombre
      ..tipoEspecie = entidad.tipoEspecie
      ..cantidadActual = entidad.cantidadActual
      ..loteId = entidad.loteId != null ? int.tryParse(entidad.loteId!) : null
      ..valorUnitario = entidad.valorUnitario
      ..valorTotalInversion = entidad.valorTotalInversion
      ..costoInsumosAcumulado = entidad.costoInsumosAcumulado
      ..estaActivo = entidad.estaActivo
      ..fechaSalida = entidad.fechaSalida
      ..precioVentaTotal = entidad.precioVentaTotal
      ..kilosSalida = entidad.kilosSalida
      ..tipoSalida = entidad.tipoSalida ?? TipoSalidaPecuaria.ninguno;
    
    if (entidad.id.isNotEmpty && entidad.id != '0') {
      modelo.id = int.parse(entidad.id);
    }
    return modelo;
  }
}

@collection
class ControlSanitarioIsarModel {
  Id id = Isar.autoIncrement;
  int? fincaId; // NUEVO CAMPO
  late int especieId;
  late String tipo;
  late String producto;
  late DateTime fechaAplicacion;
  late DateTime proximaDosis;

  ControlSanitarioEntity toEntity() {
    return ControlSanitarioEntity(
      id: id.toString(),
      fincaId: fincaId?.toString(),
      especieId: especieId.toString(),
      tipo: tipo,
      producto: producto,
      fechaAplicacion: fechaAplicacion,
      proximaDosis: proximaDosis,
    );
  }

  static ControlSanitarioIsarModel fromEntity(ControlSanitarioEntity entidad) {
    final modelo = ControlSanitarioIsarModel()
      ..fincaId = entidad.fincaId != null ? int.tryParse(entidad.fincaId!) : null
      ..especieId = int.parse(entidad.especieId)
      ..tipo = entidad.tipo
      ..producto = entidad.producto
      ..fechaAplicacion = entidad.fechaAplicacion
      ..proximaDosis = entidad.proximaDosis;
    
    if (entidad.id.isNotEmpty && entidad.id != '0') {
      modelo.id = int.parse(entidad.id);
    }
    return modelo;
  }
}

@collection
class AlimentacionIsarModel {
  Id id = Isar.autoIncrement;
  int? fincaId; // NUEVO CAMPO
  late int especieId;
  late String producto;
  late double cantidadKilos;
  late DateTime fecha;
  double? costoAsociado;

  AlimentacionEntity toEntity() {
    return AlimentacionEntity(
      id: id.toString(),
      fincaId: fincaId?.toString(),
      especieId: especieId.toString(),
      producto: producto,
      cantidadKilos: cantidadKilos,
      fecha: fecha,
      costoAsociado: costoAsociado,
    );
  }

  static AlimentacionIsarModel fromEntity(AlimentacionEntity entidad) {
    final modelo = AlimentacionIsarModel()
      ..fincaId = entidad.fincaId != null ? int.tryParse(entidad.fincaId!) : null
      ..especieId = int.parse(entidad.especieId)
      ..producto = entidad.producto
      ..cantidadKilos = entidad.cantidadKilos
      ..fecha = entidad.fecha
      ..costoAsociado = entidad.costoAsociado;
    
    if (entidad.id.isNotEmpty && entidad.id != '0') {
      modelo.id = int.parse(entidad.id);
    }
    return modelo;
  }
}
