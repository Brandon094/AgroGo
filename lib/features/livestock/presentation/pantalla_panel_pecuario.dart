import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'providers/pecuario_notifier.dart';
import '../domain/entidades_pecuario.dart';

import 'package:agrogo/features/maps_and_lots/presentation/providers/panel_lotes_notifier.dart';
import 'package:agrogo/features/maps_and_lots/domain/lote_model.dart';

class PantallaPanelPecuario extends ConsumerWidget {
  const PantallaPanelPecuario({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadoEspecies = ref.watch(pecuarioNotifierProvider);
    final lotesAsync = ref.watch(panelLotesNotifierProvider);

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
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 70, 24, 32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Animales',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF37474F)),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.pets_rounded, color: Colors.purple),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // VALIDACIÓN GLOBAL DE INFRAESTRUCTURA
                    lotesAsync.when(
                      data: (lotes) {
                        final tieneInfra = lotes.any((l) => l.uso == TipoUsoLote.infraestructura || l.uso == TipoUsoLote.pecuario);
                        
                        if (!tieneInfra) {
                          return Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Colors.orange.shade200),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.warning_amber_rounded, color: Colors.orange.shade800),
                                    const SizedBox(width: 12),
                                    Text('Misión Pendiente', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange.shade900)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Para tener animales debe existir un lugar donde alojarlos. Primero dibuje sus corrales, cocheras o lagos en el mapa.',
                                  style: TextStyle(fontSize: 13, color: Colors.black87),
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton.icon(
                                  onPressed: () => context.push('/lotes/nuevo-lote?tipo=infraestructura'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange, 
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                  icon: const Icon(Icons.map_rounded),
                                  label: const Text('IR AL MAPA AHORA'),
                                ),
                              ],
                            ),
                          );
                        }

                        // Si tiene infraestructura, mostramos el censo total normal
                        return estadoEspecies.maybeWhen(
                          data: (especies) {
                            final total = especies.fold(0, (sum, item) => sum + item.cantidadActual);
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Censo Total',
                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '$total',
                                    style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                            );
                          },
                          orElse: () => const SizedBox.shrink(),
                        );
                      },
                      loading: () => const LinearProgressIndicator(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
            estadoEspecies.when(
              loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
              error: (error, _) => SliverFillRemaining(child: Center(child: Text('Error: $error'))),
              data: (especies) {
                if (especies.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.pets_outlined, size: 80, color: Colors.grey),
                          SizedBox(height: 16),
                          Text('Sin grupos animales registrados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
                        ],
                      ),
                    ),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => RepaintBoundary(
                        child: _TarjetaAnimal(especie: especies[index]),
                      ),
                      childCount: especies.length,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _mostrarFormularioNuevaEspecie(context, ref),
        backgroundColor: const Color(0xFF6A1B9A),
        foregroundColor: Colors.white,
        label: const Text('NUEVO GRUPO', style: TextStyle(fontWeight: FontWeight.w900)),
        icon: const Icon(Icons.add_circle_outline_rounded),
      ),
    );
  }

  void _mostrarFormularioNuevaEspecie(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(context: context, isScrollControlled: true, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))), builder: (context) => const _FormularioEspecieModal());
  }
}

class _TarjetaAnimal extends ConsumerWidget {
  final EspecieEntity especie;
  const _TarjetaAnimal({required this.especie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    IconData icono;
    Color color;

    final lotes = ref.watch(panelLotesNotifierProvider).valueOrNull ?? [];
    final loteAsociado = especie.loteId != null 
      ? lotes.firstWhere((l) => l.id == especie.loteId, orElse: () => Lote(id: '', nombre: 'Lote no encontrado', uso: TipoUsoLote.infraestructura, subCategoria: '', areaEnHectareas: 0, numeroMatas: 0, coordenadas: []))
      : null;

    switch (especie.tipoEspecie) {
      case 'Cerdo': icono = Icons.savings_rounded; color = Colors.pink; break;
      case 'Vaca / Toro': icono = Icons.agriculture_rounded; color = Colors.brown; break;
      case 'Gallina / Pollo': icono = Icons.egg_rounded; color = Colors.orange; break;
      case 'Caballo': icono = Icons.directions_run_rounded; color = Colors.amber.shade900; break;
      case 'Oveja': icono = Icons.cloud_rounded; color = Colors.grey; break;
      case 'Chivo / Cabra': icono = Icons.terrain_rounded; color = Colors.blueGrey; break;
      case 'Pez': icono = Icons.set_meal_rounded; color = Colors.blue; break;
      case 'Burro / Mula': icono = Icons.work_rounded; color = Colors.grey.shade700; break;
      default: icono = Icons.pets_rounded; color = Colors.brown;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: InkWell(
        onTap: () => context.push('/dashboard/animales/detalle/${especie.id}'),
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
                child: Icon(icono, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(especie.nombre, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
                    Text(
                      '${especie.cantidadActual} ${especie.tipoEspecie}', 
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 13)
                    ),
                    if (especie.valorTotalInversion > 0)
                      Text(
                        'Inversión: \$${especie.valorTotalInversion.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.purple),
                      ),
                    if (loteAsociado != null) ...[
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.location_on_rounded, size: 12, color: Colors.teal),
                          Text(' ${loteAsociado.nombre}', style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
                onPressed: () => _confirmarEliminacion(context, ref, especie),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmarEliminacion(BuildContext context, WidgetRef ref, EspecieEntity especie) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar grupo?', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text('¿Desea eliminar a ${especie.nombre}? Se perderá su historial.'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
          TextButton(
            onPressed: () async {
              await ref.read(pecuarioNotifierProvider.notifier).eliminarEspecie(especie.id);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('ELIMINAR', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _FormularioEspecieModal extends ConsumerStatefulWidget {
  const _FormularioEspecieModal();
  @override
  ConsumerState<_FormularioEspecieModal> createState() => _FormularioEspecieModalState();
}

class _FormularioEspecieModalState extends ConsumerState<_FormularioEspecieModal> {
  final _nombreCtrl = TextEditingController();
  final _cantCtrl = TextEditingController();
  final _valorUnitarioCtrl = TextEditingController();
  String _tipo = 'Cerdo';
  Lote? _loteSeleccionado;

  final List<String> _infraPecuariaSubCats = ['Cochera', 'Galpón', 'Estanque', 'Corral', 'Potrero'];

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets.bottom;
    final lotesAsync = ref.watch(panelLotesNotifierProvider);

    return Padding(
      padding: EdgeInsets.fromLTRB(28, 32, 28, 32 + padding), 
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        crossAxisAlignment: CrossAxisAlignment.stretch, 
        children: [
          const Text('Nuevo Grupo', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
          const SizedBox(height: 24),
          TextField(controller: _nombreCtrl, decoration: const InputDecoration(labelText: 'Nombre del Grupo', prefixIcon: Icon(Icons.edit_note_rounded), hintText: 'Ej: Cerdos de Engorde')),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _tipo,
            items: [
              'Cerdo', 
              'Vaca / Toro', 
              'Gallina / Pollo', 
              'Caballo', 
              'Oveja', 
              'Chivo / Cabra', 
              'Pez', 
              'Burro / Mula'
            ].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
            onChanged: (v) => setState(() => _tipo = v!),
            decoration: const InputDecoration(labelText: 'Especie', prefixIcon: Icon(Icons.category_rounded)),
          ),
          const SizedBox(height: 16),
          lotesAsync.when(
            data: (lotes) {
              // FILTRO ESTRICTO: Solo lotes de uso Pecuario o Infraestructura que sean para animales
              final lotesAptos = lotes.where((l) {
                if (l.uso == TipoUsoLote.pecuario) return true;
                if (l.uso == TipoUsoLote.infraestructura) {
                  return _infraPecuariaSubCats.contains(l.subCategoria);
                }
                return false;
              }).toList();

              if (lotesAptos.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.orange.withOpacity(0.5)),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 32),
                      const SizedBox(height: 8),
                      const Text(
                        '¡Atención, Patrón!',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                      ),
                      const Text(
                        'Primero debe mapear un corral, potrero o estanque en sus lotes antes de agregar animales.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          context.push('/lotes/nuevo-lote');
                        },
                        icon: const Icon(Icons.map_rounded),
                        label: const Text('IR A MAPEAR AHORA'),
                      ),
                    ],
                  ),
                );
              }

              return DropdownButtonFormField<Lote>(
                value: _loteSeleccionado,
                decoration: const InputDecoration(labelText: '¿En qué corral o estanque están?', prefixIcon: Icon(Icons.landscape_rounded)),
                items: lotesAptos.map((l) => DropdownMenuItem(value: l, child: Text('${l.nombre} (${l.subCategoria})'))).toList(),
                onChanged: (v) => setState(() => _loteSeleccionado = v),
              );
            },
            loading: () => const Center(child: LinearProgressIndicator()),
            error: (_, __) => const Text('Error al cargar infraestructuras'),
          ),
          const SizedBox(height: 16),
          TextField(controller: _cantCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Cantidad inicial', prefixIcon: Icon(Icons.numbers_rounded))),
          const SizedBox(height: 16),
          TextField(
            controller: _valorUnitarioCtrl, 
            keyboardType: TextInputType.number, 
            decoration: const InputDecoration(
              labelText: 'Valor unitario / Costo compra', 
              prefixIcon: Icon(Icons.payments_rounded),
              suffixText: 'COP',
            ),
          ),
          const SizedBox(height: 32),
          lotesAsync.maybeWhen(
            data: (lotes) {
              final tieneLotes = lotes.any((l) => l.uso == TipoUsoLote.infraestructura || l.uso == TipoUsoLote.pecuario);
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: tieneLotes ? const Color(0xFF6A1B9A) : Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: tieneLotes && _loteSeleccionado != null
                  ? () async { 
                    if (_nombreCtrl.text.isNotEmpty && _cantCtrl.text.isNotEmpty) {
                      await ref.read(pecuarioNotifierProvider.notifier).agregarEspecie(
                        nombre: _nombreCtrl.text.trim(), 
                        tipoEspecie: _tipo, 
                        cantidadActual: int.tryParse(_cantCtrl.text) ?? 0,
                        loteId: _loteSeleccionado?.id,
                        valorUnitario: double.tryParse(_valorUnitarioCtrl.text) ?? 0.0,
                      ); 
                      if (mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Nuevo grupo animal registrado con éxito'),
                            backgroundColor: Color(0xFF6A1B9A),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }
                  }
                  : null, // Bloqueado si no hay lote seleccionado
                child: const Text('GUARDAR GRUPO ANIMAL', style: TextStyle(fontWeight: FontWeight.bold))
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ]
      )
    );
  }
}
