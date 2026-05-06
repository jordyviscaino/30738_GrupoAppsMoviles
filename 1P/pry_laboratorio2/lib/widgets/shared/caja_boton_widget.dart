import 'package:flutter/material.dart';

class BotonCajaGrande extends StatelessWidget {
  final String texto;
  final VoidCallback alPresionar;
  final Color color;

  const BotonCajaGrande({
    super.key,
    required this.texto,
    required this.alPresionar,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Ocupa todo el ancho disponible
      height: 60,
      child: ElevatedButton.icon(
        onPressed: alPresionar,
        icon: const Icon(Icons.calculate_rounded, size: 28),
        label: Text(
          texto,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
        ),
      ),
    );
  }
}