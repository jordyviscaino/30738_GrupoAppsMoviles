import 'package:flutter/material.dart';
import 'esquema_color.dart';

class TipografiaApp {
  static const TextTheme texto = TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: ColoresApp.textPrincipal,
      letterSpacing: 0.5,
    ),
    headlineMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: ColoresApp.textPrincipal,
      letterSpacing: 0.25,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: ColoresApp.textPrincipal,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: ColoresApp.textSecundario,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0,
      color: Colors.white,
    ),
  );
}