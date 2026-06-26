enum TipoSalidaPecuaria { ninguno, ventaEnPie, sacrificio, otro }

class EspecieEntity {
  final String id;
  final String? fincaId;
  final String nombre;
  final String tipoEspecie;
  final int cantidadInicial;
  final int cantidadActual;
  final String? loteId;
  final double valorUnitario;
  final double valorTotalInversion; // Inversión inicial total (cantidadInicial * valorUnitario)
  
  final double costoInsumosAcumulado; // Alimentación + Sanidad acumulada de los que quedan
  final double utilidadesGeneradas; // Ingresos - Gastos de las salidas parciales ya realizadas
  final bool estaActivo;
  
  // Estos campos se usan para la salida FINAL o historial de la última salida
  final DateTime? fechaSalida;
  final double? precioVentaTotal;
  final double? kilosSalida;
  final TipoSalidaPecuaria? tipoSalida;

  const EspecieEntity({
    required this.id,
    this.fincaId,
    required this.nombre,
    required this.tipoEspecie,
    required this.cantidadInicial,
    required this.cantidadActual,
    this.loteId,
    this.valorUnitario = 0.0,
    this.valorTotalInversion = 0.0,
    this.costoInsumosAcumulado = 0.0,
    this.utilidadesGeneradas = 0.0,
    this.estaActivo = true,
    this.fechaSalida,
    this.precioVentaTotal,
    this.kilosSalida,
    this.tipoSalida,
  });

  /// Costo total que lleva el lote actualmente (lo invertido en compra + insumos)
  double get costoTotalLote => (cantidadActual * valorUnitario) + costoInsumosAcumulado;

  /// Lo que ha costado cada animal que está vivo hoy (Prorrateo)
  double get costoUnitarioActual => cantidadActual > 0 ? costoTotalLote / cantidadActual : 0.0;

  EspecieEntity copyWith({
    String? id,
    String? fincaId,
    String? nombre,
    String? tipoEspecie,
    int? cantidadInicial,
    int? cantidadActual,
    String? loteId,
    double? valorUnitario,
    double? valorTotalInversion,
    double? costoInsumosAcumulado,
    double? utilidadesGeneradas,
    bool? estaActivo,
    DateTime? fechaSalida,
    double? precioVentaTotal,
    double? kilosSalida,
    TipoSalidaPecuaria? tipoSalida,
  }) {
    return EspecieEntity(
      id: id ?? this.id,
      fincaId: fincaId ?? this.fincaId,
      nombre: nombre ?? this.nombre,
      tipoEspecie: tipoEspecie ?? this.tipoEspecie,
      cantidadInicial: cantidadInicial ?? this.cantidadInicial,
      cantidadActual: cantidadActual ?? this.cantidadActual,
      loteId: loteId ?? this.loteId,
      valorUnitario: valorUnitario ?? this.valorUnitario,
      valorTotalInversion: valorTotalInversion ?? this.valorTotalInversion,
      costoInsumosAcumulado: costoInsumosAcumulado ?? this.costoInsumosAcumulado,
      utilidadesGeneradas: utilidadesGeneradas ?? this.utilidadesGeneradas,
      estaActivo: estaActivo ?? this.estaActivo,
      fechaSalida: fechaSalida ?? this.fechaSalida,
      precioVentaTotal: precioVentaTotal ?? this.precioVentaTotal,
      kilosSalida: kilosSalida ?? this.kilosSalida,
      tipoSalida: tipoSalida ?? this.tipoSalida,
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
