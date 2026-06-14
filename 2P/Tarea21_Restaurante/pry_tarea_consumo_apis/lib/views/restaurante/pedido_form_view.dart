import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/pedido.dart';
import '../../models/plato.dart';
import '../../viewmodels/pedido_viewmodel.dart';

class PedidoFormView extends StatefulWidget {
  final Plato plato;

  const PedidoFormView({super.key, required this.plato});

  @override
  State<PedidoFormView> createState() => _PedidoFormViewState();
}

class _PedidoFormViewState extends State<PedidoFormView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _clienteController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();

  double _total = 0;

  @override
  void initState() {
    super.initState();

    _cantidadController.addListener(_calcularTotal);
  }

  @override
  void dispose() {
    _clienteController.dispose();
    _cantidadController.dispose();
    super.dispose();
  }

  void _calcularTotal() {
    final cantidad = int.tryParse(_cantidadController.text.trim()) ?? 0;

    setState(() {
      _total = cantidad * widget.plato.precio;
    });
  }

  Future<void> _registrarPedido() async {
    if (!_formKey.currentState!.validate()) return;

    final pedidoViewModel = context.read<PedidoViewModel>();

    final pedido = Pedido(
      cliente: _clienteController.text.trim(),
      cantidad: int.parse(_cantidadController.text.trim()),
      platoId: widget.plato.id!,
    );

    final ok = await pedidoViewModel.crearPedido(pedido);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? 'Pedido registrado correctamente'
              : pedidoViewModel.errorMessage ??
                    'No se pudo registrar el pedido',
        ),
      ),
    );

    if (ok) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pedidoViewModel = context.watch<PedidoViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar pedido'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.plato.nombre,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(widget.plato.descripcion ?? 'Sin descripción'),

                      const SizedBox(height: 8),

                      Text(
                        'Precio unitario: \$${widget.plato.precio.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              TextFormField(
                controller: _clienteController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del cliente',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese el nombre del cliente';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: _cantidadController,
                decoration: const InputDecoration(
                  labelText: 'Cantidad',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese la cantidad';
                  }

                  final cantidad = int.tryParse(value.trim());

                  if (cantidad == null) {
                    return 'Ingrese un número válido';
                  }

                  if (cantidad <= 0) {
                    return 'La cantidad debe ser mayor a 0';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Total: \$${_total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: pedidoViewModel.isLoading
                      ? null
                      : _registrarPedido,
                  icon: const Icon(Icons.check_circle),
                  label: Text(
                    pedidoViewModel.isLoading
                        ? 'Registrando...'
                        : 'Confirmar pedido',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
