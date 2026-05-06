import 'package:flutter/material.dart';
import '../controller/incentivo_controller.dart';

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
  final TextInputType? type;

  const WidgetTextField({
    super.key,
    required this.controller,
    this.type,
    this.textoVolatil,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type ?? TextInputType.number,
      decoration: InputDecoration(
        labelText: textoVolatil,
        prefix: Text('Unidades: '),
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

// molecula
class UnidadesPorDiaInput extends StatelessWidget {
  final TextEditingController controllerLunes;
  final TextEditingController controllerMartes;
  final TextEditingController controllerMiercoles;
  final TextEditingController controllerJueves;
  final TextEditingController controllerViernes;
  final TextEditingController controllerSabado;

  const UnidadesPorDiaInput({
    super.key,
    required this.controllerJueves,
    required this.controllerLunes,
    required this.controllerMartes,
    required this.controllerMiercoles,
    required this.controllerViernes,
    required this.controllerSabado,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextoWidget(texto: 'Ingreso de unidades por dia'),
        SizedBox(height: 8),
        WidgetTextField(controller: controllerLunes, textoVolatil: 'Lunes'),
        SizedBox(height: 8),
        WidgetTextField(controller: controllerMartes, textoVolatil: 'Martes'),
        SizedBox(height: 8),
        WidgetTextField(
          controller: controllerMiercoles,
          textoVolatil: 'Miercoles',
        ),
        SizedBox(height: 8),
        WidgetTextField(controller: controllerJueves, textoVolatil: 'Jueves'),
        SizedBox(height: 8),
        WidgetTextField(controller: controllerViernes, textoVolatil: 'Viernes'),
        SizedBox(height: 8),
        WidgetTextField(controller: controllerSabado, textoVolatil: 'Sabado'),
      ],
    );
  }
}

// organismo
class IncentivosCard extends StatefulWidget {
  const IncentivosCard({super.key});

  @override
  State<StatefulWidget> createState() => _IncentivoCardState();
}

class _IncentivoCardState extends State<IncentivosCard> {
  final IncentivoController _incentivoController = IncentivoController();

  final TextEditingController _controllerLunes = TextEditingController();
  final TextEditingController _controllerMartes = TextEditingController();
  final TextEditingController _controllerMiercoles = TextEditingController();
  final TextEditingController _controllerJueves = TextEditingController();
  final TextEditingController _controllerViernes = TextEditingController();
  final TextEditingController _controllerSabado = TextEditingController();

  String _resultado = '';

  void calcularIncentivo() {
    setState(() {
      _resultado = _incentivoController.incentivoUnidad(
        _controllerLunes.text,
        _controllerMartes.text,
        _controllerMiercoles.text,
        _controllerJueves.text,
        _controllerViernes.text,
        _controllerSabado.text,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Column(
          children: [
            UnidadesPorDiaInput(
              controllerJueves: _controllerJueves,
              controllerLunes: _controllerLunes,
              controllerMartes: _controllerMartes,
              controllerMiercoles: _controllerMiercoles,
              controllerViernes: _controllerViernes,
              controllerSabado: _controllerSabado,
            ),
            SizedBox(height: 20),
            BotonCalcular(
              texto: 'Calcular incentivos',
              onPressed: calcularIncentivo,
            ),
            SizedBox(height: 20),
            ResultadoText(resultado: _resultado),
          ],
        ),
      ),
    );
  }
}

class IncentivosPage extends StatelessWidget {
  const IncentivosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculo de incentivos'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: IncentivosCard(),
      ),
    );
  }
}
