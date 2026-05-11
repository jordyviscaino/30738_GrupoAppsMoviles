import 'package:flutter/material.dart';
import 'esquema_color.dart';
import 'tema_tipografia.dart';

class TemaFormulario {
  static final campoTexto = InputDecorationTheme(
    filled: true,
    fillColor: ColoresApp.superficie, 
    labelStyle: TipografiaApp.texto.bodyMedium,
    prefixIconColor: ColoresApp.secundario,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFFE0E0E0)), 
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: ColoresApp.primario, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: ColoresApp.error),
    ),
    hintStyle: const TextStyle(color: Color(0xFFBDBDBD)),
  );
}