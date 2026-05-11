import 'package:flutter/material.dart';

class ABoton extends StatelessWidget {
  final String texto;
  final VoidCallback presionar;
  final IconData? icono;

  const ABoton({
    super.key,
    required this.texto,
    required this.presionar,
    this.icono,
  });

  @override
  Widget build(BuildContext context) {
    if (icono != null) {
      return ElevatedButton.icon(
        onPressed: presionar,
        icon: Icon(icono),
        label: Text(texto),
      );
    }
    
    return ElevatedButton(
      onPressed: presionar,
      child: Text(texto),
    );
  }
}