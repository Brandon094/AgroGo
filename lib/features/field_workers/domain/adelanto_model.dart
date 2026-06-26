class AdelantoEntity {
  final String id;
  final String? fincaId;
  final String trabajadorId;
  final double monto;
  final DateTime fecha;
  final String? motivo;
  final bool pagado; // Indica si ya se descontó de una nómina

  const AdelantoEntity({
    required this.id,
    this.fincaId,
    required this.trabajadorId,
    required this.monto,
    required this.fecha,
    this.motivo,
    this.pagado = false,
  });

  AdelantoEntity copyWith({
    String? id,
    String? fincaId,
    String? trabajadorId,
    double? monto,
    DateTime? fecha,
    String? motivo,
    bool? pagado,
  }) {
    return AdelantoEntity(
      id: id ?? this.id,
      fincaId: fincaId ?? this.fincaId,
      trabajadorId: trabajadorId ?? this.trabajadorId,
      monto: monto ?? this.monto,
      fecha: fecha ?? this.fecha,
      motivo: motivo ?? this.motivo,
      pagado: pagado ?? this.pagado,
    );
  }
}
