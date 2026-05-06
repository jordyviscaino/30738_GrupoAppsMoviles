import '../controller/seguros_controller.dart';
import 'package:flutter/material.dart';

//atomos
class TextoWidget extends StatelessWidget {
  final String texto;
  const TextoWidget({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}

// ingres de información
class WidgetTextField extends StatelessWidget {
  final String? textoVolatil;
  final TextEditingController controller;
  final TextInputType type;

  const WidgetTextField({
    super.key,
    required this.controller,
    required this.type,
    this.textoVolatil,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: textoVolatil,
        prefix: Text('\$'),
        border: OutlineInputBorder(),
      ),
    );
  }
}

//boton
class BotonCalcular extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;
  final Color? colorBoton;
  final Color? colorTexto;

  const BotonCalcular({
    super.key,
    required this.texto,
    required this.onPressed,
    this.colorBoton,
    this.colorTexto,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorBoton ?? Colors.cyan,
        foregroundColor: colorTexto ?? Colors.black,
      ),
      child: Text(texto),
    );
  }
}

class ResultadoText extends StatelessWidget {
  final String resultado;

  const ResultadoText({super.key, required this.resultado});

  @override
  Widget build(BuildContext context) {
    return Text(
      resultado,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18),
    );
  }
}

//moelcula
class CuotaInput extends StatelessWidget {
  final TextEditingController controller;

  const CuotaInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextoWidget(texto: 'Monto para la finanza:'),
        SizedBox(height: 8),
        WidgetTextField(
          controller: controller,
          type: TextInputType.text,
          textoVolatil: 'Ej: \$20 ó \$20.00',
        ),
      ],
    );
  }
}

//organismo
class CalcularMontoCard extends StatefulWidget {
  const CalcularMontoCard({super.key});

  @override
  State<StatefulWidget> createState() => _CalcularMontoCardState();
}

class _CalcularMontoCardState extends State<CalcularMontoCard> {
  final TextEditingController _montoController = TextEditingController();
  final SegurosController _controller = SegurosController();
  String _resultado = '';

  //metodo calcular monto
  void calcularCuota() {
    setState(() {
      _resultado = _controller.valorAPagar(_montoController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Column(
          children: [
            CuotaInput(controller: _montoController),
            SizedBox(height: 20),
            BotonCalcular(texto: 'Calcular cuota', onPressed: calcularCuota),
            SizedBox(height: 20),
            ResultadoText(resultado: _resultado),
          ],
        ),
      ),
    );
  }
}

//pagina
class CuotaPage extends StatelessWidget {
  const CuotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculo de cuotas'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: CalcularMontoCard(),
      ),
    );
  }
}
