import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'providers/fincas_notifier.dart';
import '../../maps_and_lots/domain/lote_model.dart';
import '../../maps_and_lots/presentation/providers/panel_lotes_notifier.dart';
import '../../inventory_management/presentation/providers/insumos_notifier.dart';
import '../../farm_calendar/presentation/providers/cronograma_notifier.dart';
import '../../field_workers/presentation/providers/trabajadores_notifier.dart';
import '../../livestock/presentation/providers/pecuario_notifier.dart';

class PantallaOnboarding extends ConsumerStatefulWidget {
  const PantallaOnboarding({super.key});

  @override
  ConsumerState<PantallaOnboarding> createState() => _PantallaOnboardingState();
}

class _PantallaOnboardingState extends ConsumerState<PantallaOnboarding> {
  int _pasoActual = 0;
  bool? _tieneAnimales; // null: no preguntado, true/false: respuesta
  bool _permisosConcedidos = false;

  @override
  void initState() {
    super.initState();
    _revisarPermisosIniciales();
  }

  Future<void> _revisarPermisosIniciales() async {
    final status = await Geolocator.checkPermission();
    if (status == LocationPermission.always || status == LocationPermission.whileInUse) {
      setState(() {
        _permisosConcedidos = true;
        _pasoActual = 1; // Salta a la finca si ya tiene permisos
      });
    }
  }

  Future<void> _solicitarPermisos() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      setState(() {
        _permisosConcedidos = true;
        _pasoActual = 1;
      });
    } else if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor habilite los permisos de ubicación en ajustes.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final fincas = ref.watch(fincasNotifierProvider).valueOrNull ?? [];
    final lotes = ref.watch(panelLotesNotifierProvider).valueOrNull ?? [];
    final insumos = ref.watch(insumosNotifierProvider).valueOrNull ?? [];
    final tareas = ref.watch(cronogramaNotifierProvider).valueOrNull ?? [];
    final equipo = ref.watch(trabajadoresNotifierProvider).valueOrNull ?? [];
    final animales = ref.watch(pecuarioNotifierProvider).valueOrNull ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: Column(
        children: [
          // Header Estilo Premium
          Container(
            padding: const EdgeInsets.fromLTRB(24, 70, 24, 32),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFF00695C).withOpacity(0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.psychology_alt_rounded, size: 40, color: Color(0xFF00695C)),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tutor AgroGo', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
                      Text('Configuración personalizada', style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => context.go('/dashboard'),
                  child: const Text('SALTAR', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),

          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(primary: const Color(0xFF00695C)),
              ),
              child: Stepper(
                key: ValueKey('stepper_animales_$_tieneAnimales'), // Reinicia el stepper si cambia la vocación
                type: StepperType.vertical,
                currentStep: _pasoActual,
                onStepTapped: (step) => setState(() => _pasoActual = step),
                controlsBuilder: (context, details) => const SizedBox.shrink(),
                elevation: 0,
                steps: _construirPasos(fincas, lotes, animales, insumos, tareas, equipo),
              ),
            ),
          ),

          if (equipo.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00695C),
                  minimumSize: const Size(double.infinity, 70),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  elevation: 8,
                ),
                onPressed: () => context.go('/dashboard'),
                child: const Text('¡TERMINAR CONFIGURACIÓN!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
              ),
            ),
        ],
      ),
    );
  }

  List<Step> _construirPasos(List fincas, List lotes, List animales, List insumos, List tareas, List equipo) {
    final pasos = <Step>[
      _pasoPermisos(),
      _pasoFinca(fincas),
      _pasoPerimetro(fincas, lotes),
      _pasoPreguntaAnimales(),
    ];

    if (_tieneAnimales == true) {
      pasos.add(_pasoInfraestructura(lotes, index: pasos.length));
      pasos.add(_pasoIngresarAnimales(animales, index: pasos.length));
    }

    pasos.add(_pasoLotesProductivos(lotes, index: pasos.length));
    pasos.add(_pasoBodega(lotes, insumos, index: pasos.length));
    pasos.add(_pasoEquipo(tareas, equipo, index: pasos.length));

    return pasos;
  }

  Step _pasoPermisos() => Step(
    title: const Text('Misión 1: Alistar Sensores', style: TextStyle(fontWeight: FontWeight.bold)),
    content: _ContenidoMision(
      descripcion: 'Para mapear su finca y detectar su ubicación, AgroGo necesita acceso al GPS.',
      icono: Icons.gps_fixed_rounded,
      completado: _permisosConcedidos,
      botonLabel: 'CONCEDER PERMISOS',
      onTap: _solicitarPermisos,
    ),
    isActive: _pasoActual == 0,
    state: _permisosConcedidos ? StepState.complete : StepState.indexed,
  );

  Step _pasoFinca(List fincas) => Step(
    title: const Text('Misión 2: Nombre de la Finca', style: TextStyle(fontWeight: FontWeight.bold)),
    content: _ContenidoMision(
      descripcion: 'Dele identidad a su propiedad para empezar.',
      icono: Icons.home_work_rounded,
      completado: fincas.isNotEmpty,
      botonLabel: 'REGISTRAR FINCA',
      onTap: () => _mostrarDialogoFinca(),
    ),
    isActive: _pasoActual == 1,
    state: fincas.isNotEmpty ? StepState.complete : StepState.indexed,
  );

  Step _pasoPerimetro(List fincas, List lotes) {
    final tienePerimetro = lotes.any((l) => l.uso == TipoUsoLote.perimetro);
    return Step(
      title: const Text('Misión 3: Perímetro (El Cascarón)', style: TextStyle(fontWeight: FontWeight.bold)),
      content: _ContenidoMision(
        descripcion: 'Dibuje el borde total de su tierra. Esto define su propiedad.',
        icono: Icons.architecture_rounded,
        completado: tienePerimetro,
        botonLabel: 'DIBUJAR LÍMITE TOTAL',
        onTap: () {
          if (fincas.isEmpty) return;
          ref.read(fincaSeleccionadaProvider.notifier).seleccionar(fincas.first.id);
          context.push('/lotes/nuevo-lote?tipo=perimetro');
        },
      ),
      isActive: _pasoActual == 2,
      state: tienePerimetro ? StepState.complete : StepState.indexed,
    );
  }

  Step _pasoPreguntaAnimales() => Step(
    title: const Text('Misión 4: Vocación Pecuaria', style: TextStyle(fontWeight: FontWeight.bold)),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('¿Usted maneja animales en esta finca? (Cerdos, Aves, Peces, etc.)', 
          style: TextStyle(fontSize: 16, color: Color(0xFF37474F), fontWeight: FontWeight.w500)),
        const SizedBox(height: 20),
                if (_tieneAnimales == null)
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => setState(() {
                    _tieneAnimales = true;
                    _pasoActual = 4; // Mueve a Infraestructura
                  }),
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('SÍ TENGO'),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00695C), foregroundColor: Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => setState(() {
                    _tieneAnimales = false;
                    _pasoActual = 4; // Salta a Lotes Productivos
                  }),
                  icon: const Icon(Icons.cancel_outlined),
                  label: const Text('NO TENGO'),
                ),
              ),
            ],
          )
        else
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                const Icon(Icons.verified_rounded, color: Colors.green, size: 28),
                const SizedBox(width: 12),
                Text(_tieneAnimales == true ? 'Vocación: Pecuaria' : 'Vocación: Solo Agrícola', 
                  style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.green)),
                const Spacer(),
                TextButton(onPressed: () => setState(() => _tieneAnimales = null), child: const Text('CAMBIAR'))
              ],
            ),
          )
      ],
    ),
    isActive: _pasoActual == 3,
    state: _tieneAnimales != null ? StepState.complete : StepState.indexed,
  );

  Step _pasoInfraestructura(List lotes, {required int index}) {
    final tieneInfra = lotes.any((l) => l.uso == TipoUsoLote.infraestructura || l.uso == TipoUsoLote.pecuario);
    return Step(
      title: const Text('Misión 4: Infraestructura', style: TextStyle(fontWeight: FontWeight.bold)),
      content: _ContenidoMision(
        descripcion: 'Ubique casas, corrales, cocheras o lagos dentro de su perímetro.',
        icono: Icons.factory_rounded,
        completado: tieneInfra,
        botonLabel: 'AGREGAR CONSTRUCCIONES',
        onTap: () => context.push('/lotes/nuevo-lote?tipo=infraestructura'),
      ),
      isActive: _pasoActual == index,
      state: tieneInfra ? StepState.complete : StepState.indexed,
    );
  }

  Step _pasoIngresarAnimales(List animales, {required int index}) => Step(
    title: const Text('Misión 5: Grupos Animales', style: TextStyle(fontWeight: FontWeight.bold)),
    content: _ContenidoMision(
      descripcion: 'Registre la cantidad y tipo de animales que tiene en cada corral.',
      icono: Icons.pets_rounded,
      completado: animales.isNotEmpty,
      botonLabel: 'REGISTRAR ANIMALES',
      onTap: () => context.push('/dashboard/animales'),
    ),
    isActive: _pasoActual == index,
    state: animales.isNotEmpty ? StepState.complete : StepState.indexed,
  );

  Step _pasoLotesProductivos(List lotes, {required int index}) {
    final tieneLotes = lotes.any((l) => l.uso == TipoUsoLote.agricola);
    return Step(
      title: const Text('Misión Lotes: Cultivos', style: TextStyle(fontWeight: FontWeight.bold)),
      content: _ContenidoMision(
        descripcion: 'Divida su tierra en lotes y asigne qué cultiva en cada uno.',
        icono: Icons.eco_rounded,
        completado: tieneLotes,
        botonLabel: 'DIBUJAR MIS CULTIVOS',
        onTap: () => context.push('/lotes/nuevo-lote?tipo=agricola'),
      ),
      isActive: _pasoActual == index,
      state: tieneLotes ? StepState.complete : StepState.indexed,
    );
  }

  Step _pasoBodega(List lotes, List insumos, {required int index}) {
    return Step(
      title: const Text('Misión Bodega: Insumos', style: TextStyle(fontWeight: FontWeight.bold)),
      content: _ContenidoMision(
        descripcion: 'Cargue su stock inicial de abonos, purinas y herramientas.',
        icono: Icons.inventory_2_rounded,
        completado: insumos.isNotEmpty,
        botonLabel: 'LLENAR MI BODEGA',
        onTap: () => context.push('/bodega'),
      ),
      isActive: _pasoActual == index,
      state: insumos.isNotEmpty ? StepState.complete : StepState.indexed,
    );
  }

  Step _pasoEquipo(List tareas, List equipo, {required int index}) {
    return Step(
      title: const Text('Misión Equipo: Nómina', style: TextStyle(fontWeight: FontWeight.bold)),
      content: _ContenidoMision(
        descripcion: 'Registre a sus trabajadores para liquidar nómina y tareas.',
        icono: Icons.people_alt_rounded,
        completado: equipo.isNotEmpty,
        botonLabel: 'REGISTRAR TRABAJADORES',
        onTap: () => context.push('/trabajadores'),
      ),
      isActive: _pasoActual == index,
      state: equipo.isNotEmpty ? StepState.complete : StepState.indexed,
    );
  }

  void _mostrarDialogoFinca() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _FormularioFincaModal(
        onSuccess: () => setState(() => _pasoActual = 2),
      ),
    );
  }
}

class _FormularioFincaModal extends ConsumerStatefulWidget {
  final VoidCallback onSuccess;
  const _FormularioFincaModal({required this.onSuccess});
  @override
  ConsumerState<_FormularioFincaModal> createState() => _FormularioFincaModalState();
}

class _FormularioFincaModalState extends ConsumerState<_FormularioFincaModal> {
  final _nombreCtrl = TextEditingController();
  final _ubicacionCtrl = TextEditingController();
  bool _cargandoUbicacion = false;

  Future<void> _detectarUbicacion() async {
    setState(() => _cargandoUbicacion = true);
    try {
      final posicion = await Geolocator.getCurrentPosition();
      final placemarks = await placemarkFromCoordinates(posicion.latitude, posicion.longitude);
      
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final info = '${p.locality ?? ''}, ${p.subAdministrativeArea ?? ''} (${p.administrativeArea ?? ''})';
        _ubicacionCtrl.text = info.replaceAll(RegExp(r'^, '), '');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo detectar la ubicación automáticamente')),
        );
      }
    } finally {
      if (mounted) setState(() => _cargandoUbicacion = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final paddingTeclado = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(28, 32, 28, 32 + paddingTeclado),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: const Color(0xFF00695C).withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
                child: const Icon(Icons.add_business_rounded, color: Color(0xFF00695C), size: 28),
              ),
              const SizedBox(width: 16),
              const Text('Mi Nueva Finca', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
            ],
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _nombreCtrl,
            decoration: const InputDecoration(
              labelText: 'Nombre de la Propiedad',
              hintText: 'Ej: Finca La Esperanza',
              prefixIcon: Icon(Icons.drive_file_rename_outline_rounded),
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                controller: _ubicacionCtrl,
                decoration: const InputDecoration(
                  labelText: 'Vereda / Ubicación',
                  hintText: 'Ej: Vereda El Socorro',
                  prefixIcon: Icon(Icons.location_on_rounded),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: _cargandoUbicacion 
                  ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                  : IconButton(
                      icon: const Icon(Icons.gps_fixed, color: Color(0xFF00695C)),
                      onPressed: _detectarUbicacion,
                      tooltip: 'Detectar mi ubicación',
                    ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00695C),
              minimumSize: const Size(double.infinity, 64),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () async {
              if (_nombreCtrl.text.isNotEmpty) {
                await ref.read(fincasNotifierProvider.notifier).agregarFinca(
                  nombre: _nombreCtrl.text.trim(), 
                  vereda: _ubicacionCtrl.text.trim()
                );
                if (mounted) {
                  Navigator.pop(context);
                  widget.onSuccess();
                }
              }
            },
            child: const Text('DAR DE ALTA FINCA', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
          ),
        ],
      ),
    );
  }
}

class _ContenidoMision extends StatelessWidget {
  final String descripcion;
  final IconData icono;
  final bool completado;
  final String botonLabel;
  final VoidCallback onTap;

  const _ContenidoMision({required this.descripcion, required this.icono, required this.completado, required this.botonLabel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(descripcion, style: const TextStyle(fontSize: 16, color: Color(0xFF37474F), fontWeight: FontWeight.w500)),
        const SizedBox(height: 20),
        if (completado)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(16)),
            child: const Row(
              children: [
                Icon(Icons.verified_rounded, color: Colors.green, size: 28),
                SizedBox(width: 12),
                Text('¡Misión Cumplida!', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.green)),
              ],
            ),
          )
        else
          ElevatedButton.icon(
            onPressed: onTap,
            icon: Icon(icono),
            label: Text(botonLabel, style: const TextStyle(fontWeight: FontWeight.w900)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF57C00),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
      ],
    );
  }
}
