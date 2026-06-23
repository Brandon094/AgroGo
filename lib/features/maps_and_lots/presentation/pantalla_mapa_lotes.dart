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
      default: return 'Mapear Mi Lote';
    }
  }

  String _obtenerInstruccionMision() {
    switch (widget.tipoPredefinido) {
      case 'perimetro': return 'Toque las esquinas de TODA su finca para definir el borde total.';
      case 'infraestructura': return 'Dibuje el área de sus corrales, cocheras, casas o lagos.';
      case 'agricola': return 'Delinee la zona específica donde tiene sus cultivos.';
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al obtener señal GPS')),
      );
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
        title: Text(_obtenerTituloMision(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.7), Colors.transparent],
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
            onMapCreated: (c) {
              _controladorMapa = c;
              _iniciarPosicionamientoContextual();
            },
          ),

          // Banner de Instrucción Misión
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF00695C).withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.white, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _obtenerInstruccionMision(),
                      style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Selector de Modo (Híbrido)
          Positioned(
            top: 160,
            left: 0,
            right: 0,
            child: Center(
              child: SegmentedButton<ModoMapeo>(
                segments: const [
                  ButtonSegment(
                    value: ModoMapeo.manual,
                    label: Text('Manual'),
                    icon: Icon(Icons.touch_app),
                  ),
                  ButtonSegment(
                    value: ModoMapeo.gpsCampo,
                    label: Text('GPS Campo'),
                    icon: Icon(Icons.satellite_alt),
                  ),
                ],
                selected: {estadoMapa.modo},
                onSelectionChanged: (Set<ModoMapeo> newSelection) {
                  notificador.cambiarModo(newSelection.first);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) return const Color(0xFF00695C);
                      return Colors.white.withOpacity(0.9);
                    },
                  ),
                  foregroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) return Colors.white;
                      return Colors.black87;
                    },
                  ),
                ),
              ),
            ),
          ),

          // Banner de Advertencia Perímetro
          if (estadoMapa.mostrarAdvertenciaPerimetro)
            Positioned(
              top: 220,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade800.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.gpp_bad_rounded, color: Colors.white),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        '¡Punto fuera de límites! No puede dibujar fuera del perímetro de su finca.',
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

          // Banner de Advertencia GPS
          if (estadoMapa.mostrarAdvertenciaGps)
            Positioned(
              top: 280, // Bajamos este banner para que no se pisen
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade800.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '⚠️ Señal GPS inestable (Margen: ${estadoMapa.ultimoMargenError?.toStringAsFixed(1)}m). Por favor espere en la esquina o use Modo Manual.',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
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
            top: 360,
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
                const SizedBox(height: 12),
                if (estadoMapa.puntos.isNotEmpty) ...[
                  _BotonFlotanteMapa(
                    icono: Icons.delete_sweep,
                    onTap: () => notificador.limpiarMapa(),
                    color: Colors.red.shade100,
                    iconColor: Colors.red,
                  ),
                ],
              ],
            ),
          ),

          // Botón Gigante de Captura GPS
          if (estadoMapa.modo == ModoMapeo.gpsCampo)
            Positioned(
              bottom: 160,
              left: 40,
              right: 40,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00695C),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 80),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  elevation: 10,
                ),
                onPressed: _capturarEsquinaGps,
                icon: const Icon(Icons.gps_fixed, size: 32),
                label: const Text('CAPTURAR ESQUINA ACTUAL', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
              ),
            ),

          // Panel de Control Inferior (Resumen)
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ÁREA CALCULADA', style: TextStyle(color: Colors.grey.shade600, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
                          Text('${estadoMapa.areaEnHectareas.toStringAsFixed(3)} Ha', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF00695C))),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: const Color(0xFFF57C00).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                        child: const Text('Mapeando...', style: TextStyle(color: Color(0xFFF57C00), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      if (estadoMapa.puntos.isNotEmpty) ...[
                        _BotonAccion(
                          icono: Icons.undo_rounded,
                          color: Colors.grey.shade100,
                          onTap: notificador.deshacerUltimoPunto,
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00695C),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(0, 64),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: estadoMapa.puntos.length >= 3 ? () => _mostrarFormularioGuardar(context, estadoMapa) : null,
                          child: const Text('FINALIZAR Y GUARDAR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
        decoration: BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)]),
        child: Icon(icono, color: iconColor ?? Colors.black87),
      ),
    );
  }
}

class _BotonAccion extends StatelessWidget {
  final IconData icono;
  final Color color;
  final VoidCallback onTap;
  const _BotonAccion({required this.icono, required this.color, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 64, height: 64,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
        child: Icon(icono, size: 28),
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
  
  late TipoUsoLote _usoSeleccionado;

  final List<String> _infraestructurasPecuarias = ['Cochera', 'Galpón', 'Estanque', 'Corral', 'Potrero'];
  final List<String> _infraestructurasGenerales = ['Casa', 'Bodega', 'Secadero', 'Taller', 'Beneficiadero'];

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
            const Text('Detalles del Lote', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
            const SizedBox(height: 24),
            TextFormField(
              controller: _nombreCtrl, 
              decoration: const InputDecoration(labelText: 'Nombre del Lote', border: OutlineInputBorder(), prefixIcon: Icon(Icons.landscape)), 
              validator: (v) => v!.isEmpty ? 'Ingresa un nombre' : null
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<TipoUsoLote>(
              value: _usoSeleccionado,
              decoration: const InputDecoration(labelText: 'Tipo de Uso', border: OutlineInputBorder(), prefixIcon: Icon(Icons.category)),
              items: TipoUsoLote.values.map((u) => DropdownMenuItem(value: u, child: Text(u.name.toUpperCase()))).toList(),
              onChanged: widget.tipoPredefinido == null 
                ? (v) => setState(() {
                    _usoSeleccionado = v!;
                    _subCatCtrl.text = ''; 
                  })
                : null, // Bloqueado si viene de una misión específica
            ),
            const SizedBox(height: 16),
            if (widget.tipoPredefinido == 'infraestructura')
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Tipo de Infraestructura',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.factory_rounded),
                ),
                items: [
                  ..._infraestructurasPecuarias.map((i) => DropdownMenuItem(value: i, child: Text('$i (Animales)'))),
                  ..._infraestructurasGenerales.map((i) => DropdownMenuItem(value: i, child: Text(i))),
                ],
                onChanged: (v) => setState(() => _subCatCtrl.text = v!),
                validator: (v) => v == null ? 'Seleccione el tipo' : null,
              )
            else
              TextFormField(
                controller: _subCatCtrl,
                decoration: InputDecoration(
                  labelText: _usoSeleccionado == TipoUsoLote.agricola ? '¿Qué cultivo es?' : 'Subcategoría',
                  hintText: _usoSeleccionado == TipoUsoLote.agricola ? 'Ej: Café, Cacao' : 'Ej: Potrero, Estanque',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.eco)
                ),
                validator: (v) => v!.isEmpty ? 'Ingresa la categoría' : null,
              ),
            const SizedBox(height: 16),
            
            if (_usoSeleccionado == TipoUsoLote.agricola) ...[
              TextFormField(
                controller: _matasCtrl, 
                keyboardType: TextInputType.number, 
                decoration: const InputDecoration(labelText: 'Número de Matas', border: OutlineInputBorder(), prefixIcon: Icon(Icons.pin), suffixText: 'plantas'), 
                validator: (v) => v!.isEmpty ? 'Ingresa cantidad' : null
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _etapaSeleccionada,
                decoration: const InputDecoration(labelText: 'Etapa del Cultivo', border: OutlineInputBorder(), prefixIcon: Icon(Icons.psychology_alt_rounded)),
                items: _etapasCafe.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => _etapaSeleccionada = v),
                validator: (v) => v == null ? 'Selecciona una etapa' : null,
              ),
            ],
            
            if (_usoSeleccionado == TipoUsoLote.pecuario)
              TextFormField(
                controller: _capAnimCtrl, 
                keyboardType: TextInputType.number, 
                decoration: const InputDecoration(labelText: 'Capacidad de Animales', border: OutlineInputBorder(), prefixIcon: Icon(Icons.pets), suffixText: 'cabezas'),
                validator: (v) => v!.isEmpty ? 'Ingresa capacidad' : null
              ),

            const SizedBox(height: 24),
            if (_usoSeleccionado == TipoUsoLote.agricola) ...[
              const Text('CRONOGRAMA INICIAL', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
              const Divider(),
              _DatePickerTile(titulo: 'Próxima Abonada', fecha: _fechaAbonada, onTap: () => _pickDate('Abonada', (d) => _fechaAbonada = d)),
              
              if (_fechaAbonada != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButtonFormField<int>(
                    value: _mesesFrecuenciaAbono,
                    decoration: const InputDecoration(
                      labelText: 'Frecuencia de Abonada', 
                      prefixIcon: Icon(Icons.repeat_rounded),
                      helperText: 'Cenicafé: Levante cada 3 meses, Producción cada 4-6 meses.',
                    ),
                    items: [
                      const DropdownMenuItem(value: 2, child: Text('Cada 2 meses (Intensivo)')),
                      const DropdownMenuItem(value: 3, child: Text('Cada 3 meses (Levante/Soca)')),
                      const DropdownMenuItem(value: 4, child: Text('Cada 4 meses (Producción Pro)')),
                      const DropdownMenuItem(value: 6, child: Text('Cada 6 meses (Tradicional)')),
                    ],
                    onChanged: (v) => setState(() => _mesesFrecuenciaAbono = v!),
                  ),
                ),
              
              const SizedBox(height: 16),
              const Text('Cosecha Principal (Rango)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF37474F))),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: _mesInicioCosecha,
                      decoration: const InputDecoration(labelText: 'Inicia en', prefixIcon: Icon(Icons.play_arrow_rounded)),
                      items: List.generate(12, (i) => DropdownMenuItem(value: i + 1, child: Text(_meses[i]))),
                      onChanged: (v) => setState(() => _mesInicioCosecha = v),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: _mesFinCosecha,
                      decoration: const InputDecoration(labelText: 'Termina en', prefixIcon: Icon(Icons.stop_rounded)),
                      items: List.generate(12, (i) => DropdownMenuItem(value: i + 1, child: Text(_meses[i]))),
                      onChanged: (v) => setState(() => _mesFinCosecha = v),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Text('Temporada Mitaca (Rango)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF37474F))),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: _mesInicioMitaca,
                      decoration: const InputDecoration(labelText: 'Inicia en', prefixIcon: Icon(Icons.play_arrow_rounded)),
                      items: List.generate(12, (i) => DropdownMenuItem(value: i + 1, child: Text(_meses[i]))),
                      onChanged: (v) => setState(() => _mesInicioMitaca = v),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: _mesFinMitaca,
                      decoration: const InputDecoration(labelText: 'Termina en', prefixIcon: Icon(Icons.stop_rounded)),
                      items: List.generate(12, (i) => DropdownMenuItem(value: i + 1, child: Text(_meses[i]))),
                      onChanged: (v) => setState(() => _mesFinMitaca = v),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              _DatePickerTile(titulo: 'Próxima Fumigación', fecha: _fechaFumigada, onTap: () => _pickDate('Fumigación', (d) => _fechaFumigada = d)),

              if (_fechaFumigada != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButtonFormField<int>(
                    value: _mesesFrecuenciaFumiga,
                    decoration: const InputDecoration(labelText: 'Frecuencia de Fumigación', prefixIcon: Icon(Icons.repeat_rounded)),
                    items: [2, 3, 4, 6].map((m) => DropdownMenuItem(value: m, child: Text('Cada $m meses'))).toList(),
                    onChanged: (v) => setState(() => _mesesFrecuenciaFumiga = v!),
                  ),
                ),
            ],
            
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
                    areaEnHectareas: widget.estadoMapa.areaEnHectareas,
                    numeroMatas: int.tryParse(_matasCtrl.text) ?? 0,
                    capacidadAnimales: int.tryParse(_capAnimCtrl.text),
                    coordenadas: widget.estadoMapa.puntos.map((p) => CoordenadaLote(latitud: p.latitude, longitud: p.longitude)).toList(),
                    etapaCultivo: _usoSeleccionado == TipoUsoLote.agricola ? _etapaSeleccionada : null,
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
