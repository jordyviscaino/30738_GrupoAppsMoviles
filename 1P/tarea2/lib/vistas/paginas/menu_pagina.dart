import 'package:flutter/material.dart';
import '../moleculas/m_tarjeta_menu.dart';
import '../../tema/tema_fondo.dart';
import 'package:tarea2/vistas/paginas/servicios_pagina.dart';

class MenuPagina extends StatelessWidget {
  const MenuPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: TemaFondo.degradadoPastel,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Tarea 1.2 - Flutter'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Seleccione una Aplicación',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B1B1F), // Aseguramos que el texto contraste
                ),
                textAlign: TextAlign.center,
              ),
            ),
            MTarjetaMenu(
              titulo: 'Pagos de Servicios',
              subtitulo: 'Agua, Luz, Internet y más.',
              icono: Icons.receipt_long,
              alPresionar: () {
                Navigator.pushNamed(context, '/servicios');
              },
            ),
            const SizedBox(height: 10),
            MTarjetaMenu(
              titulo: 'Nómina de Choferes',
              subtitulo: 'Control de horas y sueldos semanales.',
              icono: Icons.local_shipping,
              alPresionar: () {
                Navigator.pushNamed(context, '/choferes');
              },
            ),
          ],
        ),
      ),
    );
  }
}
