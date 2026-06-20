class TareaEntity {
  final String id;
  final String? fincaId;
  final String titulo;
  final String tipoActividad;
  final DateTime fechaInicio;
  final DateTime fechaFinEstimada;
  final bool estaCompletada;
  final String? loteId;

  const TareaEntity({
    required this.id,
    this.fincaId,
    required this.titulo,
    required this.tipoActividad,
    required this.fechaInicio,
    required this.fechaFinEstimada,
    required this.estaCompletada,
    this.loteId,
  });

  TareaEntity copyWith({
    String? id,
    String? fincaId,
    String? titulo,
    String? tipoActividad,
    DateTime? fechaInicio,
    DateTime? fechaFinEstimada,
    bool? estaCompletada,
    String? loteId,
  }) {
    return TareaEntity(
      id: id ?? this.id,
      fincaId: fincaId ?? this.fincaId,
      titulo: titulo ?? this.titulo,
      tipoActividad: tipoActividad ?? this.tipoActividad,
      fechaInicio: fechaInicio ?? this.fechaInicio,
      fechaFinEstimada: fechaFinEstimada ?? this.fechaFinEstimada,
      estaCompletada: estaCompletada ?? this.estaCompletada,
      loteId: loteId ?? this.loteId,
    );
  }
}
