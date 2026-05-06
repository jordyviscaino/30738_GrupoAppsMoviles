import 'package:flutter/material.dart';
import '../../../widgets/shared/shared_widgets.dart';

class CajaInputWidget extends StatelessWidget {
  final TextEditingController ctrlValor;
  final TextEditingController ctrlCantidad;
  final VoidCallback alEliminar;
  final Color colorTema;

  const CajaInputWidget({
    super.key,
    required this.ctrlValor,
    required this.ctrlCantidad,
    required this.alEliminar,
    required this.colorTema,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5, offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: ATextField(
              controlador: ctrlValor,
              textoAyuda: 'Denominación',
              icono: Icons.payments,
              colorPrincipal: colorTema,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: ATextField(
              controlador: ctrlCantidad,
              textoAyuda: 'Cant.',
              icono: Icons.tag,
              colorPrincipal: colorTema,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            onPressed: alEliminar,
          ),
        ],
      ),
    );
  }
}