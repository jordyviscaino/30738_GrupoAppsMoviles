import 'package:flutter/material.dart';
import 'esquema_color.dart';

class TemaBotones {
  static final botonPrincipal = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColoresApp.primarioContenedor,
        foregroundColor: ColoresApp.textPrincipal,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 0,
        shape: StadiumBorder(),
      )
  );

  static final botonSecundario = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColoresApp.textSecundario,
        side: BorderSide(color: ColoresApp.secundario),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: StadiumBorder(),
      )
  );
}