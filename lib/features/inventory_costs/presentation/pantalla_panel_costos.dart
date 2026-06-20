import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/costos_notifier.dart';
import 'package:agrogo/features/maps_and_lots/presentation/providers/panel_lotes_notifier.dart';
import 'package:agrogo/features/maps_and_lots/domain/lote_model.dart';
import 'package:agrogo/features/inventory_costs/domain/calculadora_insumos_usecase.dart';

/// Pantalla que muestra el panel de insumos y costos acumulados de la finca.
class PantallaPanelCostos extends ConsumerWidget {
  const PantallaPanelCostos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadoCostos = ref.watch(costosNotifierProvider);
    final totalAcumulado = ref.read(costosNotifierProvider.notifier).obtenerTotalAcumulado();
    final estadoLotes = ref.watch(panelLotesNotifierProvider);

    // Mapear los lotes para búsqueda rápida O(1)
    final mapaLotes = estadoLotes.maybeWhen(
      data: (lotes) => {for (var l in lotes) l.id: l},
      orElse: () => <String, Lote>{},
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insumos y Gastos'),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 28.0),
            tooltip: 'Actualizar costos',
            onPressed: () => ref.read(costosNotifierProvider.notifier).refresh(),
          ),
        ],
      ),
      body: estadoCostos.when(
        loading: () => const Center(
          child: CircularProgressIndicator(strokeWidth: 4.0),
        ),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 80.0),
                const SizedBox(height: 16.0),
                Text(
                  'Error al cargar el inventario de gastos:\n${error.toString()}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () => ref.read(costosNotifierProvider.notifier).refresh(),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
        data: (costos) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header con Gradiente y Total Acumulado
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32.0),
                    bottomRight: Radius.circular(32.0),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'GASTO TOTAL ACUMULADO',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white70,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '\$${totalAcumulado.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Pesos Colombianos (COP)',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // Botón de Calculadora Predictiva Estilizado
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: InkWell(
                  onTap: () => _mostrarCalculadoraInsumos(context, ref),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue.shade100, width: 2),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.calculate, color: Colors.white, size: 28),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CALCULADORA DE INSUMOS',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                'Proyectar abono y fumigación',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blue),
                      ],
                    ),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 8),
                child: Text(
                  'HISTORIAL DE COMPRAS',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Colors.grey,
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              // Lista de gastos
              Expanded(
                child: costos.isEmpty
                    ? const _VistaVaciaCostos()
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 80.0),
                        itemCount: costos.length,
                        itemBuilder: (context, indice) {
                          final gasto = costos[indice];
                          return _TarjetaGasto(
                            gasto: gasto,
                            lote: gasto.loteId != null ? mapaLotes[gasto.loteId] : null,
                            onDelete: () => _confirmarEliminacion(context, ref, gasto),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _mostrarFormularioAgregar(context, ref),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        label: const Text(
          'Registrar Gasto',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.add_shopping_cart, size: 26),
      ),
    );
  }

  void _confirmarEliminacion(BuildContext context, WidgetRef ref, dynamic gasto) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('¿Eliminar registro?'),
        content: Text('¿Deseas eliminar la compra de "${gasto.nombreItem}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCELAR'),
          ),
          TextButton(
            onPressed: () {
              ref.read(costosNotifierProvider.notifier).eliminarCosto(gasto.id);
              Navigator.pop(context);
            },
            child: const Text('ELIMINAR', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _mostrarCalculadoraInsumos(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
      ),
      builder: (context) => const _ModalCalculadoraInsumos(),
    );
  }

  void _mostrarFormularioAgregar(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
      ),
      builder: (context) => const _FormularioCostoModal(),
    );
  }
}

class _TarjetaGasto extends StatelessWidget {
  final dynamic gasto;
  final Lote? lote;
  final VoidCallback onDelete;

  const _TarjetaGasto({
    required this.gasto,
    this.lote,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    IconData icono;
    Color color;

    switch (gasto.categoria) {
      case 'Abono':
        icono = Icons.science;
        color = Colors.green;
        break;
      case 'Herramienta':
        icono = Icons.construction;
        color = Colors.orange;
        break;
      case 'Fungicida':
        icono = Icons.bug_report;
        color = Colors.red;
        break;
      default:
        icono = Icons.inventory_2;
        color = Colors.blue;
    }

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icono, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gasto.nombreItem,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        gasto.categoria,
                        style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      if (lote != null) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.fiber_manual_record, size: 6, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          lote!.nombre,
                          style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    '${gasto.fechaCompra.day}/${gasto.fechaCompra.month}/${gasto.fechaCompra.year}',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${gasto.precioTotal.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF1B5E20)),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 22),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _VistaVaciaCostos extends StatelessWidget {
  const _VistaVaciaCostos();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle),
              child: Icon(Icons.receipt_long_outlined, size: 80.0, color: Colors.blue.shade800),
            ),
            const SizedBox(height: 32.0),
            const Text(
              'Sin gastos registrados',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12.0),
            const Text(
              'Registra tus facturas de abonos y herramientas para controlar la rentabilidad de tu finca.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModalCalculadoraInsumos extends ConsumerStatefulWidget {
  const _ModalCalculadoraInsumos();

  @override
  ConsumerState<_ModalCalculadoraInsumos> createState() => _ModalCalculadoraInsumosState();
}

class _ModalCalculadoraInsumosState extends ConsumerState<_ModalCalculadoraInsumos> {
  final _calculadora = CalculadoraInsumosUseCase();
  Lote? _loteSeleccionado;
  
  final _gramosPorMataControlador = TextEditingController(text: '50.0');
  final _kilosPorBultoControlador = TextEditingController(text: '50.0');
  final _rendimientoControlador = TextEditingController(text: '200');
  final _capacidadBombaControlador = TextEditingController(text: '20.0');

  @override
  void dispose() {
    _gramosPorMataControlador.dispose();
    _kilosPorBultoControlador.dispose();
    _rendimientoControlador.dispose();
    _capacidadBombaControlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final estadoLotes = ref.watch(panelLotesNotifierProvider);
    final tecladoPadding = MediaQuery.of(context).viewInsets.bottom;

    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 24.0 + tecladoPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Proyectar Compra', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
            const Divider(),
            const SizedBox(height: 12.0),

            estadoLotes.when(
              data: (lotes) {
                if (lotes.isEmpty) return const Center(child: Text('Primero mapea un lote.', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)));
                
                if (_loteSeleccionado == null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => _loteSeleccionado = lotes.first));
                }

                return DropdownButtonFormField<Lote>(
                  value: _loteSeleccionado ?? lotes.first,
                  decoration: InputDecoration(
                    labelText: 'Seleccionar Lote',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    prefixIcon: const Icon(Icons.landscape),
                  ),
                  items: lotes.map((l) => DropdownMenuItem(value: l, child: Text('${l.nombre} (${l.numeroMatas} matas)'))).toList(),
                  onChanged: (v) => setState(() => _loteSeleccionado = v),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const Text('Error al cargar lotes.'),
            ),
            const SizedBox(height: 16.0),

            if (_loteSeleccionado != null) ...[
              TabBar(
                labelColor: Colors.blue.shade800,
                indicatorColor: Colors.blue.shade800,
                indicatorWeight: 4,
                tabs: const [
                  Tab(icon: Icon(Icons.science), text: 'ABONO'),
                  Tab(icon: Icon(Icons.bug_report), text: 'FUMIGACIÓN'),
                ],
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                height: 300.0,
                child: TabBarView(
                  children: [
                    _buildAbonoTab(),
                    _buildFumigacionTab(),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAbonoTab() {
    final matas = _loteSeleccionado?.numeroMatas ?? 0;
    final gramos = double.tryParse(_gramosPorMataControlador.text) ?? 0.0;
    final kilos = double.tryParse(_kilosPorBultoControlador.text) ?? 0.0;
    final bultos = _calculadora.calcularBultosAbono(numeroMatas: matas, gramosPorMata: gramos, kilosPorBulto: kilos);

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: TextFormField(controller: _gramosPorMataControlador, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Gramos/Mata', suffixText: 'g', border: OutlineInputBorder()), onChanged: (_) => setState(() {}))),
            const SizedBox(width: 12),
            Expanded(child: TextFormField(controller: _kilosPorBultoControlador, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Kilos/Bulto', suffixText: 'kg', border: OutlineInputBorder()), onChanged: (_) => setState(() {}))),
          ],
        ),
        const SizedBox(height: 24),
        _ResultadoProyeccion(valor: '$bultos Bultos', subtitulo: 'Necesarios para $matas matas'),
      ],
    );
  }

  Widget _buildFumigacionTab() {
    final matas = _loteSeleccionado?.numeroMatas ?? 0;
    final rendimiento = int.tryParse(_rendimientoControlador.text) ?? 0;
    final capacidad = double.tryParse(_capacidadBombaControlador.text) ?? 0.0;
    final res = _calculadora.calcularFumigacion(numeroMatas: matas, rendimientoMatasPorBomba: rendimiento, capacidadBombaLitros: capacidad);

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: TextFormField(controller: _rendimientoControlador, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Matas/Bomba', border: OutlineInputBorder()), onChanged: (_) => setState(() {}))),
            const SizedBox(width: 12),
            Expanded(child: TextFormField(controller: _capacidadBombaControlador, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Capacidad Bomba', suffixText: 'L', border: OutlineInputBorder()), onChanged: (_) => setState(() {}))),
          ],
        ),
        const SizedBox(height: 24),
        _ResultadoProyeccion(valor: '${res.bombas} Bombas', subtitulo: 'Total mezcla: ${res.litrosMezcla.toStringAsFixed(1)} Litros'),
      ],
    );
  }
}

class _ResultadoProyeccion extends StatelessWidget {
  final String valor;
  final String subtitulo;
  const _ResultadoProyeccion({required this.valor, required this.subtitulo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.blue.shade200)),
      child: Column(
        children: [
          Text(valor, style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.blue.shade900)),
          const SizedBox(height: 4),
          Text(subtitulo, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue.shade700)),
        ],
      ),
    );
  }
}

class _FormularioCostoModal extends ConsumerStatefulWidget {
  const _FormularioCostoModal();

  @override
  ConsumerState<_FormularioCostoModal> createState() => _FormularioCostoModalState();
}

class _FormularioCostoModalState extends ConsumerState<_FormularioCostoModal> {
  final _formularioKey = GlobalKey<FormState>();
  final _nombreControlador = TextEditingController();
  final _precioControlador = TextEditingController();
  String _categoriaSeleccionada = 'Abono';
  String? _loteIdSeleccionado;

  @override
  Widget build(BuildContext context) {
    final tecladoPadding = MediaQuery.of(context).viewInsets.bottom;
    final estadoLotes = ref.watch(panelLotesNotifierProvider);

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 24, 20, 24 + tecladoPadding),
      child: Form(
        key: _formularioKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Nueva Compra', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Divider(),
            const SizedBox(height: 16),
            TextFormField(controller: _nombreControlador, decoration: const InputDecoration(labelText: '¿Qué se compró?', border: OutlineInputBorder(), prefixIcon: Icon(Icons.shopping_bag)), validator: (v) => v!.isEmpty ? 'Ingresa el nombre' : null),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _categoriaSeleccionada,
              decoration: const InputDecoration(labelText: 'Categoría', border: OutlineInputBorder(), prefixIcon: Icon(Icons.category)),
              items: ['Abono', 'Herramienta', 'Fungicida', 'Otro'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (v) => setState(() => _categoriaSeleccionada = v!),
            ),
            const SizedBox(height: 16),
            estadoLotes.maybeWhen(
              data: (lotes) => DropdownButtonFormField<String?>(
                value: _loteIdSeleccionado,
                decoration: const InputDecoration(labelText: 'Asociar a Lote (Opcional)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.landscape)),
                items: [const DropdownMenuItem(value: null, child: Text('Gasto General')), ...lotes.map((l) => DropdownMenuItem(value: l.id, child: Text(l.nombre)))],
                onChanged: (v) => setState(() => _loteIdSeleccionado = v),
              ),
              orElse: () => const SizedBox.shrink(),
            ),
            const SizedBox(height: 16),
            TextFormField(controller: _precioControlador, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Precio Total', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()), validator: (v) => v!.isEmpty ? 'Ingresa el precio' : null),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formularioKey.currentState!.validate()) {
                  ref.read(costosNotifierProvider.notifier).agregarCosto(nombreItem: _nombreControlador.text, categoria: _categoriaSeleccionada, precioTotal: double.parse(_precioControlador.text), loteId: _loteIdSeleccionado);
                  Navigator.pop(context);
                }
              },
              child: const Text('GUARDAR COMPRA'),
            ),
          ],
        ),
      ),
    );
  }
}
