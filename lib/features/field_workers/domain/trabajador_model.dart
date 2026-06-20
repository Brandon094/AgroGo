class TrabajadorEntity {
  final String id;
  final String? fincaId;
  final String nombreCompleto;
  final String tipoTrabajador;
  final double tarifaBase;
  final DateTime fechaIngreso;

  const TrabajadorEntity({
    required this.id,
    this.fincaId,
    required this.nombreCompleto,
    required this.tipoTrabajador,
    required this.tarifaBase,
    required this.fechaIngreso,
  });
}
