import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'providers/lote_mapa_notifier.dart';
import '../domain/lote_model.dart';
import '../data/repositorio_lotes.dart';
import 'providers/panel_lotes_notifier.dart';
import '../../farm_calendar/presentation/providers/cronograma_notifier.dart';
import '../../farms/presentation/providers/fincas_notifier.dart';

class PantallaMapaLotes extends ConsumerStatefulWidget {
  final String? tipoPredefinido;
  const PantallaMapaLotes({super.key, this.tipoPredefinido});

  @override
  ConsumerState<PantallaMapaLotes> createState() => _PantallaMapaLotesState();
}

class _PantallaMapaLotesState extends ConsumerState<PantallaMapaLotes> {
  GoogleMapController? _controladorMapa;
  bool _permisoUbicacionConcedido = false;
  MapType _tipoMapa = MapType.hybrid;

  static const CameraPosition _posicionCamaraInicial = CameraPosition(
    target: LatLng(4.9816, -75.6033),
    zoom: 16.0,
  );

  @override
  void initState() {
    super.initState();
    _verificarPermisosUbicacion();
    
    // Configurar si es perímetro en el notifier
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(loteMapaNotifierProvider.notifier).configurarComoPerimetro(widget.tipoPredefinido == 'perimetro');
    });
  }

  String _obtenerTituloMision() {
    switch (widget.tipoPredefinido) {
      case 'perimetro': return 'Delinear Perímetro Total';
      case 'infraestructura': return 'Mapear Infraestructura';
      case 'agricola': return 'Dibujar Lote de Cultivo';
      case 'forestal': return 'Zona de Conservación';
      case 'ornamental': return 'Huerta o Jardín';
      default: return 'Mapear Mi Lote';
    }
  }

  String _obtenerInstruccionMision() {
    switch (widget.tipoPredefinido) {
      case 'perimetro': return 'Toque las esquinas de TODA su finca para definir el borde total.';
      case 'infraestructura': return 'Dibuje el área de sus corrales, cocheras, casas o lagos.';
      case 'agricola': return 'Delinee la zona específica donde tiene sus cultivos.';
      case 'forestal': return 'Delimite sus bosques, guaduales o áreas protegidas.';
      case 'ornamental': return 'Marque sus jardines, huertas caseras o zonas verdes.';
      default: return 'Dibuje el polígono del lote en el mapa.';
    }
  }

  Future<void> _verificarPermisosUbicacion() async {
    LocationPermission permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
    }
    if (permiso == LocationPermission.always || permiso == LocationPermission.whileInUse) {
      if (mounted) setState(() => _permisoUbicacionConcedido = true);
    }
  }

  Future<void> _centrarEnGpsManual() async {
    if (!_permisoUbicacionConcedido) {
      await _verificarPermisosUbicacion();
    }
    if (_permisoUbicacionConcedido) {
      final posicion = await Geolocator.getCurrentPosition();
      _controladorMapa?.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(posicion.latitude, posicion.longitude), 18.0),
      );
    }
  }

  void _iniciarPosicionamientoContextual() async {
    final lotesExistentes = ref.read(panelLotesNotifierProvider).valueOrNull ?? [];
    
    if (lotesExistentes.isEmpty) {
      if (_permisoUbicacionConcedido) {
        final posicion = await Geolocator.getCurrentPosition();
        _controladorMapa?.animateCamera(CameraUpdate.newLatLngZoom(LatLng(posicion.latitude, posicion.longitude), 17.5));
      }
      return;
    }

    LatLng? centroEnfoque;
    final infra = lotesExistentes.where((l) => l.uso == TipoUsoLote.infraestructura).toList();
    if (infra.isNotEmpty) {
      centroEnfoque = _calcularCentroLote(infra.first.coordenadas);
    } else {
      double sumaLat = 0;
      double sumaLng = 0;
      int totalPuntos = 0;
      for (final lote in lotesExistentes) {
        for (final p in lote.coordenadas) {
          sumaLat += p.latitud;
          sumaLng += p.longitud;
          totalPuntos++;
        }
      }
      if (totalPuntos > 0) {
        centroEnfoque = LatLng(sumaLat / totalPuntos, sumaLng / totalPuntos);
      }
    }

    if (centroEnfoque != null && _controladorMapa != null) {
      _controladorMapa?.animateCamera(CameraUpdate.newLatLngZoom(centroEnfoque, 16.5));
    }
  }

  LatLng _calcularCentroLote(List<CoordenadaLote> coords) {
    double sLat = 0;
    double sLng = 0;
    for (var c in coords) {
      sLat += c.latitud;
      sLng += c.longitud;
    }
    return LatLng(sLat / coords.length, sLng / coords.length);
  }

  Future<void> _capturarEsquinaGps() async {
    if (!_permisoUbicacionConcedido) return;

    // Feedback háptico de inicio de captura
    HapticFeedback.mediumImpact();

    try {
      final posicion = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );
      
      final punto = LatLng(posicion.latitude, posicion.longitude);
      final aceptado = ref.read(loteMapaNotifierProvider.notifier).agregarPuntoGps(punto, posicion.accuracy);

      if (aceptado) {
        HapticFeedback.lightImpact();
        _controladorMapa?.animateCamera(CameraUpdate.newLatLng(punto));
      } else {
        HapticFeedback.vibrate();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al obtener señal GPS')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final estadoMapa = ref.watch(loteMapaNotifierProvider);
    final notificador = ref.read(loteMapaNotifierProvider.notifier);

    final todosLosPoligonos = {
      ...estadoMapa.poligonosPasivos,
      ...estadoMapa.poligonos,
    };

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(_obtenerTituloMision(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _posicionCamaraInicial,
            mapType: _tipoMapa,
            markers: estadoMapa.marcadores,
            polygons: todosLosPoligonos,
            onTap: estadoMapa.modo == ModoMapeo.manual ? notificador.agregarPunto : null,
            myLocationButtonEnabled: false,
            myLocationEnabled: _permisoUbicacionConcedido,
            zoomControlsEnabled: false,
            scrollGesturesEnabled: !estadoMapa.estaArrastrando,
            rotateGesturesEnabled: !estadoMapa.estaArrastrando,
            tiltGesturesEnabled: !estadoMapa.estaArrastrando,
            onMapCreated: (c) {
              _controladorMapa = c;
              _iniciarPosicionamientoContextual();
            },
          ),

          // 1. ÁREA CALCULADA (ARRIBA - MINIMALISTA)
          Positioned(
            top: 110,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF00695C).withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.area_chart_rounded, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      '${estadoMapa.areaEnHectareas.toStringAsFixed(3)} Ha',
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Banner de Advertencia Perímetro o Superposición (Unificado para no pisarse)
          if (estadoMapa.mostrarAdvertenciaPerimetro || estadoMapa.tieneSuperposicion)
            Positioned(
              top: 170,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (estadoMapa.tieneSuperposicion ? Colors.red.shade900 : Colors.red.shade800).withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      estadoMapa.tieneSuperposicion ? Icons.layers_clear_rounded : Icons.gpp_bad_rounded, 
                      color: Colors.white
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        estadoMapa.tieneSuperposicion 
                          ? '¡Área superpuesta! El lote choca con otro ya registrado.'
                          : '¡Punto fuera de límites!',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                    if (estadoMapa.mostrarAdvertenciaPerimetro)
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white, size: 20),
                        onPressed: notificador.ocultarAdvertencia,
                      )
                  ],
                ),
              ),
            ),

          // Banner de Advertencia GPS
          if (estadoMapa.mostrarAdvertenciaGps && !estadoMapa.tieneSuperposicion && !estadoMapa.mostrarAdvertenciaPerimetro)
            Positioned(
              top: 170,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade800.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning, color: Colors.white),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        '⚠️ Señal GPS inestable',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 20),
                      onPressed: notificador.ocultarAdvertencia,
                    )
                  ],
                ),
              ),
            ),

          // Controles Flotantes Laterales
          Positioned(
            right: 16,
            top: 220,
            child: Column(
              children: [
                _BotonFlotanteMapa(
                  icono: Icons.my_location,
                  onTap: _centrarEnGpsManual,
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                _BotonFlotanteMapa(
                  icono: _tipoMapa == MapType.hybrid ? Icons.layers_outlined : Icons.layers,
                  onTap: () => setState(() {
                    _tipoMapa = _tipoMapa == MapType.hybrid ? MapType.normal : MapType.hybrid;
                  }),
                  color: Colors.white,
                  iconColor: const Color(0xFF00695C),
                ),
              ],
            ),
          ),

          // Panel de Control Inferior (Todo abajo para acceso rápido)
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 2. INSTRUCCIÓN (MINIMALISTA)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline_rounded, size: 18, color: Color(0xFF00695C)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _obtenerInstruccionMision(),
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF37474F)),
                        ),
                      ),
                    ],
                  ),
                ),

                // PANEL BENTO MAESTRO
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, offset: const Offset(0, 10))],
                  ),
                  child: Column(
                    children: [
                      // 3. SELECTOR DE MODO (ACCESO RÁPIDO)
                      SegmentedButton<ModoMapeo>(
                        segments: const [
                          ButtonSegment(value: ModoMapeo.manual, label: Text('MANUAL'), icon: Icon(Icons.touch_app_rounded, size: 16)),
                          ButtonSegment(value: ModoMapeo.gpsCampo, label: Text('GPS CAMPO'), icon: Icon(Icons.satellite_alt_rounded, size: 16)),
                        ],
                        selected: {estadoMapa.modo},
                        onSelectionChanged: (Set<ModoMapeo> newSelection) => notificador.cambiarModo(newSelection.first),
                        style: SegmentedButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          selectedBackgroundColor: const Color(0xFF00695C),
                          selectedForegroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // BOTONES DE ACCIÓN
                      Row(
                        children: [
                          if (estadoMapa.puntos.isNotEmpty) ...[
                            _BotonAccionMini(
                              icono: Icons.undo_rounded,
                              onTap: notificador.deshacerUltimoPunto,
                              color: Colors.grey.shade100,
                            ),
                            const SizedBox(width: 12),
                            _BotonAccionMini(
                              icono: Icons.delete_outline_rounded,
                              onTap: notificador.limpiarMapa,
                              color: Colors.red.shade50,
                              iconColor: Colors.red,
                            ),
                            const SizedBox(width: 12),
                          ],
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: estadoMapa.tieneSuperposicion ? Colors.grey : const Color(0xFF00695C),
                                foregroundColor: Colors.white,
                                minimumSize: const Size(0, 56),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                elevation: 0,
                              ),
                              onPressed: (estadoMapa.puntos.length >= 3 && !estadoMapa.tieneSuperposicion) 
                                ? () => _mostrarFormularioGuardar(context, estadoMapa) 
                                : null,
                              child: Text(
                                estadoMapa.tieneSuperposicion ? 'ÁREA OCUPADA' : 'CONTINUAR', 
                                style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // BOTÓN GIGANTE GPS (Si está en ese modo)
                      if (estadoMapa.modo == ModoMapeo.gpsCampo) ...[
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange.shade800,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          onPressed: _capturarEsquinaGps,
                          icon: const Icon(Icons.gps_fixed),
                          label: const Text('CAPTURAR ESQUINA', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarFormularioGuardar(BuildContext context, LoteMapaState estado) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32.0))),
      builder: (context) => _FormularioGuardarLoteModal(estadoMapa: estado, tipoPredefinido: widget.tipoPredefinido),
    );
  }
}

class _BotonAccionMini extends StatelessWidget {
  final IconData icono;
  final VoidCallback onTap;
  final Color color;
  final Color? iconColor;
  const _BotonAccionMini({required this.icono, required this.onTap, required this.color, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 56, height: 56,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
        child: Icon(icono, color: iconColor ?? Colors.blueGrey, size: 22),
      ),
    );
  }
}

class _BotonFlotanteMapa extends StatelessWidget {
  final IconData icono;
  final VoidCallback onTap;
  final Color color;
  final Color? iconColor;
  const _BotonFlotanteMapa({required this.icono, required this.onTap, required this.color, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50, height: 50,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10)]),
        child: Icon(icono, color: iconColor ?? Colors.black87),
      ),
    );
  }
}

class _FormularioGuardarLoteModal extends ConsumerStatefulWidget {
  final LoteMapaState estadoMapa;
  final String? tipoPredefinido;
  const _FormularioGuardarLoteModal({required this.estadoMapa, this.tipoPredefinido});
  @override
  ConsumerState<_FormularioGuardarLoteModal> createState() => _FormularioGuardarLoteModalState();
}

class _FormularioGuardarLoteModalState extends ConsumerState<_FormularioGuardarLoteModal> {
  final _formularioKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _subCatCtrl = TextEditingController();
  final _matasCtrl = TextEditingController();
  final _capAnimCtrl = TextEditingController();
  final _densidadCtrl = TextEditingController();
  bool _tieneSombra = false;
  
  late TipoUsoLote _usoSeleccionado;
  TipoCultivo _cultivoSeleccionado = TipoCultivo.cafe;

  final List<String> _infraestructurasPecuarias = ['Cochera', 'Galpón', 'Estanque', 'Corral', 'Potrero'];
  final List<String> _infraestructurasGenerales = ['Casa', 'Bodega', 'Secadero', 'Taller', 'Beneficiadero'];
  final List<String> _infraestructurasRecreativas = ['Kiosco/Área Social', 'Piscina/Área Húmeda', 'Alojamiento/Casa en Árbol', 'Mirador/Observatorio'];

  @override
  void initState() {
    super.initState();
    _usoSeleccionado = _mapearTipoPredefinido(widget.tipoPredefinido);
    if (_usoSeleccionado == TipoUsoLote.perimetro) {
      _nombreCtrl.text = 'Perímetro Total';
      _subCatCtrl.text = 'Propiedad';
    }
  }

  TipoUsoLote _mapearTipoPredefinido(String? tipo) {
    switch (tipo) {
      case 'perimetro': return TipoUsoLote.perimetro;
      case 'infraestructura': return TipoUsoLote.infraestructura;
      case 'agricola': return TipoUsoLote.agricola;
      case 'forestal': return TipoUsoLote.forestal;
      case 'ornamental': return TipoUsoLote.ornamental;
      default: return TipoUsoLote.agricola;
    }
  }
  
  String? _etapaSeleccionada;
  
  final List<String> _etapasCafe = [
    'Recién Sembrado',
    'Crecimiento (Levante)',
    'En Producción',
    'Soca (Renovación)',
    'Abatido / Viejo'
  ];
  
  DateTime? _fechaAbonada;
  int _mesesFrecuenciaAbono = 3;
  
  DateTime? _fechaFumigada;
  int _mesesFrecuenciaFumiga = 4;
  
  // Rangos de Cosecha
  int? _mesInicioCosecha;
  int? _mesFinCosecha;
  int? _mesInicioMitaca;
  int? _mesFinMitaca;

  final List<String> _meses = [
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
  ];

  Future<void> _pickDate(String titulo, Function(DateTime) onPicked) async {
    final pick = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: titulo,
    );
    if (pick != null) setState(() => onPicked(pick));
  }

  void _actualizarFrecuenciasSugeridas() {
    if (_etapaSeleccionada == null) return;

    setState(() {
      switch (_cultivoSeleccionado) {
        case TipoCultivo.cafe:
          if (_etapaSeleccionada == 'En Producción') {
            _mesesFrecuenciaAbono = 4;
            _mesesFrecuenciaFumiga = 4;
          } else {
            _mesesFrecuenciaAbono = 3;
            _mesesFrecuenciaFumiga = 3;
          }
          break;
        case TipoCultivo.cacao:
          if (_etapaSeleccionada == 'En Producción') {
            _mesesFrecuenciaAbono = 6;
            _mesesFrecuenciaFumiga = 6;
          } else {
            _mesesFrecuenciaAbono = 4;
            _mesesFrecuenciaFumiga = 4;
          }
          break;
        case TipoCultivo.platano:
          _mesesFrecuenciaAbono = 2;
          _mesesFrecuenciaFumiga = 3;
          break;
        case TipoCultivo.otro:
          _mesesFrecuenciaAbono = 4;
          _mesesFrecuenciaFumiga = 4;
          break;
      }
    });
  }

  String _obtenerLabelSubCat() {
    switch (_usoSeleccionado) {
      case TipoUsoLote.agricola: return '¿Qué cultivo es?';
      case TipoUsoLote.forestal: return 'Tipo de Reserva';
      case TipoUsoLote.ornamental: return 'Tipo de área';
      default: return 'Subcategoría';
    }
  }

  String _obtenerHintSubCat() {
    switch (_usoSeleccionado) {
      case TipoUsoLote.agricola: return 'Ej: Café, Cacao';
      case TipoUsoLote.forestal: return 'Ej: Bosque nativo, Guadual';
      case TipoUsoLote.ornamental: return 'Ej: Jardín, Huerta casera';
      default: return 'Ej: Potrero, Estanque';
    }
  }

  IconData _obtenerIconoSubCat() {
    switch (_usoSeleccionado) {
      case TipoUsoLote.agricola: return Icons.eco;
      case TipoUsoLote.forestal: return Icons.park_rounded;
      case TipoUsoLote.ornamental: return Icons.local_florist_rounded;
      default: return Icons.category;
    }
  }

  void _sugerirNombre(String categoria) {
    if (_nombreCtrl.text.isNotEmpty && !(_infraestructurasGenerales.contains(_nombreCtrl.text.split(' ').first) || _infraestructurasPecuarias.contains(_nombreCtrl.text.split(' ').first) || _infraestructurasRecreativas.contains(_nombreCtrl.text.split(' ').first))) {
      // Si el usuario ya escribió algo personalizado que no empieza por una categoría, no lo pisamos
      return;
    }

    final lotesExistentes = ref.read(panelLotesNotifierProvider).valueOrNull ?? [];
    final conteo = lotesExistentes.where((l) => l.subCategoria == categoria).length;
    
    setState(() {
      _subCatCtrl.text = categoria;
      _nombreCtrl.text = '$categoria ${conteo + 1}';
    });
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _subCatCtrl.dispose();
    _matasCtrl.dispose();
    _capAnimCtrl.dispose();
    _densidadCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paddingTeclado = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24, 32, 24, 32 + paddingTeclado),
      child: Form(
        key: _formularioKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFF00695C).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(16)),
                  child: const Icon(Icons.edit_location_alt_rounded, color: Color(0xFF00695C), size: 28),
                ),
                const SizedBox(width: 16),
                const Text('Detalles del Lote', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
              ],
            ),
            const SizedBox(height: 32),
            
            // SECCIÓN 1: IDENTIFICACIÓN (Tipo Bento)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nombreCtrl, 
                    decoration: const InputDecoration(labelText: 'Nombre del Lote', prefixIcon: Icon(Icons.landscape)), 
                    validator: (v) => v!.isEmpty ? 'Ingresa un nombre' : null
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<TipoUsoLote>(
                    value: _usoSeleccionado,
                    decoration: const InputDecoration(labelText: 'Tipo de Uso', prefixIcon: Icon(Icons.category)),
                    items: TipoUsoLote.values.map((u) {
                      String label = u.name.toUpperCase();
                      if (u == TipoUsoLote.forestal) label = 'FORESTAL / CONSERVACIÓN';
                      if (u == TipoUsoLote.ornamental) label = 'ORNAMENTAL / HUERTA';
                      return DropdownMenuItem(value: u, child: Text(label));
                    }).toList(),
                    onChanged: widget.tipoPredefinido == null 
                      ? (v) => setState(() {
                          _usoSeleccionado = v!;
                          _subCatCtrl.text = ''; 
                        })
                      : null,
                  ),
                  const SizedBox(height: 16),
                  if (widget.tipoPredefinido == 'infraestructura')
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Tipo de Infraestructura', prefixIcon: Icon(Icons.factory_rounded)),
                      items: [
                        ..._infraestructurasPecuarias.map((i) => DropdownMenuItem(value: i, child: Text('$i (Animales)'))),
                        ..._infraestructurasRecreativas.map((i) => DropdownMenuItem(value: i, child: Text('$i (Recreativo)'))),
                        ..._infraestructurasGenerales.map((i) => DropdownMenuItem(value: i, child: Text(i))),
                      ],
                      onChanged: (v) {
                        if (v != null) _sugerirNombre(v);
                      },
                      validator: (v) => v == null ? 'Seleccione el tipo' : null,
                    )
                  else if (_usoSeleccionado == TipoUsoLote.agricola)
                    DropdownButtonFormField<TipoCultivo>(
                      value: _cultivoSeleccionado,
                      decoration: const InputDecoration(labelText: 'Tipo de Cultivo', prefixIcon: Icon(Icons.eco)),
                      items: [
                        const DropdownMenuItem(value: TipoCultivo.cafe, child: Text('CAFÉ')),
                        const DropdownMenuItem(value: TipoCultivo.cacao, child: Text('CACAO')),
                        const DropdownMenuItem(value: TipoCultivo.platano, child: Text('PLÁTANO')),
                        const DropdownMenuItem(value: TipoCultivo.otro, child: Text('OTRO / GENÉRICO')),
                      ],
                      onChanged: (v) => setState(() {
                        _cultivoSeleccionado = v!;
                        _subCatCtrl.text = v.name;
                        _sugerirNombre(v.name);
                      }),
                    )
                  else
                    TextFormField(
                      controller: _subCatCtrl,
                      decoration: InputDecoration(
                        labelText: _obtenerLabelSubCat(),
                        hintText: _obtenerHintSubCat(),
                        prefixIcon: Icon(_obtenerIconoSubCat())
                      ),
                      validator: (v) => v!.isEmpty ? 'Ingresa la categoría' : null,
                    ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),

            // SECCIÓN 2: DATOS TÉCNICOS
            if (_usoSeleccionado == TipoUsoLote.agricola || _usoSeleccionado == TipoUsoLote.pecuario)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    if (_usoSeleccionado == TipoUsoLote.agricola) ...[
                      TextFormField(
                        controller: _matasCtrl, 
                        keyboardType: TextInputType.number, 
                        decoration: const InputDecoration(labelText: 'Número de Matas', prefixIcon: Icon(Icons.pin), suffixText: 'plantas'), 
                        validator: (v) => v!.isEmpty ? 'Ingresa cantidad' : null
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _etapaSeleccionada,
                        decoration: const InputDecoration(labelText: 'Etapa del Cultivo', prefixIcon: Icon(Icons.psychology_alt_rounded)),
                        items: _etapasCafe.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (v) => setState(() {
                          _etapaSeleccionada = v;
                          _actualizarFrecuenciasSugeridas();
                        }),
                        validator: (v) => v == null ? 'Selecciona una etapa' : null,
                      ),
                      const SizedBox(height: 16),
                      if (_cultivoSeleccionado == TipoCultivo.cacao) ...[
                        SwitchListTile(
                          title: const Text('¿Tiene Sombra?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          subtitle: const Text('El cacao requiere regulación de luz'),
                          value: _tieneSombra,
                          onChanged: (v) => setState(() => _tieneSombra = v),
                          secondary: const Icon(Icons.wb_sunny_outlined),
                        ),
                        const SizedBox(height: 16),
                      ],
                      TextFormField(
                        controller: _densidadCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Densidad de Siembra',
                          hintText: 'Ej: 3x3, 2.5x2.5',
                          prefixIcon: Icon(Icons.grid_4x4_rounded),
                        ),
                      ),
                    ],
                    if (_usoSeleccionado == TipoUsoLote.pecuario)
                      TextFormField(
                        controller: _capAnimCtrl, 
                        keyboardType: TextInputType.number, 
                        decoration: const InputDecoration(labelText: 'Capacidad de Animales', prefixIcon: Icon(Icons.pets), suffixText: 'cabezas'),
                        validator: (v) => v!.isEmpty ? 'Ingresa capacidad' : null
                      ),
                  ],
                ),
              ),

            if (_usoSeleccionado == TipoUsoLote.forestal || _usoSeleccionado == TipoUsoLote.ornamental || (_usoSeleccionado == TipoUsoLote.infraestructura && _infraestructurasRecreativas.contains(_subCatCtrl.text)))
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Icon(
                      _usoSeleccionado == TipoUsoLote.forestal ? Icons.park_rounded : (_usoSeleccionado == TipoUsoLote.ornamental ? Icons.local_florist_rounded : Icons.pool_rounded),
                      color: const Color(0xFF1B5E20),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Zona de conservación, recreativa o uso doméstico. No requiere configuración comercial.',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),

            // SECCIÓN 3: CRONOGRAMA (Tipo Bento)
            if (_usoSeleccionado == TipoUsoLote.agricola)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('CRONOGRAMA TÉCNICO', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.blueGrey, letterSpacing: 1.2)),
                    const SizedBox(height: 16),
                    _DatePickerTile(titulo: 'Próxima Abonada', fecha: _fechaAbonada, onTap: () => _pickDate('Abonada', (d) => _fechaAbonada = d)),
                    
                    if (_fechaAbonada != null)
                      DropdownButtonFormField<int>(
                        value: _mesesFrecuenciaAbono,
                        decoration: const InputDecoration(
                          labelText: 'Frecuencia', 
                          prefixIcon: Icon(Icons.repeat_rounded),
                        ),
                        items: const [
                          DropdownMenuItem(value: 2, child: Text('Cada 2 meses (Intensivo)')),
                          DropdownMenuItem(value: 3, child: Text('Cada 3 meses (Levante)')),
                          DropdownMenuItem(value: 4, child: Text('Cada 4 meses (Producción)')),
                          DropdownMenuItem(value: 6, child: Text('Cada 6 meses (Tradicional)')),
                        ],
                        onChanged: (v) => setState(() => _mesesFrecuenciaAbono = v!),
                      ),
                    
                    const Divider(height: 32),
                    const Text('Temporada de Cosecha', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF37474F))),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: _mesInicioCosecha,
                            isDense: true,
                            decoration: const InputDecoration(
                              labelText: 'Inicio', 
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                            ),
                            items: List.generate(12, (i) => DropdownMenuItem(value: i + 1, child: Text(_meses[i], style: const TextStyle(fontSize: 12)))),
                            onChanged: (v) => setState(() => _mesInicioCosecha = v),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: _mesFinCosecha,
                            isDense: true,
                            decoration: const InputDecoration(
                              labelText: 'Fin', 
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                            ),
                            items: List.generate(12, (i) => DropdownMenuItem(value: i + 1, child: Text(_meses[i], style: const TextStyle(fontSize: 12)))),
                            onChanged: (v) => setState(() => _mesFinCosecha = v),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    const Text('Temporada Mitaca', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF37474F))),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: _mesInicioMitaca,
                            isDense: true,
                            decoration: const InputDecoration(
                              labelText: 'Inicio', 
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                            ),
                            items: List.generate(12, (i) => DropdownMenuItem(value: i + 1, child: Text(_meses[i], style: const TextStyle(fontSize: 12)))),
                            onChanged: (v) => setState(() => _mesInicioMitaca = v),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: _mesFinMitaca,
                            isDense: true,
                            decoration: const InputDecoration(
                              labelText: 'Fin', 
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                            ),
                            items: List.generate(12, (i) => DropdownMenuItem(value: i + 1, child: Text(_meses[i], style: const TextStyle(fontSize: 12)))),
                            onChanged: (v) => setState(() => _mesFinMitaca = v),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _DatePickerTile(titulo: 'Próxima Fumigación', fecha: _fechaFumigada, onTap: () => _pickDate('Fumigación', (d) => _fechaFumigada = d)),
                    
                    if (_fechaFumigada != null)
                      DropdownButtonFormField<int>(
                        value: _mesesFrecuenciaFumiga,
                        decoration: const InputDecoration(
                          labelText: 'Frecuencia de Fumigación', 
                          prefixIcon: Icon(Icons.repeat_rounded),
                        ),
                        items: [2, 3, 4, 6].map((m) => DropdownMenuItem(value: m, child: Text('Cada $m meses'))).toList(),
                        onChanged: (v) => setState(() => _mesesFrecuenciaFumiga = v!),
                      ),
                  ],
                ),
              ),

            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(0, 64), backgroundColor: const Color(0xFF00695C), foregroundColor: Colors.white),
              onPressed: () async {
                if (_formularioKey.currentState!.validate()) {
                  final fincaIdStr = ref.read(fincaSeleccionadaProvider);
                  final nuevoLote = Lote(
                    id: '',
                    fincaId: fincaIdStr,
                    nombre: _nombreCtrl.text,
                    uso: _usoSeleccionado,
                    subCategoria: _subCatCtrl.text,
                    tipoCultivo: _usoSeleccionado == TipoUsoLote.agricola ? _cultivoSeleccionado : null,
                    areaEnHectareas: widget.estadoMapa.areaEnHectareas,
                    numeroMatas: int.tryParse(_matasCtrl.text) ?? 0,
                    capacidadAnimales: int.tryParse(_capAnimCtrl.text),
                    coordenadas: widget.estadoMapa.puntos.map((p) => CoordenadaLote(latitud: p.latitude, longitud: p.longitude)).toList(),
                    etapaCultivo: _usoSeleccionado == TipoUsoLote.agricola ? _etapaSeleccionada : null,
                    tieneSombra: _usoSeleccionado == TipoUsoLote.agricola ? _tieneSombra : null,
                    densidadSiembra: _usoSeleccionado == TipoUsoLote.agricola ? _densidadCtrl.text : null,
                  );

                  // Convertir rangos de meses a fechas para el cronograma
                  DateTime? fechaCosecha;
                  if (_mesInicioCosecha != null) {
                    final now = DateTime.now();
                    int year = now.year;
                    if (_mesInicioCosecha! < now.month) year++;
                    fechaCosecha = DateTime(year, _mesInicioCosecha!, 1);
                  }

                  DateTime? fechaMitaca;
                  if (_mesInicioMitaca != null) {
                    final now = DateTime.now();
                    int year = now.year;
                    if (_mesInicioMitaca! < now.month) year++;
                    fechaMitaca = DateTime(year, _mesInicioMitaca!, 1);
                  }

                  final fechas = {
                    'Próxima Abonada': _fechaAbonada,
                    'Cosecha Principal': fechaCosecha,
                    'Temporada Mitaca': fechaMitaca,
                    'Próxima Fumigación': _fechaFumigada,
                  };

                  final res = await ref.read(repositorioLotesProvider).guardarLoteCompleto(
                    lote: nuevoLote, 
                    fechasCronograma: fechas,
                    mesesFrecuenciaAbono: _mesesFrecuenciaAbono,
                    mesesFrecuenciaFumiga: _mesesFrecuenciaFumiga,
                  );
                  
                  if (context.mounted) {
                    res.fold(
                      (f) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(f.mensaje))),
                      (_) {
                        ref.read(panelLotesNotifierProvider.notifier).refresh();
                        ref.read(cronogramaNotifierProvider.notifier).refresh();
                        ref.read(loteMapaNotifierProvider.notifier).limpiarMapa();
                        
                        final tipoCreado = _usoSeleccionado;
                        final nombreLote = _nombreCtrl.text;
                        final subCat = _subCatCtrl.text;
                        
                        Navigator.pop(context); // Cierra Modal
                        Navigator.pop(context); // Cierra Pantalla Mapa

                        // Si es pecuario o infraestructura pecuaria, preguntar si quiere agregarlos
                        final esInfraPecuaria = tipoCreado == TipoUsoLote.infraestructura && 
                                              _infraestructurasPecuarias.contains(subCat);
                        
                        if (tipoCreado == TipoUsoLote.pecuario || esInfraPecuaria) {
                          _mostrarDialogoAccionRapidaAnimales(context, nombreLote);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('¡Lote guardado con éxito!'), 
                              backgroundColor: Color(0xFF00695C),
                              behavior: SnackBarBehavior.floating,
                            )
                          );
                        }
                      }
                    );
                  }
                }
              },
              child: const Text('GUARDAR LOTE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoAccionRapidaAnimales(BuildContext context, String nombreLote) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.pets_rounded, color: Colors.purple),
            SizedBox(width: 12),
            Text('¡Lote Creado!', style: TextStyle(fontWeight: FontWeight.w900)),
          ],
        ),
        content: Text('¿Desea ingresar los animales que van a estar en "$nombreLote" ahora mismo?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text('MÁS TARDE', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              context.push('/dashboard/animales');
            }, 
            child: const Text('SÍ, AGREGAR ANIMALES')
          ),
        ],
      ),
    );
  }
}

class _DatePickerTile extends StatelessWidget {
  final String titulo;
  final DateTime? fecha;
  final VoidCallback onTap;
  const _DatePickerTile({required this.titulo, required this.fecha, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.calendar_today, color: fecha != null ? const Color(0xFF1B5E20) : Colors.grey),
      title: Text(titulo, style: const TextStyle(fontSize: 16)),
      subtitle: Text(fecha == null ? 'Programar' : '${fecha!.day}/${fecha!.month}/${fecha!.year}', style: TextStyle(color: fecha != null ? Colors.black87 : Colors.grey)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
