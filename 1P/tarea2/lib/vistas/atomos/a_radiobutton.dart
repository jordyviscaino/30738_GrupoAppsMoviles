import 'package:flutter/material.dart';
import '../../../tema/esquema_color.dart';

class ARadioButton<T> extends StatelessWidget {
  final T valor;
  final T grupoValor;
  final ValueChanged<T?> alCambiar;

  const ARadioButton({
    super.key,
    required this.valor,
    required this.grupoValor,
    required this.alCambiar,
  });

  @override
  Widget build(BuildContext context) {
    return Radio<T>(
      value: valor,
      groupValue: grupoValor,
      onChanged: alCambiar,
      activeColor: ColoresApp.primario,
    );
  }
}