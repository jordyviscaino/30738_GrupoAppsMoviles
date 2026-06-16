import 'package:flutter/material.dart';
import 'view/view_insentivos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación de incentivos',
      debugShowCheckedModeBanner: false,
      home: IncentivosPage(),
    );
  }
}
