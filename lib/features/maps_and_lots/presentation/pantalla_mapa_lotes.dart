import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  const PantallaMapaLotes({super.key});

  @override
  ConsumerState<PantallaMapaLotes> createState() => _PantallaMapaLotesState();
}

class _PantallaMapaLotesState extends ConsumerState<PantallaMapaLotes> {
  GoogleMapController? _controladorMapa;
  bool _permisoUbicacionConcedido = false;

  static const CameraPosition _posicionCamaraInicial = CameraPosition(
    target: LatLng(4.9816, -75.6033),
    zoom: 16.0,
  );

  @override
  void initState() {
    super.initState();
    _verificarPermisosUbicacion();
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
        title: const Text('Mapear Mi Lote', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
            mapType: MapType.hybrid,
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

          // Selector de Modo (Híbrido)
          Positioned(
            top: 100,
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
                      if (states.contains(WidgetState.selected)) return const Color(0xFF1B5E20);
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

          // Banner de Advertencia GPS
          if (estadoMapa.mostrarAdvertenciaGps)
            Positioned(
              top: 160,
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
            top: 220,
            child: Column(
              children: [
                _BotonFlotanteMapa(
                  icono: Icons.my_location,
                  onTap: _centrarEnGpsManual,
                  color: Colors.white,
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
                  backgroundColor: const Color(0xFF1B5E20),
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
                          Text('${estadoMapa.areaEnHectareas.toStringAsFixed(3)} Ha', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF1B5E20))),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
                        child: Text('${estadoMapa.puntos.length} Puntos', style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      if (estadoMapa.puntos.isNotEmpty) ...[
                        _BotonAccion(
                          icono: Icons.undo,
                          color: Colors.grey.shade200,
                          onTap: notificador.deshacerUltimoPunto,
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1B5E20),
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
      builder: (context) => _FormularioGuardarLoteModal(estadoMapa: estado),
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
  const _FormularioGuardarLoteModal({required this.estadoMapa});
  @override
  ConsumerState<_FormularioGuardarLoteModal> createState() => _FormularioGuardarLoteModalState();
}

class _FormularioGuardarLoteModalState extends ConsumerState<_FormularioGuardarLoteModal> {
  final _formularioKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _subCatCtrl = TextEditingController();
  final _matasCtrl = TextEditingController();
  final _capAnimCtrl = TextEditingController();
  
  TipoUsoLote _usoSeleccionado = TipoUsoLote.agricola;
  
  DateTime? _fechaAbonada;
  DateTime? _fechaCosecha;
  DateTime? _fechaFumigada;

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
              onChanged: (v) => setState(() {
                _usoSeleccionado = v!;
                _subCatCtrl.text = ''; 
              }),
            ),
            const SizedBox(height: 16),
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
            
            if (_usoSeleccionado == TipoUsoLote.agricola)
              TextFormField(
                controller: _matasCtrl, 
                keyboardType: TextInputType.number, 
                decoration: const InputDecoration(labelText: 'Número de Matas', border: OutlineInputBorder(), prefixIcon: Icon(Icons.pin)), 
                validator: (v) => v!.isEmpty ? 'Ingresa cantidad' : null
              ),
            
            if (_usoSeleccionado == TipoUsoLote.pecuario)
              TextFormField(
                controller: _capAnimCtrl, 
                keyboardType: TextInputType.number, 
                decoration: const InputDecoration(labelText: 'Capacidad de Animales', border: OutlineInputBorder(), prefixIcon: Icon(Icons.pets)), 
                validator: (v) => v!.isEmpty ? 'Ingresa capacidad' : null
              ),

            const SizedBox(height: 24),
            if (_usoSeleccionado == TipoUsoLote.agricola) ...[
              const Text('CRONOGRAMA INICIAL', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
              const Divider(),
              _DatePickerTile(titulo: 'Próxima Abonada', fecha: _fechaAbonada, onTap: () => _pickDate('Abonada', (d) => _fechaAbonada = d)),
              _DatePickerTile(titulo: 'Cosecha Principal', fecha: _fechaCosecha, onTap: () => _pickDate('Cosecha', (d) => _fechaCosecha = d)),
              _DatePickerTile(titulo: 'Próxima Fumigación', fecha: _fechaFumigada, onTap: () => _pickDate('Fumigación', (d) => _fechaFumigada = d)),
            ],
            
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(0, 64), backgroundColor: const Color(0xFF1B5E20), foregroundColor: Colors.white),
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
                  );

                  final fechas = {
                    'Próxima Abonada': _fechaAbonada,
                    'Cosecha Principal': _fechaCosecha,
                    'Próxima Fumigación': _fechaFumigada,
                  };

                  final res = await ref.read(repositorioLotesProvider).guardarLoteCompleto(lote: nuevoLote, fechasCronograma: fechas);
                  
                  res.fold(
                    (f) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(f.mensaje))),
                    (_) {
                      ref.read(panelLotesNotifierProvider.notifier).refresh();
                      ref.read(cronogramaNotifierProvider.notifier).refresh();
                      ref.read(loteMapaNotifierProvider.notifier).limpiarMapa();
                      Navigator.pop(context); Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('¡Lote guardado con éxito!'), backgroundColor: Color(0xFF1B5E20)));
                    }
                  );
                }
              },
              child: const Text('GUARDAR LOTE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ],
        ),
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
