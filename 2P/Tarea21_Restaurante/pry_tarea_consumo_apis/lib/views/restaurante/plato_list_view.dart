import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/plato_viewmodel.dart';
import '../../viewmodels/pedido_viewmodel.dart';
import '../../widgets/plato_card.dart';
import 'plato_detail_view.dart';
import 'plato_form_view.dart';
import 'pedido_form_view.dart';
import 'pedido_resume_view.dart';

class PlatoListView extends StatefulWidget {
  const PlatoListView({super.key});

  @override
  State<PlatoListView> createState() => _PlatoListViewState();
}

class _PlatoListViewState extends State<PlatoListView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<PlatoViewModel>().cargarPlatos();
      context.read<PedidoViewModel>().cargarPedidos();
    });
  }

  Future<void> _confirmarEliminar(int id) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar plato'),
          content: const Text('¿Seguro que deseas eliminar este plato?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirmar == true && mounted) {
      final viewModel = context.read<PlatoViewModel>();
      final ok = await viewModel.eliminarPlato(id);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ok
                ? 'Plato eliminado correctamente'
                : viewModel.errorMessage ?? 'No se pudo eliminar el plato',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final platoViewModel = context.watch<PlatoViewModel>();
    final pedidoViewModel = context.watch<PedidoViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurante'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Ver pedidos',
            icon: const Icon(Icons.receipt_long),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PedidoResumenView()),
              );
            },
          ),
          IconButton(
            tooltip: 'Actualizar',
            icon: const Icon(Icons.refresh),
            onPressed: () {
              platoViewModel.cargarPlatos();
              pedidoViewModel.cargarPedidos();
            },
          ),
        ],
      ),

      body: Builder(
        builder: (context) {
          if (platoViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (platoViewModel.errorMessage != null) {
            return Center(child: Text(platoViewModel.errorMessage!));
          }

          if (platoViewModel.platos.isEmpty) {
            return const Center(child: Text('No hay platos registrados'));
          }

          return ListView.builder(
            itemCount: platoViewModel.platos.length,
            itemBuilder: (context, index) {
              final plato = platoViewModel.platos[index];

              return PlatoCard(
                plato: plato,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PlatoDetailView(plato: plato),
                    ),
                  );
                },
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PlatoFormView(plato: plato),
                    ),
                  );
                },
                onDelete: () {
                  if (plato.id != null) {
                    _confirmarEliminar(plato.id!);
                  }
                },
                onPedido: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PedidoFormView(plato: plato),
                    ),
                  );
                },
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PlatoFormView()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
