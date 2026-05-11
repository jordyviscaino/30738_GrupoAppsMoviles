import 'package:flutter/material.dart';
import 'index.dart';

class TemaGeneral {
  static ThemeData get temaClaro {
    return ThemeData(
      useMaterial3: true, //para el diseño material you
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColoresApp.primario,
        background: TemaFondo.fondoClaro,
        surface: ColoresApp.superficie,
        primary: ColoresApp.primario,
        secondary: ColoresApp.secundario,
      ),
      scaffoldBackgroundColor: TemaFondo.fondoClaro,
      appBarTheme: AppBarTheme(
        backgroundColor: TemaFondo.fondoClaro,
        foregroundColor: ColoresApp.textPrincipal,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: ColoresApp.textPrincipal,
            fontSize: 22,
            fontWeight: FontWeight.w600
        ),
      ),
      cardTheme: TemaFondo.tarjetaClara,
      elevatedButtonTheme: TemaBotones.botonPrincipal,
      outlinedButtonTheme: TemaBotones.botonSecundario,
      inputDecorationTheme: TemaFormulario.campoTexto,
    );
  }

}