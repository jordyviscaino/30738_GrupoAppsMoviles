import 'package:flutter/material.dart';
import '../../../tema/esquema_color.dart';

class MTarjetaMenu extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final IconData icono;
  final VoidCallback alPresionar;

  const MTarjetaMenu({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.icono,
    required this.alPresionar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // El estilo viene de TemaFondo.tarjetaClara definido en el tema global
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: CircleAvatar(
          backgroundColor: ColoresApp.primario.withOpacity(0.1),
          child: Icon(icono, color: ColoresApp.primario),
        ),
        title: Text(
          titulo, 
          style: const TextStyle(fontWeight: FontWeight.bold)
        ),
        subtitle: Text(subtitulo),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: alPresionar,
      ),
    );
  }
}