import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'providers/insumos_notifier.dart';
import '../domain/insumo_model.dart';

class PantallaBodega extends ConsumerWidget {
  const PantallaBodega({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insumosAsync = ref.watch(insumosNotifierProvider);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FBF9),
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text('Bodega Virtual', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 4,
            isScrollable: true,
            unselectedLabelColor: Colors.white60,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            tabs: [
              Tab(icon: Icon(Icons.inventory_2_rounded), text: 'OPERACIÓN'),
              Tab(icon: Icon(Icons.medical_services_rounded), text: 'VETERINARIA'),
              Tab(icon: Icon(Icons.settings_suggest_rounded), text: 'MAQUINARIA'),
              Tab(icon: Icon(Icons.oil_barrel_rounded), text: 'CONSUMIBLES'),
              Tab(icon: Icon(Icons.local_shipping_rounded), text: 'PRODUCCIÓN'),
            ],
          ),
        ),
        body: insumosAsync.when(
          data: (insumos) {
            final operativos = insumos.where((i) => i.categoria == CategoriaInsumo.operativo).toList();
            final veterinaria = insumos.where((i) => i.categoria == CategoriaInsumo.veterinaria).toList();
            final maquinaria = insumos.where((i) => i.categoria == CategoriaInsumo.maquinaria).toList();
            final consumibles = insumos.where((i) => i.categoria == CategoriaInsumo.consumibles).toList();
            final cosechas = insumos.where((i) => i.categoria == CategoriaInsumo.cosecha).toList();

            return TabBarView(
              children: [
                _ListaInsumosCategoria(
                  insumos: operativos, 
                  esCosecha: false,
                  categoria: CategoriaInsumo.operativo,
                ),
                _ListaInsumosCategoria(
                  insumos: veterinaria, 
                  esCosecha: false,
                  categoria: CategoriaInsumo.veterinaria,
                ),
                _ListaInsumosCategoria(
                  insumos: maquinaria, 
                  esCosecha: false,
                  categoria: CategoriaInsumo.maquinaria,
                ),
                _ListaInsumosCategoria(
                  insumos: consumibles, 
                  esCosecha: false,
                  categoria: CategoriaInsumo.consumibles,
                ),
                _ListaInsumosCategoria(
                  insumos: cosechas, 
                  esCosecha: true,
                  categoria: CategoriaInsumo.cosecha,
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton.extended(
                heroTag: 'proceso',
                onPressed: () => context.push('/proceso-cafe'),
                label: const Text('PROCESAR COSECHA', style: TextStyle(fontWeight: FontWeight.w900)),
                icon: const Icon(Icons.settings_input_component_rounded),
                backgroundColor: const Color(0xFFF57C00),
                foregroundColor: Colors.white,
              ),
              const SizedBox(height: 12),
              FloatingActionButton.extended(
                heroTag: 'nuevo',
                onPressed: () => _mostrarFormInsumo(context, ref),
                label: const Text('NUEVO REGISTRO', style: TextStyle(fontWeight: FontWeight.w900)),
                icon: const Icon(Icons.add_box_rounded),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarFormInsumo(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true, 
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))), 
      builder: (context) => const _FormInsumoModal()
    );
  }
}

class _ListaInsumosCategoria extends StatelessWidget {
  final List<InsumoEntity> insumos;
  final bool esCosecha;
  final CategoriaInsumo categoria;

  const _ListaInsumosCategoria({required this.insumos, required this.esCosecha, required this.categoria});

  @override
  Widget build(BuildContext context) {
    if (insumos.isEmpty) {
      IconData icono;
      String texto;
      switch(categoria) {
        case CategoriaInsumo.operativo: icono = Icons.inventory_2_outlined; texto = 'Sin insumos de operación'; break;
        case CategoriaInsumo.maquinaria: icono = Icons.settings_suggest_outlined; texto = 'Sin maquinaria o repuestos'; break;
        case CategoriaInsumo.cosecha: icono = Icons.eco_outlined; texto = 'Sin productos cosechados'; break;
        case CategoriaInsumo.veterinaria: icono = Icons.medical_services_outlined; texto = 'Sin medicamentos registrados'; break;
        case CategoriaInsumo.consumibles: icono = Icons.oil_barrel_outlined; texto = 'Sin consumibles registrados'; break;
      }
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icono, size: 80, color: Colors.grey.withOpacity(0.3)),
            const SizedBox(height: 16),
            Text(texto, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade400)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
      itemCount: insumos.length + (esCosecha ? 1 : 0),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        if (esCosecha && index == insumos.length) {
          return const _BotonBetaServiCarga();
        }
        return RepaintBoundary(
          child: _TarjetaInsumo(insumo: insumos[index]),
        );
      },
    );
  }
}

class _TarjetaInsumo extends ConsumerWidget {
  final InsumoEntity insumo;
  const _TarjetaInsumo({required this.insumo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final esCosecha = insumo.categoria == CategoriaInsumo.cosecha;
    final esMaquinaria = insumo.categoria == CategoriaInsumo.maquinaria;
    final esVeterinaria = insumo.categoria == CategoriaInsumo.veterinaria;
    final esConsumible = insumo.categoria == CategoriaInsumo.consumibles;
    
    Color colorPrincipal;
    IconData icono;
    
    if (esCosecha) {
      colorPrincipal = const Color(0xFFF57C00);
      icono = Icons.eco_rounded;
    } else if (esMaquinaria) {
      colorPrincipal = Colors.blueGrey;
      icono = Icons.settings_suggest_rounded;
    } else if (esVeterinaria) {
      colorPrincipal = Colors.red.shade700;
      icono = Icons.medical_services_rounded;
    } else if (esConsumible) {
      colorPrincipal = Colors.blue.shade700;
      icono = Icons.oil_barrel_rounded;
    } else {
      colorPrincipal = Colors.brown;
      icono = Icons.inventory_2_rounded;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: insumo.esEscaso && !esCosecha ? Colors.red.withOpacity(0.1) : colorPrincipal.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            insumo.esEscaso && !esCosecha ? Icons.warning_amber_rounded : icono, 
            color: insumo.esEscaso && !esCosecha ? Colors.red : colorPrincipal, 
            size: 24
          ),
        ),
        title: Row(
          children: [
            Expanded(child: Text(insumo.nombre, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF37474F)))),
            if (insumo.esParaSecado)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(8)),
                child: const Text('EN SECADO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.orange)),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${insumo.cantidadActual} ${insumo.unidadMedida}', 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: insumo.esEscaso && !esCosecha ? Colors.red : Colors.teal.shade800),
            ),
            if (insumo.valorTotal > 0)
              Text(
                'Valor total: \$${insumo.valorTotal.toStringAsFixed(0)} COP',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey),
              ),
          ],
        ),
        trailing: IconButton.filledTonal(
          onPressed: () => _mostrarAjusteStock(context, ref), 
          icon: const Icon(Icons.edit_note_rounded),
        ),
      ),
    );
  }

  void _mostrarAjusteStock(BuildContext context, WidgetRef ref) {
    final ctrl = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Ajustar ${insumo.nombre}', style: const TextStyle(fontWeight: FontWeight.bold)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      content: TextField(
        controller: ctrl, 
        keyboardType: TextInputType.number, 
        autofocus: true,
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
        decoration: InputDecoration(
          labelText: 'Cantidad a sumar/restar',
          suffixText: insumo.unidadMedida,
          border: const OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: const Size(100, 50)),
          onPressed: () { 
            final val = double.tryParse(ctrl.text);
            if (val != null) {
              ref.read(insumosNotifierProvider.notifier).ajustarStock(insumo.id, val);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Inventario de ${insumo.nombre} actualizado'),
                  backgroundColor: const Color(0xFF3E2723),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          }, 
          child: const Text('AJUSTAR'),
        ),
      ],
    ));
  }
}

class _BotonBetaServiCarga extends StatelessWidget {
  const _BotonBetaServiCarga();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 40),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50, 
        borderRadius: BorderRadius.circular(32), 
        border: Border.all(color: Colors.blueGrey.shade100, width: 2),
      ),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: const Icon(Icons.local_shipping_rounded, size: 40, color: Colors.blueGrey),
        ),
        const SizedBox(height: 16),
        const Text('¿Vas a vender tu cosecha?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
        const SizedBox(height: 8),
        const Text('Solicita transporte a ServiCarga directamente.', textAlign: TextAlign.center, style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w500)),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: null, 
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
          child: const Text('PRÓXIMAMENTE'),
        ),
      ]),
    );
  }
}

class _FormInsumoModal extends ConsumerStatefulWidget {
  const _FormInsumoModal();
  @override
  ConsumerState<_FormInsumoModal> createState() => _FormInsumoModalState();
}

class _FormInsumoModalState extends ConsumerState<_FormInsumoModal> {
  final _nombreCtrl = TextEditingController();
  final _stockCtrl = TextEditingController();
  final _valorUnitarioCtrl = TextEditingController();
  CategoriaInsumo _categoria = CategoriaInsumo.operativo;
  bool _esParaSecado = false;
  bool _mostrarOpcionSecado = false;

  @override
  void initState() {
    super.initState();
    _nombreCtrl.addListener(() {
      final text = _nombreCtrl.text.toLowerCase();
      setState(() {
        _mostrarOpcionSecado = text.contains('cafe') || text.contains('café');
        if (!_mostrarOpcionSecado) _esParaSecado = false;
      });
    });
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _stockCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(28, 32, 28, 32 + padding), 
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Nuevo Registro', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SegmentedButton<CategoriaInsumo>(
              segments: const [
                ButtonSegment(value: CategoriaInsumo.operativo, label: Text('Operación'), icon: Icon(Icons.inventory_2_rounded)),
                ButtonSegment(value: CategoriaInsumo.veterinaria, label: Text('Salud'), icon: Icon(Icons.medical_services_rounded)),
                ButtonSegment(value: CategoriaInsumo.maquinaria, label: Text('Maq.'), icon: Icon(Icons.settings_suggest_rounded)),
                ButtonSegment(value: CategoriaInsumo.consumibles, label: Text('Cons.'), icon: Icon(Icons.oil_barrel_rounded)),
                ButtonSegment(value: CategoriaInsumo.cosecha, label: Text('Cosecha'), icon: Icon(Icons.eco_rounded)),
              ],
              selected: {_categoria},
              onSelectionChanged: (set) => setState(() {
                _categoria = set.first;
                // Si cambiamos a cosecha y dice cafe, habilitar logica
                final text = _nombreCtrl.text.toLowerCase();
                _mostrarOpcionSecado = _categoria == CategoriaInsumo.cosecha && (text.contains('cafe') || text.contains('café'));
              }),
            ),
          ),
          const SizedBox(height: 24),
          TextField(controller: _nombreCtrl, decoration: const InputDecoration(labelText: 'Nombre (Ej: Urea, Gasolina, Café)', prefixIcon: Icon(Icons.edit_note_rounded))),
          
          if (_mostrarOpcionSecado) ...[
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(16)),
              child: SwitchListTile(
                title: const Text('¿Café para secado?', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                subtitle: const Text('Marcar si el lote entra a proceso de secado'),
                value: _esParaSecado,
                activeColor: Colors.orange,
                onChanged: (v) => setState(() => _esParaSecado = v),
              ),
            ),
          ],

          const SizedBox(height: 16),
          TextField(
            controller: _stockCtrl, 
            keyboardType: TextInputType.number, 
            decoration: InputDecoration(
              labelText: 'Cantidad Inicial', 
              prefixIcon: const Icon(Icons.scale_rounded),
              suffixText: _categoria == CategoriaInsumo.operativo 
                ? 'Bultos' 
                : (_categoria == CategoriaInsumo.cosecha 
                    ? 'Kilos' 
                    : (_categoria == CategoriaInsumo.veterinaria ? 'Unds/Ml' : 'Gals/Unds')),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _valorUnitarioCtrl, 
            keyboardType: TextInputType.number, 
            decoration: const InputDecoration(
              labelText: 'Valor por Unidad', 
              prefixIcon: Icon(Icons.payments_rounded),
              suffixText: 'COP',
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(onPressed: () async { 
            if (_nombreCtrl.text.isNotEmpty && _stockCtrl.text.isNotEmpty) {
              String unidad = 'Bultos';
              if (_categoria == CategoriaInsumo.maquinaria || _categoria == CategoriaInsumo.consumibles) unidad = 'Gals/Unds';
              if (_categoria == CategoriaInsumo.cosecha) unidad = 'Kilos';
              if (_categoria == CategoriaInsumo.veterinaria) unidad = 'Unds/Ml';

              await ref.read(insumosNotifierProvider.notifier).registrarInsumo(
                nombre: _nombreCtrl.text, 
                unidad: unidad, 
                stockInicial: double.parse(_stockCtrl.text),
                categoria: _categoria,
                esParaSecado: _esParaSecado,
                valorUnitario: double.tryParse(_valorUnitarioCtrl.text) ?? 0.0,
              ); 
              if (mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Guardado en bodega con éxito'),
                    backgroundColor: Color(0xFF3E2723),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            }
          }, child: const Text('GUARDAR EN BODEGA'))
        ]
      )
    );
  }
}
