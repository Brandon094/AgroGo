import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../farm_calendar/presentation/providers/cronograma_notifier.dart';
import '../../inventory_costs/presentation/providers/costos_notifier.dart';
import '../../livestock/presentation/providers/pecuario_notifier.dart';
import '../../farms/presentation/providers/fincas_notifier.dart';
import '../../inventory_management/presentation/providers/insumos_notifier.dart';
import '../../inventory_management/presentation/providers/beneficio_notifier.dart';
import '../../maps_and_lots/presentation/providers/panel_lotes_notifier.dart';
import '../../field_workers/presentation/providers/trabajadores_notifier.dart';

import '../../farm_calendar/domain/tarea_model.dart';
import '../../inventory_management/domain/insumo_model.dart';
import '../../inventory_management/domain/beneficio_model.dart';
import '../../maps_and_lots/domain/lote_model.dart';
import '../../inventory_costs/domain/item_costo_model.dart';
import '../../livestock/domain/entidades_pecuario.dart';
import '../../field_workers/domain/trabajador_model.dart';
import '../../../core/utils/formatters.dart';

class PantallaInicio extends ConsumerStatefulWidget {
  const PantallaInicio({super.key});

  @override
  ConsumerState<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends ConsumerState<PantallaInicio> {
  late final String _fechaHoy;

  @override
  void initState() {
    super.initState();
    _fechaHoy = DateFormat('EEEE, d ' 'MMMM', 'es_CO').format(DateTime.now()).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final fincaAsync = ref.watch(fincaActualProvider);
    final tareasAsync = ref.watch(cronogramaNotifierProvider);
    final costosAsync = ref.watch(costosNotifierProvider);
    final animalesAsync = ref.watch(pecuarioNotifierProvider);
    final insumosAsync = ref.watch(insumosNotifierProvider);
    final lotesAsync = ref.watch(panelLotesNotifierProvider);
    final equipoAsync = ref.watch(trabajadoresNotifierProvider);
    final beneficioAsync = ref.watch(beneficioNotifierProvider);
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF9FBF9), Colors.white],
          ),
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // APP BAR ESTILO HERO
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 70, 24, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: const Icon(Icons.agriculture, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hacienda', style: TextStyle(fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.bold)),
                            fincaAsync.maybeWhen(
                              data: (f) => Text(f?.nombre ?? 'Mi Finca', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                              orElse: () => const Text('Cargando...', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton.filledTonal(
                          onPressed: () {
                            ref.read(fincaSeleccionadaProvider.notifier).limpiarFinca();
                            context.go('/');
                          },
                          icon: const Icon(Icons.swap_horiz_rounded),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(_fechaHoy, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Colors.teal, letterSpacing: 1.5)),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // ALERTAS DINÁMICAS (Diseño tipo Banner Moderno)
                  _buildAlertas(tareasAsync, insumosAsync),

                  const SizedBox(height: 32),
                  const Text('RESUMEN DE NEGOCIO', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.blueGrey, letterSpacing: 2)),
                  const SizedBox(height: 16),

                  // MÉTRICAS EN GRID BENTO PROFESIONAL
                  RepaintBoundary(
                    child: _buildMetricas(lotesAsync, costosAsync, animalesAsync, equipoAsync, insumosAsync, beneficioAsync),
                  ),

                  const SizedBox(height: 40),
                  const Text('GESTIÓN OPERATIVA', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.blueGrey, letterSpacing: 2)),
                  const SizedBox(height: 16),

                  // ATAJOS RÁPIDOS ESTILO PREMIUM
                  RepaintBoundary(
                    child: _buildAtajos(context),
                  ),
                  const SizedBox(height: 50),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertas(AsyncValue<List<TareaEntity>> tareas, AsyncValue<List<InsumoEntity>> insumos) {
    return Column(
      children: [
        tareas.maybeWhen(
          data: (t) {
            final hoy = DateTime.now();
            final pendientes = t.where((x) => !x.estaCompletada && x.fechaInicio.day == hoy.day).length;
            if (pendientes == 0) return const SizedBox.shrink();
            return _CardAlerta(
              titulo: 'Tienes $pendientes labores hoy', 
              subtitulo: 'Abre la agenda para completar', 
              icono: Icons.calendar_today_rounded, 
              color: const Color(0xFFF57C00),
              onTap: () => context.go('/agenda'),
            );
          },
          orElse: () => const SizedBox.shrink(),
        ),
        insumos.maybeWhen(
          data: (i) {
            final escasos = i.where((x) => x.esEscaso).length;
            if (escasos == 0) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: _CardAlerta(
                titulo: 'Bodega en rojo ($escasos)', 
                subtitulo: 'Se agotan los insumos críticos', 
                icono: Icons.inventory_2_rounded, 
                color: Colors.red.shade800, 
                esCritica: true,
                onTap: () => context.push('/bodega'),
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildMetricas(
    AsyncValue<List<Lote>> lotes, 
    AsyncValue<List<ItemCostoEntity>> costos, 
    AsyncValue<List<EspecieEntity>> animales, 
    AsyncValue<List<TrabajadorEntity>> equipo,
    AsyncValue<List<InsumoEntity>> insumos,
    AsyncValue<List<BeneficioEntity>> beneficios,
  ) {
    final textScale = MediaQuery.textScalerOf(context).scale(1.0);
    // Ajustamos el ratio y columnas según el tamaño de fuente
    final crossAxisCount = textScale > 1.8 ? 1 : 2;
    final aspectRatio = textScale > 1.4 ? 1.8 : 1.4;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: aspectRatio,
      children: [
        lotes.maybeWhen(
          data: (l) => _MetricaCard(
            titulo: 'Tierra', 
            valor: '${l.fold<double>(0.0, (a, b) => a + b.areaEnHectareas).toStringAsFixed(1)} Ha', 
            subtitulo: '${l.length} Lotes zonificados',
            icono: Icons.landscape_rounded,
            color: Colors.green.shade800,
          ),
          orElse: () => const _MetricaLoading(),
        ),
        costos.maybeWhen(
          data: (c) => _MetricaCard(
            titulo: 'Finanzas', 
            valor: Formateadores.formatearMonedaCompacta(c.fold<double>(0.0, (a, b) => a + b.precioTotal)),
            subtitulo: 'Inversión acumulada',
            icono: Icons.payments_rounded,
            color: Colors.blue.shade800,
          ),
          orElse: () => const _MetricaLoading(),
        ),
        beneficios.maybeWhen(
          data: (b) {
            final activos = b.where((x) => x.estado != EstadoBeneficio.listo).toList();
            final kilosSecandose = activos.where((x) => x.estado == EstadoBeneficio.secado).fold<double>(0, (sum, x) => sum + x.kilosCereza);
            return _MetricaCard(
              titulo: 'Beneficio', 
              valor: '${activos.length} Lotes', 
              subtitulo: kilosSecandose > 0 ? '${kilosSecandose.toStringAsFixed(0)}kg en secado' : 'Procesando café',
              icono: Icons.settings_input_component_rounded,
              color: Colors.orange.shade800,
            );
          },
          orElse: () => const _MetricaLoading(),
        ),
        insumos.maybeWhen(
          data: (i) => _MetricaCard(
            titulo: 'Bodega', 
            valor: '${i.length}', 
            subtitulo: '${i.where((x) => x.esEscaso).length} con poco stock',
            icono: Icons.inventory_2_rounded,
            color: Colors.brown,
          ),
          orElse: () => const _MetricaLoading(),
        ),
        animales.maybeWhen(
          data: (a) => _MetricaCard(
            titulo: 'Pecuario', 
            valor: '${a.fold<int>(0, (sum, item) => sum + item.cantidadActual)}', 
            subtitulo: 'Censo total de animales',
            icono: Icons.pets_rounded,
            color: Colors.purple.shade800,
          ),
          orElse: () => const _MetricaLoading(),
        ),
        equipo.maybeWhen(
          data: (e) => _MetricaCard(
            titulo: 'Equipo', 
            valor: '${e.length}', 
            subtitulo: 'Personas en nómina',
            icono: Icons.people_alt_rounded,
            color: Colors.teal.shade800,
          ),
          orElse: () => const _MetricaLoading(),
        ),
      ],
    );
  }

  Widget _buildAtajos(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(context).scale(1.0);
    final crossAxisCount = textScale > 1.6 ? 2 : 3;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _BotonMiniBento(titulo: 'Gastos', icono: Icons.add_shopping_cart, color: Colors.blue, onTap: () => context.push('/gastos')),
        _BotonMiniBento(titulo: 'Nómina', icono: Icons.payments, color: Colors.teal, onTap: () => context.push('/trabajadores')),
        _BotonMiniBento(titulo: 'Beneficio', icono: Icons.settings_input_component_rounded, color: Colors.orange.shade800, onTap: () => context.push('/proceso-cafe')),
        _BotonMiniBento(titulo: 'Animales', icono: Icons.pets, color: Colors.purple, onTap: () => context.go('/dashboard/animales')),
        _BotonMiniBento(titulo: 'Mapa', icono: Icons.map, color: Colors.brown, onTap: () => context.push('/mapa-finca')),
        _BotonMiniBento(titulo: 'Bodega', icono: Icons.inventory_2, color: Colors.blueGrey, onTap: () => context.push('/bodega')),
      ],
    );
  }
}

class _MetricaCard extends StatelessWidget {
  final String titulo;
  final String valor;
  final String subtitulo;
  final IconData icono;
  final Color color;

  const _MetricaCard({required this.titulo, required this.valor, required this.subtitulo, required this.icono, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: color.withOpacity(0.06), blurRadius: 20, offset: const Offset(0, 8))],
        border: Border.all(color: color.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(icono, color: color, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(titulo, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey), overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(valor, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
          ),
          const SizedBox(height: 2),
          Text(subtitulo, style: const TextStyle(fontSize: 11, color: Colors.grey), maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

class _BotonMiniBento extends StatelessWidget {
  final String titulo;
  final IconData icono;
  final Color color;
  final VoidCallback onTap;
  const _BotonMiniBento({required this.titulo, required this.icono, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icono, color: color, size: 30),
            const SizedBox(height: 8),
            Text(titulo, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF37474F))),
          ],
        ),
      ),
    );
  }
}

class _CardAlerta extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final IconData icono;
  final Color color;
  final bool esCritica;
  final VoidCallback? onTap;

  const _CardAlerta({required this.titulo, required this.subtitulo, required this.icono, required this.color, this.esCritica = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
              child: Icon(icono, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white)),
                  Text(subtitulo, style: const TextStyle(fontSize: 14, color: Colors.white70, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
          ],
        ),
      ),
    );
  }
}

class _MetricaLoading extends StatelessWidget {
  const _MetricaLoading();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
      child: const Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))),
    );
  }
}
