class ConfiguracionFinca {
  final String id;
  final String fincaId;
  final double costoAlimentacion;
  // Podemos añadir más reglas de negocio aquí en el futuro
  // final double tarifaJornalPorDefecto;
  // final double precioKiloCafeEstimado;

  const ConfiguracionFinca({
    required this.id,
    required this.fincaId,
    this.costoAlimentacion = 15000.0,
  });

  ConfiguracionFinca copyWith({
    String? id,
    String? fincaId,
    double? costoAlimentacion,
  }) {
    return ConfiguracionFinca(
      id: id ?? this.id,
      fincaId: fincaId ?? this.fincaId,
      costoAlimentacion: costoAlimentacion ?? this.costoAlimentacion,
    );
  }
}
