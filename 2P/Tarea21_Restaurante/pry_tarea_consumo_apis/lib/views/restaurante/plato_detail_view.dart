import 'package:flutter/material.dart';

import '../../models/plato.dart';
import 'pedido_form_view.dart';

class PlatoDetailView extends StatelessWidget {
  final Plato plato;

  const PlatoDetailView({super.key, required this.plato});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del plato'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plato.nombre,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  plato.descripcion ?? 'Sin descripción',
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 16),

                Text(
                  'Precio: \$${plato.precio.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  plato.disponible
                      ? 'Estado: Disponible'
                      : 'Estado: No disponible',
                  style: TextStyle(
                    fontSize: 16,
                    color: plato.disponible ? Colors.green : Colors.red,
                  ),
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: plato.disponible
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PedidoFormView(plato: plato),
                              ),
                            );
                          }
                        : null,
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Realizar pedido'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
