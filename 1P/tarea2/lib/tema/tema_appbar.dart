import 'package:flutter/material.dart';
import 'esquema_color.dart';
import 'tema_tipografia.dart';

class TemaAppBar {
  static final appBarClara = AppBarTheme(
    backgroundColor: ColoresApp.primario,
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TipografiaApp.texto.headlineMedium?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );

  static final appBarOscura = AppBarTheme(
    backgroundColor: const Color(0xFF1E1E1E),
    foregroundColor: ColoresApp.primario,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TipografiaApp.texto.headlineMedium?.copyWith(
      color: ColoresApp.primario,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(color: ColoresApp.primario),
  );
}