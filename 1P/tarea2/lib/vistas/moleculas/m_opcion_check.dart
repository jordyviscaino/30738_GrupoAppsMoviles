import 'package:flutter/material.dart';
import '../atomos/a_checkbox.dart';
import '../atomos/a_label.dart';

class MOpcionCheck extends StatelessWidget {
  final String titulo;
  final bool valor;
  final ValueChanged<bool?> alCambiar;

  const MOpcionCheck({
    super.key,
    required this.titulo,
    required this.valor,
    required this.alCambiar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ACheckBox(
          valor: valor,
          alCambiar: alCambiar,
        ),
        ALabel(texto: titulo),
      ],
    );
  }
}