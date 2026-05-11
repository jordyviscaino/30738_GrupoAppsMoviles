import 'package:flutter/material.dart';
import '../../controllers/inversion/inversion_controller.dart';
import '../../model/inversion/inversion_model.dart';

class InversionView extends StatefulWidget {
  const InversionView({super.key});

  @override
  State<InversionView> createState() => _InversionViewState();
}

class _InversionViewState extends State<InversionView> {
  final TextEditingController _depositoController = TextEditingController();
  final TextEditingController _aniosController = TextEditingController();

  final InversionController _controller = InversionController();
  final Color miColor = const Color(0xFF1E28E9);

  InversionModel? resultado;
  String error = '';

  void _calcularInversion() {
    FocusScope.of(context).unfocus();

    final respuesta = _controller.procesar(
      _depositoController.text,
      _aniosController.text,
    );

    setState(() {
      if (respuesta != null) {
        resultado = respuesta;
        error = '';
      } else {
        resultado = null;
        error = 'Verifica que los datos sean correctos';
      }
    });
  }

  @override
  void dispose() {
    _depositoController.dispose();
    _aniosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double totalFinal = resultado?.totalesPorAnio.last ?? 0.0;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Inversión anual'),
        backgroundColor: miColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: miColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    "INVERSIÓN FINAL",
                    style: TextStyle(color: Colors.white60, fontSize: 12),
                  ),
                  Text(
                    "\$ ${totalFinal.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _depositoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Depósito mensual',
                    prefixIcon: Icon(Icons.savings),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),

                TextField(
                  controller: _aniosController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Número de años',
                    prefixIcon: Icon(Icons.calendar_month),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),

                if (error.isNotEmpty)
                  Text(error, style: const TextStyle(color: Colors.red)),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _calcularInversion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: miColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('CALCULAR INVERSIÓN'),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: resultado == null
                ? const Center(
                    child: Text(
                      'Ingresa los datos para calcular la inversión.',
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: resultado!.totalesPorAnio.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: miColor.withOpacity(0.1),
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(color: miColor),
                            ),
                          ),
                          title: Text('Año ${index + 1}'),
                          subtitle: Text(
                            'Total acumulado: \$ ${resultado!.totalesPorAnio[index].toStringAsFixed(2)}',
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
