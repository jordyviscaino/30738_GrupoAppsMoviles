import 'package:flutter/material.dart';

class ATextField extends StatelessWidget {
  final TextEditingController controlador;
  final String textoAyuda;
  final IconData icono;
  final TextInputType tipoTeclado;

  const ATextField({
    super.key,
    required this.controlador,
    required this.textoAyuda,
    required this.icono,
    this.tipoTeclado = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controlador,
      keyboardType: tipoTeclado,
      decoration: InputDecoration(
        labelText: textoAyuda,
        prefixIcon: Icon(icono),
      ),
    );
  }
}