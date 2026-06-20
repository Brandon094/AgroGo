import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../farm_calendar/presentation/providers/cronograma_notifier.dart';
import '../../inventory_costs/presentation/providers/costos_notifier.dart';
import '../../livestock/presentation/providers/pecuario_notifier.dart';
import '../../farms/presentation/providers/fincas_notifier.dart';
import '../../inventory_management/presentation/providers/insumos_notifier.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class PantallaInicio extends ConsumerStatefulWidget {
  const PantallaInicio({super.key});

  @override
  ConsumerState<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends ConsumerState<PantallaInicio> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = 'Toca el micrófono para hablar';

  @override
  Widget build(BuildContext context) {
    final tareasAsync = ref.watch(cronogramaNotifierProvider);
    final costosAsync = ref.watch(costosNotifierProvider);
    final animalesAsync = ref.watch(pecuarioNotifierProvider);
    final fincaAsync = ref.watch(fincaActualProvider);
    final insumosAsync = ref.watch(insumosNotifierProvider);
    
    final fechaHoy = DateFormat('EEEE, d ' 'MMMM', 'es_CO').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8), 
      body: CustomScrollView(
        slivers: [
          // Header con Saludo
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          fincaAsync.maybeWhen(
                            data: (f) => f?.nombre ?? 'Mi Finca',
                            orElse: () => 'Cargando...',
                          ),
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF1B5E20)),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          ref.read(fincaSeleccionadaProvider.notifier).limpiarFinca();
                          context.go('/');
                        },
                        icon: const Icon(Icons.swap_horiz_rounded, color: Color(0xFF1B5E20), size: 30),
                        tooltip: 'Cambiar Finca',
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    fechaHoy.toUpperCase(),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey.shade600, letterSpacing: 1.2),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Alerta Predictiva (Agenda)
                tareasAsync.when(
                  data: (tareas) {
                    final hoy = DateTime.now();
                    final tareasHoy = tareas.where((t) => 
                      !t.estaCompletada && 
                      t.fechaInicio.year == hoy.year && 
                      t.fechaInicio.month == hoy.month && 
                      t.fechaInicio.day == hoy.day
                    ).toList();

                    if (tareasHoy.isEmpty) return const SizedBox.shrink();

                    return _CardAlerta(
                      cantidad: tareasHoy.length,
                      primeraTarea: tareasHoy.first.titulo,
                    );
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),

                // Alerta de Inventario (Bajo stock)
                insumosAsync.when(
                  data: (insumos) {
                    final escasos = insumos.where((i) => i.esEscaso).toList();
                    if (escasos.isEmpty) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: _CardAlerta(
                        cantidad: escasos.length,
                        primeraTarea: 'Queda poco ${escasos.first.nombre}',
                        esCritica: true,
                      ),
                    );
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),

                const SizedBox(height: 32),
                const Text(
                  'Gestión Rápida',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 16),

                // Bento Grid de Atajos
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: [
                    _BotonBento(
                      titulo: 'Registrar\nGasto',
                      icono: Icons.add_shopping_cart,
                      color: Colors.blue.shade700,
                      onTap: () => context.push('/gastos'),
                    ),
                    _BotonBento(
                      titulo: 'Mi\nEquipo',
                      icono: Icons.people_alt,
                      color: Colors.teal.shade700,
                      onTap: () => context.push('/trabajadores'),
                    ),
                    _BotonBento(
                      titulo: 'Proyectar\nInsumos',
                      icono: Icons.calculate,
                      color: Colors.orange.shade800,
                      onTap: () => context.push('/gastos'), // Redirige a gastos donde está la calculadora
                    ),
                    _BotonBento(
                      titulo: 'Mis\nAnimales',
                      icono: Icons.pets,
                      color: Colors.purple.shade700,
                      onTap: () => context.go('/dashboard/animales'),
                    ),
                    _BotonBento(
                      titulo: 'Mapa\nGlobal',
                      icono: Icons.map_outlined,
                      color: Colors.brown.shade700,
                      onTap: () => context.push('/mapa-finca'),
                    ),
                    _BotonBento(
                      titulo: 'Mi\nBodega',
                      icono: Icons.inventory_2,
                      color: const Color(0xFF3E2723),
                      onTap: () => context.push('/bodega'),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _listen,
        backgroundColor: _isListening ? Colors.red : const Color(0xFF1B5E20),
        child: Icon(_isListening ? Icons.mic : Icons.mic_none, color: Colors.white),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              // Simulación de procesamiento de lenguaje natural local
              if (_text.toLowerCase().contains('gasto')) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Comando detectado: Registrar Gasto...')));
              }
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      if (_text != 'Toca el micrófono para hablar') {
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Escuché: "$_text"')));
      }
    }
  }
}

class _CardAlerta extends StatelessWidget {
  final int cantidad;
  final String primeraTarea;
  final bool esCritica;

  const _CardAlerta({required this.cantidad, required this.primeraTarea, this.esCritica = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: esCritica 
            ? [const Color(0xFFFFCCBC), const Color(0xFFFFAB91)] // Tonos rojizos para crítico
            : [const Color(0xFFFFF176), const Color(0xFFFFD54F)]
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: (esCritica ? Colors.red : Colors.amber).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: Row(
        children: [
          Icon(
            esCritica ? Icons.inventory_2_rounded : Icons.warning_amber_rounded, 
            size: 40, 
            color: esCritica ? Colors.red.shade900 : const Color(0xFF795548)
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  esCritica ? 'Alerta de Bodega' : 'Hoy tienes $cantidad tareas',
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold, 
                    color: esCritica ? Colors.red.shade900 : const Color(0xFF5D4037)
                  ),
                ),
                Text(
                  primeraTarea,
                  style: TextStyle(color: esCritica ? Colors.red.shade800 : const Color(0xFF795548)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: esCritica ? Colors.red.shade900 : const Color(0xFF795548)),
        ],
      ),
    );
  }
}

class _BotonBento extends StatelessWidget {
  final String titulo;
  final IconData icono;
  final Color color;
  final VoidCallback onTap;

  const _BotonBento({required this.titulo, required this.icono, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icono, color: color, size: 32),
            Text(
              titulo,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, height: 1.2, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
