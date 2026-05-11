import 'package:flutter/material.dart';
import '../../../tema/esquema_color.dart';

class ACheckBox extends StatelessWidget {
  final bool valor;
  final ValueChanged<bool?> alCambiar;

  const ACheckBox({
    super.key,
    required this.valor,
    required this.alCambiar,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: valor,
      onChanged: alCambiar,
      activeColor: ColoresApp.primario, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}