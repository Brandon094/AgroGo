import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'providers/fincas_notifier.dart';
import '../../maps_and_lots/presentation/providers/panel_lotes_notifier.dart';
import '../../inventory_management/presentation/providers/insumos_notifier.dart';
import '../../farm_calendar/presentation/providers/cronograma_notifier.dart';
import '../../field_workers/presentation/providers/trabajadores_notifier.dart';

class PantallaOnboarding extends ConsumerStatefulWidget {
  const PantallaOnboarding({super.key});

  @override
  ConsumerState<PantallaOnboarding> createState() => _PantallaOnboardingState();
}

class _PantallaOnboardingState extends ConsumerState<PantallaOnboarding> {
  int _pasoActual = 0;

  @override
  Widget build(BuildContext context) {
    final fincas = ref.watch(fincasNotifierProvider).valueOrNull ?? [];
    final lotes = ref.watch(panelLotesNotifierProvider).valueOrNull ?? [];
    final insumos = ref.watch(insumosNotifierProvider).valueOrNull ?? [];
    final tareas = ref.watch(cronogramaNotifierProvider).valueOrNull ?? [];
    final equipo = ref.watch(trabajadoresNotifierProvider).valueOrNull ?? [];

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
                      Text('Configuración paso a paso', style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold)),
                    ],
                  ),
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
                type: StepperType.vertical,
                currentStep: _pasoActual,
                onStepTapped: (step) => setState(() => _pasoActual = step),
                controlsBuilder: (context, details) => const SizedBox.shrink(),
                elevation: 0,
                steps: [
                  _pasoFinca(fincas),
                  _pasoLote(fincas, lotes),
                  _pasoBodega(lotes, insumos),
                  _pasoAgenda(insumos, tareas),
                  _pasoEquipo(tareas, equipo),
                ],
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
                child: const Text('¡LISTO! IR AL DASHBOARD', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
              ),
            ),
        ],
      ),
    );
  }

  Step _pasoFinca(List fincas) => Step(
    title: const Text('Misión 1: Registro Inicial', style: TextStyle(fontWeight: FontWeight.bold)),
    content: _ContenidoMision(
      descripcion: 'Dele un nombre y ubicación a su propiedad para empezar la gestión.',
      icono: Icons.home_work_rounded,
      completado: fincas.isNotEmpty,
      botonLabel: 'CREAR MI PRIMERA FINCA',
      onTap: () => _mostrarDialogoFinca(),
    ),
    isActive: _pasoActual == 0,
    state: fincas.isNotEmpty ? StepState.complete : StepState.indexed,
  );

  Step _pasoLote(List fincas, List lotes) => Step(
    title: const Text('Misión 2: Mapa Satelital', style: TextStyle(fontWeight: FontWeight.bold)),
    content: _ContenidoMision(
      descripcion: 'Dibuje su primer lote de café o potrero para calcular las hectáreas.',
      icono: Icons.map_rounded,
      completado: lotes.isNotEmpty,
      botonLabel: 'DIBUJAR EN EL MAPA',
      onTap: () {
        if (fincas.isEmpty) return;
        ref.read(fincaSeleccionadaProvider.notifier).seleccionar(fincas.first.id);
        context.push('/lotes/nuevo-lote');
      },
    ),
    isActive: _pasoActual == 1,
    state: lotes.isNotEmpty ? StepState.complete : StepState.indexed,
  );

  Step _pasoBodega(List lotes, List insumos) => Step(
    title: const Text('Misión 3: Cargar Inventario', style: TextStyle(fontWeight: FontWeight.bold)),
    content: _ContenidoMision(
      descripcion: 'Registre los bultos de abono o herramientas que tiene en su bodega.',
      icono: Icons.inventory_2_rounded,
      completado: insumos.isNotEmpty,
      botonLabel: 'ABRIR MI BODEGA',
      onTap: () => context.push('/bodega'),
    ),
    isActive: _pasoActual == 2,
    state: insumos.isNotEmpty ? StepState.complete : StepState.indexed,
  );

  Step _pasoAgenda(List insumos, List tareas) => Step(
    title: const Text('Misión 4: Programar Labores', style: TextStyle(fontWeight: FontWeight.bold)),
    content: _ContenidoMision(
      descripcion: 'Agende una fumigación o abonada. El sistema le notificará.',
      icono: Icons.calendar_month_rounded,
      completado: tareas.isNotEmpty,
      botonLabel: 'USAR LA AGENDA',
      onTap: () => context.go('/agenda'),
    ),
    isActive: _pasoActual == 3,
    state: tareas.isNotEmpty ? StepState.complete : StepState.indexed,
  );

  Step _pasoEquipo(List tareas, List equipo) => Step(
    title: const Text('Misión 5: Equipo Humano', style: TextStyle(fontWeight: FontWeight.bold)),
    content: _ContenidoMision(
      descripcion: 'Agregue a sus trabajadores para liquidar sus pagos y recolección.',
      icono: Icons.people_alt_rounded,
      completado: equipo.isNotEmpty,
      botonLabel: 'REGISTRAR TRABAJADOR',
      onTap: () => context.push('/trabajadores'),
    ),
    isActive: _pasoActual == 4,
    state: equipo.isNotEmpty ? StepState.complete : StepState.indexed,
  );

  void _mostrarDialogoFinca() {
    final nombreCtrl = TextEditingController();
    final ubicacionCtrl = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nueva Finca', style: TextStyle(fontWeight: FontWeight.w900)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nombreCtrl, decoration: const InputDecoration(labelText: 'Nombre de su Finca', prefixIcon: Icon(Icons.business_rounded))),
            const SizedBox(height: 16),
            TextField(controller: ubicacionCtrl, decoration: const InputDecoration(labelText: 'Vereda / Ubicación', prefixIcon: Icon(Icons.location_on_rounded))),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(120, 50)),
            onPressed: () async {
              if (nombreCtrl.text.isNotEmpty) {
                await ref.read(fincasNotifierProvider.notifier).agregarFinca(nombre: nombreCtrl.text, vereda: ubicacionCtrl.text);
                if (mounted) {
                  Navigator.pop(context);
                  setState(() => _pasoActual = 1);
                }
              }
            },
            child: const Text('GUARDAR'),
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
