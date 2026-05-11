export 'esquema_color.dart';
export 'tema_tipografia.dart';
export 'tema_botones.dart';
export 'tema_formularios.dart';
import 'package:flutter/material.dart';
import 'package:tarea2/tema/tema_formularioS.dart';
import 'package:tarea2/tema/tema_tipografia.dart';
import 'esquema_color.dart';
import 'tema_botones.dart';
export 'tema_appbar.dart';
export 'tema_fondo.dart';
export 'tema_general.dart';

class TemaGlobal {
  static ThemeData get temaMinimalista {
    return ThemeData(
      scaffoldBackgroundColor: ColoresApp.background,
      primaryColor: ColoresApp.primario,
      textTheme: TipografiaApp.texto,
      elevatedButtonTheme: TemaBotones.botonPrincipal,
      outlinedButtonTheme: TemaBotones.botonSecundario,
      inputDecorationTheme: TemaFormulario.campoTexto,
      appBarTheme: const AppBarTheme(
        backgroundColor: ColoresApp.primario,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: ColoresApp.acento,
      ),
    );
  }
}