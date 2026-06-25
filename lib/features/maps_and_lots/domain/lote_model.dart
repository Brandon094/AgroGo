enum TipoUsoLote {
  agricola,
  pecuario,
  forestal,
  infraestructura,
  perimetro, // Representa el límite total de la finca (el cascarón)
  ornamental
}

enum TipoCultivo {
  cafe,
  cacao,
  platano,
  otro
}

/// Modelo de dominio que representa un Lote o Zona de la finca.
class Lote {
  final String id;
  final String? fincaId;
  final String nombre;
  final TipoUsoLote uso;
  final String subCategoria; // Ej: "Bodega", "Corral"
  final TipoCultivo? tipoCultivo; // Solo para uso agrícola
  final double areaEnHectareas;
  final int numeroMatas; // Solo para uso agrícola
  final int? capacidadAnimales; // Solo para uso pecuario
  final List<CoordenadaLote> coordenadas;
  final String? etapaCultivo; // Ej: "Recién Sembrado", "En Producción", "Soca"
  final bool? tieneSombra; // Para Cacao
  final String? densidadSiembra; // Ej: "3x3", "Bolillo"

  const Lote({
    required this.id,
    this.fincaId,
    required this.nombre,
    required this.uso,
    required this.subCategoria,
    this.tipoCultivo,
    required this.areaEnHectareas,
    this.numeroMatas = 0,
    this.capacidadAnimales,
    required this.coordenadas,
    this.etapaCultivo,
    this.tieneSombra,
    this.densidadSiembra,
  });
}

class CoordenadaLote {
  final double latitud;
  final double longitud;
  const CoordenadaLote({required this.latitud, required this.longitud});
}
