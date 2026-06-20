/// Entidad de dominio que representa una propiedad o Finca.
class FincaEntity {
  final String id;
  final String nombre;
  final String? veredaUbicacion;
  final double? areaTotalHectareas;

  const FincaEntity({
    required this.id,
    required this.nombre,
    this.veredaUbicacion,
    this.areaTotalHectareas,
  });

  FincaEntity copyWith({
    String? id,
    String? nombre,
    String? veredaUbicacion,
    double? areaTotalHectareas,
  }) {
    return FincaEntity(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      veredaUbicacion: veredaUbicacion ?? this.veredaUbicacion,
      areaTotalHectareas: areaTotalHectareas ?? this.areaTotalHectareas,
    );
  }
}
