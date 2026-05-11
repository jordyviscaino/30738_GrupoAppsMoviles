import 'package:flutter/material.dart';
import 'esquema_color.dart';

class TemaFondo {
  static final tarjetaClara = CardThemeData(
    color: ColoresApp.superficie,
    elevation: 0.5,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
      side: BorderSide(color: ColoresApp.primario.withOpacity(0.2), width: 1),
    ),
  );

  static final tarjetaOscura = CardThemeData(
    color: const Color(0xFF1B1B1F),
    elevation: 0,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );

  static const BoxDecoration degradadoPastel = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFE8EAF6),
        Color(0xFFFCE4EC),
        Color(0xFFE0F2F1),
      ],
      stops: [0.0, 0.5, 1.0],
    ),
  );

  static const Color fondoClaro = ColoresApp.background;
  static const Color fondoOscuro = Color(0xFF111318);
}