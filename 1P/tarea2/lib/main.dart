import 'package:flutter/material.dart';
import 'tema/index.dart';
import 'vistas/paginas/menu_pagina.dart';
import 'package:tarea2/vistas/paginas/servicios_pagina.dart';
//import 'package:tarea2/vistas/paginas/choferes_pagina.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarea 2',
      debugShowCheckedModeBanner: false,
      theme: TemaGeneral.temaClaro,
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuPagina(),
        '/servicios': (context) => const ServiciosPagina(),
        '/choferes': (context) =>
            const Scaffold(body: Center(child: Text('App 2 Próximamente'))),
      },
    );
  }
}
