import 'package:flutter/material.dart';

import '../models/plato.dart';

class PlatoCard extends StatelessWidget {
  final Plato plato;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onPedido;

  const PlatoCard({
    super.key,
    required this.plato,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onPedido,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plato.nombre,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                plato.descripcion ?? 'Sin descripción',
                style: const TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${plato.precio.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  Chip(
                    label: Text(
                      plato.disponible ? 'Disponible' : 'No disponible',
                    ),
                    backgroundColor: plato.disponible
                        ? Colors.green[100]
                        : Colors.red[100],
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit),
                    tooltip: 'Editar',
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete),
                    tooltip: 'Eliminar',
                  ),
                  ElevatedButton.icon(
                    onPressed: plato.disponible ? onPedido : null,
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Pedir'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
