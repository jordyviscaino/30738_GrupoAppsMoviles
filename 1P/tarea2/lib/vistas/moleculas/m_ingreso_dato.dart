import 'package:flutter/material.dart';
import '../atomos/a_label.dart';
import '../atomos/a_textfield.dart';

class MIngresoDato extends StatelessWidget {
  final String titulo;
  final String ayuda;
  final TextEditingController controlador;
  final IconData icono;
  final TextInputType tipoTeclado;

  const MIngresoDato({
    super.key,
    required this.titulo,
    required this.ayuda,
    required this.controlador,
    required this.icono,
    this.tipoTeclado = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ALabel(texto: titulo, esTitulo: false),
        const SizedBox(height: 8),
        ATextField(
          controlador: controlador,
          textoAyuda: ayuda,
          icono: icono,
          tipoTeclado: tipoTeclado,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}