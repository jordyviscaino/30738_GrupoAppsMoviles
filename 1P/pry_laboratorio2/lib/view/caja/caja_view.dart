import 'package:flutter/material.dart';
import '../../model/caja/caja_model.dart';
import '../../controllers/caja/caja_controller.dart';
import '../../widgets/shared/shared_widgets.dart'; // Para MResultados
import '../../widgets/shared/caja_input_widget.dart';
import '../../widgets/shared/caja_boton_widget.dart';

class CajaView extends StatefulWidget {
  const CajaView({super.key});

  @override
  State<CajaView> createState() => _CajaViewState();
}

class _CajaViewState extends State<CajaView> {
  final List<Map<String, TextEditingController>> _inputs = [
    {'valor': TextEditingController(), 'cantidad': TextEditingController()}
  ];

  final Color miColor = const Color(0xFF1E28E9);
  final CajaController _cajaController = CajaController();
  CajaModel? resultado;
  String error = '';

  void _agregarFila() => setState(() => _inputs.add({'valor': TextEditingController(), 'cantidad': TextEditingController()}));

  void _eliminarFila(int index) {
    if (_inputs.length > 1) {
      setState(() {
        _inputs[index]['valor']!.dispose();
        _inputs[index]['cantidad']!.dispose();
        _inputs.removeAt(index);
      });
    }
  }

  void _procesarCaja() {
    FocusScope.of(context).unfocus();
    List<Map<String, String>> datos = _inputs.map((e) => {
      'valor': e['valor']!.text,
      'cantidad': e['cantidad']!.text
    }).toList();

    final respuesta = _cajaController.procesar(datos);
    setState(() {
      if (respuesta != null) {
        resultado = respuesta;
        error = '';
      } else {
        error = 'Verifica que los datos sean correctos';
        resultado = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text('Arqueo de Caja'), backgroundColor: miColor, foregroundColor: Colors.white),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: miColor,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Center(
              child: Column(
                children: [
                  const Text("TOTAL REGISTRADO", style: TextStyle(color: Colors.white60, fontSize: 12)),
                  Text("\$ ${resultado?.totalDinero.toStringAsFixed(2) ?? '0.00'}",
                      style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: _inputs.length,
              itemBuilder: (context, index) => CajaInputWidget(
                ctrlValor: _inputs[index]['valor']!,
                ctrlCantidad: _inputs[index]['cantidad']!,
                colorTema: miColor,
                alEliminar: () => _eliminarFila(index),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                if (error.isNotEmpty) Text(error, style: const TextStyle(color: Colors.red)),

                TextButton.icon(
                  onPressed: _agregarFila,
                  icon: const Icon(Icons.add),
                  label: const Text("Agregar otra denominación"),
                ),
                const SizedBox(height: 10),

                BotonCajaGrande(
                  texto: "CALCULAR TOTAL",
                  alPresionar: _procesarCaja,
                  color: miColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}