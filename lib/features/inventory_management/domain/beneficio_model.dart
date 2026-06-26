enum EstadoBeneficio {
  cereza,   // Recién recolectado
  lavado,   // En fermentación/lavado
  secado,   // En la elva/sol
  listo,    // Pergamino seco listo
  tostado,  // Café tostado
  molido,   // Café molido
  vendido   // Vendido directamente
}

class BeneficioEntity {
  final String id;
  final String? fincaId;
  final DateTime fechaInicio;
  final double kilosCereza; // Lo que viene de la nómina
  final double? kilosFinales; // El peso seco real al final
  final EstadoBeneficio estado;
  final String? loteOrigenNombre;
  
  final bool estaTostado;
  final bool estaMolido;
  final double costoProcesamiento;

  final String? beneficiaderoId;
  final String? beneficiaderoNombre;
  final String? secaderoId;
  final String? secaderoNombre;

  const BeneficioEntity({
    required this.id,
    this.fincaId,
    required this.fechaInicio,
    required this.kilosCereza,
    this.kilosFinales,
    required this.estado,
    this.loteOrigenNombre,
    this.estaTostado = false,
    this.estaMolido = false,
    this.costoProcesamiento = 0.0,
    this.beneficiaderoId,
    this.beneficiaderoNombre,
    this.secaderoId,
    this.secaderoNombre,
  });

  BeneficioEntity copyWith({
    String? id,
    String? fincaId,
    DateTime? fechaInicio,
    double? kilosCereza,
    double? kilosFinales,
    EstadoBeneficio? estado,
    String? loteOrigenNombre,
    bool? estaTostado,
    bool? estaMolido,
    double? costoProcesamiento,
    String? beneficiaderoId,
    String? beneficiaderoNombre,
    String? secaderoId,
    String? secaderoNombre,
  }) {
    return BeneficioEntity(
      id: id ?? this.id,
      fincaId: fincaId ?? this.fincaId,
      fechaInicio: fechaInicio ?? this.fechaInicio,
      kilosCereza: kilosCereza ?? this.kilosCereza,
      kilosFinales: kilosFinales ?? this.kilosFinales,
      estado: estado ?? this.estado,
      loteOrigenNombre: loteOrigenNombre ?? this.loteOrigenNombre,
      estaTostado: estaTostado ?? this.estaTostado,
      estaMolido: estaMolido ?? this.estaMolido,
      costoProcesamiento: costoProcesamiento ?? this.costoProcesamiento,
      beneficiaderoId: beneficiaderoId ?? this.beneficiaderoId,
      beneficiaderoNombre: beneficiaderoNombre ?? this.beneficiaderoNombre,
      secaderoId: secaderoId ?? this.secaderoId,
      secaderoNombre: secaderoNombre ?? this.secaderoNombre,
    );
  }
}
