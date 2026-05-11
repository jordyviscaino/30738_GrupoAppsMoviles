import 'package:flutter/material.dart';
import '../atomos/a_radiobutton.dart';
import '../atomos/a_label.dart';

class MOpcionRadio<T> extends StatelessWidget {
  final String titulo;
  final T valor;
  final T grupoValor;
  final ValueChanged<T?> alCambiar;

  const MOpcionRadio({
    super.key,
    required this.titulo,
    required this.valor,
    required this.grupoValor,
    required this.alCambiar,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => alCambiar(valor),
      child: Row(
        children: [
          ARadioButton<T>(
            valor: valor,
            grupoValor: grupoValor,
            alCambiar: alCambiar,
          ),
          ALabel(texto: titulo),
        ],
      ),
    );
  }
}