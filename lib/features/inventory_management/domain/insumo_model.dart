class InsumoEntity {
  final String id;
  final String? fincaId;
  final String nombre;
  final String unidadMedida; // Ej: Bultos, Kilos, Litros
  final double cantidadActual;
  final double umbralMinimo;

  const InsumoEntity({
    required this.id,
    this.fincaId,
    required this.nombre,
    required this.unidadMedida,
    required this.cantidadActual,
    required this.umbralMinimo,
  });

  InsumoEntity copyWith({
    String? id,
    String? fincaId,
    String? nombre,
    String? unidadMedida,
    double? cantidadActual,
    double? umbralMinimo,
  }) {
    return InsumoEntity(
      id: id ?? this.id,
      fincaId: fincaId ?? this.fincaId,
      nombre: nombre ?? this.nombre,
      unidadMedida: unidadMedida ?? this.unidadMedida,
      cantidadActual: cantidadActual ?? this.cantidadActual,
      umbralMinimo: umbralMinimo ?? this.umbralMinimo,
    );
  }

  bool get esEscaso => cantidadActual <= umbralMinimo;
}
