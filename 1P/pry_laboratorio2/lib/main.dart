import 'package:flutter/material.dart';
 import 'view/splash_view.dart';
 import 'view/menu_view.dart';
 import 'view/escuela/escuela_view.dart';
import 'view/caja/caja_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laboratorio 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashView(),
        '/menu': (context) => const MenuView(),
        '/ejercicio410': (context) => const EscuelaView(),
         '/ejercicio412': (context) => const CajaView(),
      },
    );
  }
}