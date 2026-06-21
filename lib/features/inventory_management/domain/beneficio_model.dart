enum EstadoBeneficio {
  cereza,   // Recién recolectado
  lavado,   // En fermentación/lavado
  secado,   // En la elva/sol
  listo,    // Pergamino seco listo para bodega
  vendido   // Vendido directamente (mojado o cereza)
}

class BeneficioEntity {
  final String id;
  final String? fincaId;
  final DateTime fechaInicio;
  final double kilosCereza; // Lo que viene de la nómina
  final double? kilosFinales; // El peso seco real al final
  final EstadoBeneficio estado;
  final String? loteOrigenNombre;

  const BeneficioEntity({
    required this.id,
    this.fincaId,
    required this.fechaInicio,
    required this.kilosCereza,
    this.kilosFinales,
    required this.estado,
    this.loteOrigenNombre,
  });

  BeneficioEntity copyWith({
    String? id,
    String? fincaId,
    DateTime? fechaInicio,
    double? kilosCereza,
    double? kilosFinales,
    EstadoBeneficio? estado,
    String? loteOrigenNombre,
  }) {
    return BeneficioEntity(
      id: id ?? this.id,
      fincaId: fincaId ?? this.fincaId,
      fechaInicio: fechaInicio ?? this.fechaInicio,
      kilosCereza: kilosCereza ?? this.kilosCereza,
      kilosFinales: kilosFinales ?? this.kilosFinales,
      estado: estado ?? this.estado,
      loteOrigenNombre: loteOrigenNombre ?? this.loteOrigenNombre,
    );
  }
}
