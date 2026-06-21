enum TipoUsoLote {
  agricola,
  pecuario,
  forestal,
  infraestructura
}

/// Modelo de dominio que representa un Lote o Zona de la finca.
class Lote {
  final String id;
  final String? fincaId;
  final String nombre;
  final TipoUsoLote uso;
  final String subCategoria; // Ej: "Café", "Potrero", "Estanque", "Bodega"
  final double areaEnHectareas;
  final int numeroMatas; // Solo para uso agrícola
  final int? capacidadAnimales; // Solo para uso pecuario
  final List<CoordenadaLote> coordenadas;
  final String? etapaCultivo; // Ej: "Recién Sembrado", "En Producción", "Soca"

  const Lote({
    required this.id,
    this.fincaId,
    required this.nombre,
    required this.uso,
    required this.subCategoria,
    required this.areaEnHectareas,
    this.numeroMatas = 0,
    this.capacidadAnimales,
    required this.coordenadas,
    this.etapaCultivo,
  });
}

class CoordenadaLote {
  final double latitud;
  final double longitud;
  const CoordenadaLote({required this.latitud, required this.longitud});
}
