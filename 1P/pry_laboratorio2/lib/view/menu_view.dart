import 'package:flutter/material.dart';

// --- MOLÉCULA: Opción de Menú ---
// Representa cada botón que nos llevará a un ejercicio
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          // Aquí aplicamos la navegación PushNamed que investigaste
          Navigator.pushNamed(context, ruta);
        },
      ),
    );
  }
}

// --- PÁGINA: Menú Principal ---
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),

          // Ejercicio 4.10
          const MOpcionMenu(
            titulo: 'Ejercicio 4.10',
            subtitulo: 'Promedio de edades por salón y escuela.',
            icono: Icons.school,
            ruta: '/ejercicio410',
            colorTema: miColor,
          ),

          // Ejercicio 4.12 (Añadido preventivamente para cuando lo enlacemos en main.dart)
          MOpcionMenu(
            titulo: 'Ejercicio 4.12',
            subtitulo: 'Total de dinero en caja registradora.',
            icono: Icons.point_of_sale,
            ruta: '/ejercicio412', // Esta ruta la agregaremos luego al main.dart
            colorTema: Colors.green.shade700,
          ),

          // Aquí podrás añadir el 4.9 u otros fácilmente copiando y pegando la molécula
        ],
      ),
    );
  }
}