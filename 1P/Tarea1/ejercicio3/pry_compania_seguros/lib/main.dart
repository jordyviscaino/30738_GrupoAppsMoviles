import 'package:flutter/material.dart';
import 'view/seguros_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculo de cuotas segun el monto',
      //theme: ThemeData(primarySwatch: Colors.green),
      home: CuotaPage(),
    );
  }
}
