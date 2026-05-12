import 'package:flutter/material.dart';
import 'vista/Tarea2_vista.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicios MVC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
        '/ej1': (context) => const Ejercicio1Page(),
        '/ej2': (context) => const Ejercicio2Page(),
        '/ej3': (context) => const Ejercicio3Page(),
        '/ej4': (context) => const Ejercicio4Page(),
        '/ej5': (context) => const Ejercicio5Page(),
      },
    );
  }
}
