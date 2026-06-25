class EspecieEntity {
  final String id;
  final String? fincaId;
  final String nombre;
  final String tipoEspecie;
  final int cantidadActual;
  final String? loteId;
  final double valorUnitario;
  final double valorTotalInversion;

  const EspecieEntity({
    required this.id,
    this.fincaId,
    required this.nombre,
    required this.tipoEspecie,
    required this.cantidadActual,
    this.loteId,
    this.valorUnitario = 0.0,
    this.valorTotalInversion = 0.0,
  });

  EspecieEntity copyWith({
    String? id,
    String? fincaId,
    String? nombre,
    String? tipoEspecie,
    int? cantidadActual,
    String? loteId,
    double? valorUnitario,
    double? valorTotalInversion,
  }) {
    return EspecieEntity(
      id: id ?? this.id,
      fincaId: fincaId ?? this.fincaId,
      nombre: nombre ?? this.nombre,
      tipoEspecie: tipoEspecie ?? this.tipoEspecie,
      cantidadActual: cantidadActual ?? this.cantidadActual,
      loteId: loteId ?? this.loteId,
      valorUnitario: valorUnitario ?? this.valorUnitario,
      valorTotalInversion: valorTotalInversion ?? this.valorTotalInversion,
    );
  }
}

class ControlSanitarioEntity {
  final String id;
  final String? fincaId; // NUEVO CAMPO
  final String especieId;
  final String tipo;
  final String producto;
  final DateTime fechaAplicacion;
  final DateTime proximaDosis;

  const ControlSanitarioEntity({
    required this.id,
    this.fincaId,
    required this.especieId,
    required this.tipo,
    required this.producto,
    required this.fechaAplicacion,
    required this.proximaDosis,
  });
}

class AlimentacionEntity {
  final String id;
  final String? fincaId; // NUEVO CAMPO
  final String especieId;
  final String producto;
  final double cantidadKilos;
  final DateTime fecha;
  final double? costoAsociado;

  const AlimentacionEntity({
    required this.id,
    this.fincaId,
    required this.especieId,
    required this.producto,
    required this.cantidadKilos,
    required this.fecha,
    this.costoAsociado,
  });
}
