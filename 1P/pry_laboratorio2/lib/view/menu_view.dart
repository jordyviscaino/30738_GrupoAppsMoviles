import 'package:flutter/material.dart';

class MOpcionMenu extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final IconData icono;
  final String ruta;
  final Color colorTema;

  const MOpcionMenu({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.icono,
    required this.ruta,
    required this.colorTema,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        leading: CircleAvatar(
          backgroundColor: colorTema.withOpacity(0.1),
          radius: 25,
          child: Icon(icono, color: colorTema, size: 28),
        ),
        title: Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(subtitulo),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: () {
          Navigator.pushNamed(context, ruta);
        },
      ),
    );
  }
}

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color miColor = Color(0xFF1E28E9);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Laboratorio 2'),
        backgroundColor: miColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Selecciona un ejercicio:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const MOpcionMenu(
            titulo: 'Ejercicio 2',
            subtitulo: 'Promedio de edades por salon y escuela.',
            icono: Icons.school,
            ruta: '/ejercicio410',
            colorTema: miColor,
          ),
          MOpcionMenu(
            titulo: 'Ejercicio 3',
            subtitulo: 'Total de dinero en caja registradora.',
            icono: Icons.point_of_sale,
            ruta: '/ejercicio412',
            colorTema: Colors.green.shade700,
          ),
          MOpcionMenu(
            titulo: "Ejercicio 4.9",
            subtitulo: "Inversión con depósito mensual e interés anual.",
            icono: Icons.savings,
            ruta: "/ejercicio409",
            colorTema: Colors.purple.shade700,
          ),
        ],
      ),
    );
  }
}
