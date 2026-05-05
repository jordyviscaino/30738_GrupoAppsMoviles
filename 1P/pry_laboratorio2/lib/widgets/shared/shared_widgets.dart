// Ruta: lib/widgets/shared_widgets.dart
import 'package:flutter/material.dart';

// --- ÁTOMOS ---

class ATextField extends StatelessWidget {
  final TextEditingController controlador;
  final String textoAyuda;
  final IconData icono;
  final Color colorPrincipal;

  const ATextField({
    super.key,
    required this.controlador,
    required this.textoAyuda,
    required this.icono,
    this.colorPrincipal = Colors.blueAccent
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controlador,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: textoAyuda,
        labelStyle: TextStyle(color: colorPrincipal),
        prefixIcon: Icon(icono, color: colorPrincipal),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xFF95A1F1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: colorPrincipal, width: 2),
        ),
      ),
    );
  }
}

class ABoton extends StatelessWidget {
  final String texto;
  final VoidCallback presionar;
  final Color colorBoton;

  const ABoton({
    super.key,
    required this.texto,
    required this.presionar,
    this.colorBoton = Colors.blueAccent
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: presionar,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: colorBoton,
        child: const Icon(Icons.send, color: Colors.white), // Ícono tipo enviar mensaje
      ),
    );
  }
}

// --- MOLÉCULAS COMPARTIDAS ---

class MResultados extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icono;
  final Color color;

  const MResultados({
    super.key,
    required this.titulo,
    required this.valor,
    required this.icono,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 2,
      child: ListTile(
        leading: Icon(icono, color: color, size: 30),
        title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(
            valor,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)
        ),
      ),
    );
  }
}