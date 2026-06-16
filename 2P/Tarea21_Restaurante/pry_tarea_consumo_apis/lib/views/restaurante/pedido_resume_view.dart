import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/pedido_viewmodel.dart';

class PedidoResumenView extends StatefulWidget {
  const PedidoResumenView({super.key});

  @override
  State<PedidoResumenView> createState() => _PedidoResumenViewState();
}

class _PedidoResumenViewState extends State<PedidoResumenView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<PedidoViewModel>().cargarPedidos();
    });
  }

  Future<void> _confirmarEliminar(int id) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar pedido'),
          content: const Text('¿Seguro que deseas eliminar este pedido?'),
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
      final viewModel = context.read<PedidoViewModel>();
      final ok = await viewModel.eliminarPedido(id);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ok
                ? 'Pedido eliminado correctamente'
                : viewModel.errorMessage ?? 'No se pudo eliminar el pedido',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pedidoViewModel = context.watch<PedidoViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de pedidos'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              pedidoViewModel.cargarPedidos();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (pedidoViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (pedidoViewModel.errorMessage != null) {
            return Center(child: Text(pedidoViewModel.errorMessage!));
          }

          if (pedidoViewModel.pedidos.isEmpty) {
            return const Center(child: Text('No hay pedidos registrados'));
          }

          return ListView.builder(
            itemCount: pedidoViewModel.pedidos.length,
            itemBuilder: (context, index) {
              final pedido = pedidoViewModel.pedidos[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ListTile(
                  leading: const Icon(
                    Icons.receipt_long,
                    color: Colors.deepOrange,
                  ),
                  title: Text(
                    pedido.cliente,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Plato: ${pedido.platoNombre ?? pedido.platoId}\n'
                    'Cantidad: ${pedido.cantidad}\n'
                    'Total: \$${pedido.total?.toStringAsFixed(2) ?? '0.00'}',
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: pedido.id == null
                        ? null
                        : () => _confirmarEliminar(pedido.id!),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
