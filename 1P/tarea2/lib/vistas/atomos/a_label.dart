import 'package:flutter/material.dart';

class ALabel extends StatelessWidget {
  final String texto;
  final bool esTitulo;

  const ALabel({
    super.key,
    required this.texto,
    this.esTitulo = false,
  });

  @override
  Widget build(BuildContext context) {
    final temaTexto = Theme.of(context).textTheme;
    
    return Text(
      texto,
      style: esTitulo ? temaTexto.headlineMedium : temaTexto.bodyLarge,
    );
  }
}