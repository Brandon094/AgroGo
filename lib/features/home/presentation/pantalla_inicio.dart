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
    final lotesAsync = ref.watch(panelLotesNotifierProvider);
    final equipoAsync = ref.watch(trabajadoresNotifierProvider);

    return Column(
      children: [
        // 1. MISIÓN: PERÍMETRO (MANDATORIO)
        lotesAsync.maybeWhen(
          data: (l) {
            final tienePerimetro = l.any((x) => x.uso == TipoUsoLote.perimetro);
            if (tienePerimetro) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _CardAlerta(
                titulo: 'Misión 1: Fronteras', 
                subtitulo: 'Dibuje el límite total de su finca', 
                icono: Icons.architecture_rounded, 
                color: Colors.brown.shade700,
                onTap: () => context.push('/lotes/nuevo-lote?tipo=perimetro'),
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        ),

        // 2. MISIÓN: INFRAESTRUCTURA (Si ya tiene perímetro)
        lotesAsync.maybeWhen(
          data: (l) {
            final tienePerimetro = l.any((x) => x.uso == TipoUsoLote.perimetro);
            final tieneInfra = l.any((x) => x.uso == TipoUsoLote.infraestructura);
            if (!tienePerimetro || tieneInfra) return const SizedBox.shrink();
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _CardAlerta(
                titulo: 'Misión 2: Construcción', 
                subtitulo: 'Ubique casas, corrales o bodegas', 
                icono: Icons.factory_rounded, 
                color: Colors.blueGrey.shade600,
                onTap: () => context.push('/lotes/nuevo-lote?tipo=infraestructura'),
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        ),

        // 3. MISIÓN: CULTIVOS (Si ya tiene perímetro)
        lotesAsync.maybeWhen(
          data: (l) {
            final tienePerimetro = l.any((x) => x.uso == TipoUsoLote.perimetro);
            final tieneCultivos = l.any((x) => x.uso == TipoUsoLote.agricola);
            if (!tienePerimetro || tieneCultivos) return const SizedBox.shrink();
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _CardAlerta(
                titulo: 'Misión 3: Siembra', 
                subtitulo: 'Dibuje sus lotes de café o cacao', 
                icono: Icons.eco_rounded, 
                color: Colors.green.shade700,
                onTap: () => context.push('/lotes/nuevo-lote?tipo=agricola'),
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        ),

        // 4. MISIÓN: BODEGA (Si hay lotes)
        insumos.maybeWhen(
          data: (i) {
            if (i.isNotEmpty) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _CardAlerta(
                titulo: 'Misión 4: Inventario', 
                subtitulo: 'Cargue el stock inicial de su bodega', 
                icono: Icons.inventory_2_rounded, 
                color: Colors.indigo.shade600,
                onTap: () => context.push('/bodega'),
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        ),

        // 5. MISIÓN: EQUIPO (Si hay bodega)
        equipoAsync.maybeWhen(
          data: (e) {
            if (e.isNotEmpty) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _CardAlerta(
                titulo: 'Misión 5: Nómina', 
                subtitulo: 'Registre a su equipo de trabajo', 
                icono: Icons.people_alt_rounded, 
                color: Colors.teal.shade700,
                onTap: () => context.push('/trabajadores'),
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        ),

        // ALERTAS OPERATIVAS (Solo si ya pasó las misiones básicas)
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
    return Column(
      children: [
        // CARD 1: PATRIMONIO Y TIERRA
        _BentoGroupCard(
          titulo: 'PATRIMONIO Y TIERRA',
          color: Colors.green,
          items: [
            lotes.maybeWhen(
              data: (l) => _BentoItem(
                label: 'Área Total', 
                valor: '${l.fold<double>(0.0, (a, b) => a + b.areaEnHectareas).toStringAsFixed(1)} Ha',
                subLabel: '${l.length} Zonas',
                icono: Icons.landscape_rounded,
              ),
              orElse: () => const _BentoLoading(),
            ),
            costos.maybeWhen(
              data: (c) => _BentoItem(
                label: 'Inversión', 
                valor: Formateadores.formatearMonedaCompacta(c.fold<double>(0.0, (a, b) => a + b.precioTotal)),
                subLabel: 'Gastos acumulados',
                icono: Icons.payments_rounded,
              ),
              orElse: () => const _BentoLoading(),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // CARD 2: PRODUCCIÓN Y BENEFICIO
        _BentoGroupCard(
          titulo: 'PRODUCCIÓN Y ACTIVOS',
          color: Colors.orange,
          items: [
            beneficios.maybeWhen(
              data: (b) {
                final activos = b.where((x) => x.estado != EstadoBeneficio.listo).toList();
                return _BentoItem(
                  label: 'En Proceso', 
                  valor: '${activos.length} Lotes',
                  subLabel: 'Beneficio activo',
                  icono: Icons.settings_input_component_rounded,
                );
              },
              orElse: () => const _BentoLoading(),
            ),
            insumos.maybeWhen(
              data: (i) => _BentoItem(
                label: 'Capital Bodega', 
                valor: Formateadores.formatearMonedaCompacta(i.fold<double>(0.0, (sum, item) => sum + item.valorTotal)),
                subLabel: '${i.length} Ítems en stock',
                icono: Icons.inventory_2_rounded,
              ),
              orElse: () => const _BentoLoading(),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // CARD 3: RECURSOS Y TALENTO
        _BentoGroupCard(
          titulo: 'RECURSOS Y EQUIPO',
          color: Colors.teal,
          items: [
            animales.maybeWhen(
              data: (a) => _BentoItem(
                label: 'Pecuario', 
                valor: '${a.fold<int>(0, (sum, item) => sum + item.cantidadActual)}',
                subLabel: 'Animales totales',
                icono: Icons.pets_rounded,
              ),
              orElse: () => const _BentoLoading(),
            ),
            equipo.maybeWhen(
              data: (e) => _BentoItem(
                label: 'Nómina', 
                valor: '${e.length} Pers.',
                subLabel: 'Equipo activo',
                icono: Icons.people_alt_rounded,
              ),
              orElse: () => const _BentoLoading(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAtajos(BuildContext context) {
    final lotes = ref.read(panelLotesNotifierProvider).valueOrNull ?? [];
    final tienePerimetro = lotes.any((l) => l.uso == TipoUsoLote.perimetro);

    void verificarPerimetroAntesDeIr(String ruta, String mensaje) {
      if (tienePerimetro) {
        context.push(ruta);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(mensaje),
            backgroundColor: Colors.brown,
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'DIBUJAR',
              textColor: Colors.white,
              onPressed: () => context.push('/lotes/nuevo-lote?tipo=perimetro'),
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SeccionAtajos(
          titulo: 'GESTIÓN DIARIA',
          atajos: [
            _BotonAtajo(titulo: 'Gastos', icono: Icons.add_shopping_cart, color: Colors.blue, onTap: () => context.push('/gastos')),
            _BotonAtajo(titulo: 'Nómina', icono: Icons.payments, color: Colors.teal, onTap: () => context.push('/trabajadores')),
            _BotonAtajo(titulo: 'Agenda', icono: Icons.calendar_month, color: Colors.orange, onTap: () => context.go('/agenda')),
          ],
        ),
        const SizedBox(height: 24),
        _SeccionAtajos(
          titulo: 'INGENIERÍA Y MAPAS',
          atajos: [
            _BotonAtajo(titulo: 'Mapa Finca', icono: Icons.map, color: Colors.brown, onTap: () => context.push('/mapa-finca')),
            _BotonAtajo(
              titulo: 'Zonificar', 
              icono: Icons.landscape_rounded, 
              color: Colors.green, 
              onTap: () => tienePerimetro ? context.go('/lotes') : verificarPerimetroAntesDeIr('/lotes', 'Cree el perímetro para zonificar.')
            ),
            _BotonAtajo(
              titulo: 'Infraest.', 
              icono: Icons.factory_rounded, 
              color: Colors.blueGrey, 
              onTap: () => verificarPerimetroAntesDeIr(
                '/lotes/nuevo-lote?tipo=infraestructura', 
                'Debe dibujar el perímetro antes de ubicar infraestructura.'
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _SeccionAtajos(
          titulo: 'INVENTARIOS',
          atajos: [
            _BotonAtajo(titulo: 'Bodega', icono: Icons.inventory_2, color: Colors.indigo, onTap: () => context.push('/bodega')),
            _BotonAtajo(titulo: 'Beneficio', icono: Icons.settings_input_component_rounded, color: Colors.deepOrange, onTap: () => context.push('/proceso-cafe')),
            _BotonAtajo(titulo: 'Animales', icono: Icons.pets, color: Colors.purple, onTap: () => context.go('/dashboard/animales')),
          ],
        ),
      ],
    );
  }
}

class _BentoGroupCard extends StatelessWidget {
  final String titulo;
  final List<Widget> items;
  final Color color;

  const _BentoGroupCard({required this.titulo, required this.items, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: color.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))],
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: color, letterSpacing: 1.2)),
          const SizedBox(height: 16),
          Row(
            children: items.asMap().entries.map((e) {
              final isLast = e.key == items.length - 1;
              return Expanded(
                child: Row(
                  children: [
                    Expanded(child: e.value),
                    if (!isLast) Container(height: 40, width: 1, color: Colors.grey.withOpacity(0.2), margin: const EdgeInsets.symmetric(horizontal: 16)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _BentoItem extends StatelessWidget {
  final String label;
  final String valor;
  final String subLabel;
  final IconData icono;

  const _BentoItem({required this.label, required this.valor, required this.subLabel, required this.icono});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icono, size: 14, color: Colors.grey),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(valor, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
        ),
        Text(subLabel, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _SeccionAtajos extends StatelessWidget {
  final String titulo;
  final List<Widget> atajos;

  const _SeccionAtajos({required this.titulo, required this.atajos});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(titulo, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.blueGrey, letterSpacing: 1.5)),
        ),
        const SizedBox(height: 12),
        Row(
          children: atajos.asMap().entries.map((e) {
            return Expanded(child: Padding(
              padding: EdgeInsets.only(right: e.key == atajos.length - 1 ? 0 : 12),
              child: e.value,
            ));
          }).toList(),
        ),
      ],
    );
  }
}

class _BotonAtajo extends StatelessWidget {
  final String titulo;
  final IconData icono;
  final Color color;
  final VoidCallback onTap;

  const _BotonAtajo({required this.titulo, required this.icono, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
          border: Border.all(color: Colors.black.withOpacity(0.02)),
        ),
        child: Column(
          children: [
            Icon(icono, color: color, size: 26),
            const SizedBox(height: 8),
            Text(titulo, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF37474F))),
          ],
        ),
      ),
    );
  }
}

class _BentoLoading extends StatelessWidget {
  const _BentoLoading();
  @override
  Widget build(BuildContext context) {
    return const Center(child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)));
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
