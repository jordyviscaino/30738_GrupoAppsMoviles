import 'package:flutter/material.dart';
import '../../controladores/choferes_controller.dart';
import '../../modelos/choferes_model.dart';
import '../atomos/a_boton.dart';
import '../atomos/a_checkbox.dart';
import '../atomos/a_label.dart';
import '../atomos/a_radiobutton.dart';
import '../atomos/a_textfield.dart';
import '../../tema/tema_fondo.dart';

class ChoferesPagina extends StatefulWidget {
  const ChoferesPagina({super.key});

  @override
  State<ChoferesPagina> createState() => _ChoferesPaginaState();
}

class _ChoferesPaginaState extends State<ChoferesPagina> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController sueldoController = TextEditingController();
  final List<TextEditingController> horasControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final ChoferesController controller = ChoferesController();

  final List<String> jornadas = ['Diurna', 'Nocturna', 'Mixta'];
  final List<String> dias = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
  ];

  bool activo = true;
  bool recibeBono = false;
  String jornada = 'Diurna';

  final List<ChoferModel> choferes = [];
  NominaChoferesModel? resumen;

  void registrarChofer() {
    if (choferes.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ya se registraron los cinco choferes.'),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    final error = controller.validarChofer(
      nombre: nombreController.text,
      sueldoHoraTexto: sueldoController.text,
      horasTexto: horasControllers
          .map((controlador) => controlador.text)
          .toList(),
    );

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: Colors.redAccent),
      );
      return;
    }

    final chofer = controller.crearChofer(
      nombre: nombreController.text,
      sueldoHoraTexto: sueldoController.text,
      horasTexto: horasControllers
          .map((controlador) => controlador.text)
          .toList(),
      activo: activo,
      recibeBono: recibeBono,
      jornada: jornada,
    );

    setState(() {
      choferes.add(chofer);
      resumen = null;
      nombreController.clear();
      sueldoController.clear();
      for (final controlador in horasControllers) {
        controlador.clear();
      }
      activo = true;
      recibeBono = false;
      jornada = 'Diurna';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Chofer registrado (${choferes.length}/5).'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void calcularNomina() {
    if (choferes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Registre al menos un chofer antes de calcular la nómina.',
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      resumen = controller.calcularNomina(choferes);
    });
  }

  void limpiar() {
    setState(() {
      nombreController.clear();
      sueldoController.clear();
      for (final controlador in horasControllers) {
        controlador.clear();
      }
      activo = true;
      recibeBono = false;
      jornada = 'Diurna';
      choferes.clear();
      resumen = null;
    });
  }

  @override
  void dispose() {
    nombreController.dispose();
    sueldoController.dispose();
    for (final controlador in horasControllers) {
      controlador.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: TemaFondo.degradadoPastel,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Nómina de Choferes'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ALabel(texto: 'Registro de chofer', esTitulo: true),
              const SizedBox(height: 15),
              ATextField(
                controlador: nombreController,
                textoAyuda: 'Nombre del chofer',
                icono: Icons.person,
              ),
              const SizedBox(height: 12),
              ATextField(
                controlador: sueldoController,
                textoAyuda: 'Sueldo por hora',
                icono: Icons.payments,
                tipoTeclado: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              const SizedBox(height: 20),
              const ALabel(texto: 'Horas trabajadas por día', esTitulo: true),
              const SizedBox(height: 12),
              _horasPorDiaCampos(),
              const SizedBox(height: 20),
              const ALabel(texto: 'Tipo de jornada', esTitulo: true),
              const SizedBox(height: 8),
              ...jornadas.map(
                (valor) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.85),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      ARadioButton<String>(
                        valor: valor,
                        grupoValor: jornada,
                        alCambiar: (value) {
                          setState(() {
                            jornada = value!;
                          });
                        },
                      ),
                      Expanded(child: ALabel(texto: valor)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const ALabel(texto: 'Opciones', esTitulo: true),
              const SizedBox(height: 8),
              _opcionCheck(
                valor: activo,
                texto: 'Chofer activo',
                alCambiar: (value) {
                  setState(() {
                    activo = value ?? false;
                  });
                },
              ),
              _opcionCheck(
                valor: recibeBono,
                texto: 'Recibe bono de 10%',
                alCambiar: (value) {
                  setState(() {
                    recibeBono = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ABoton(
                      texto: 'Registrar',
                      icono: Icons.person_add,
                      presionar: registrarChofer,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ABoton(
                      texto: 'Calcular',
                      icono: Icons.calculate,
                      presionar: calcularNomina,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ABoton(
                      texto: 'Limpiar',
                      icono: Icons.cleaning_services,
                      presionar: limpiar,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ABoton(
                      texto: 'Volver',
                      icono: Icons.arrow_back,
                      presionar: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ALabel(
                texto: 'Choferes registrados: ${choferes.length}/5',
                esTitulo: false,
              ),
              const SizedBox(height: 12),
              if (choferes.isNotEmpty) _listaChoferesRegistrados(),
              if (resumen != null) ...[
                const SizedBox(height: 20),
                _resumenNomina(resumen!),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _horasPorDiaCampos() {
    return Column(
      children: [
        for (int fila = 0; fila < 2; fila++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                for (int columna = 0; columna < 3; columna++)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: columna < 2 ? 10 : 0),
                      child: ATextField(
                        controlador: horasControllers[fila * 3 + columna],
                        textoAyuda: dias[fila * 3 + columna],
                        icono: Icons.schedule,
                        tipoTeclado: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _opcionCheck({
    required bool valor,
    required String texto,
    required ValueChanged<bool?> alCambiar,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.85),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          ACheckBox(valor: valor, alCambiar: alCambiar),
          Expanded(child: ALabel(texto: texto)),
        ],
      ),
    );
  }

  Widget _listaChoferesRegistrados() {
    return Column(
      children: choferes.map((chofer) {
        final double horasTotales = controller.calcularHorasTotales(chofer);
        final double sueldoSemanal = controller.calcularSueldoSemanal(chofer);

        String estadoActivo = 'No';
        if (chofer.activo) {
          estadoActivo = 'Sí';
        }

        String recibeBonoTexto = 'No';
        if (chofer.recibeBono) {
          recibeBonoTexto = 'Sí';
        }

        return Card(
          elevation: 3,
          margin: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ALabel(texto: chofer.nombre, esTitulo: true),
                const SizedBox(height: 8),
                _fila('Jornada:', chofer.jornada),
                _fila('Activo:', estadoActivo),
                _fila('Recibe bono:', recibeBonoTexto),
                _fila('Horas totales:', horasTotales.toStringAsFixed(1)),
                _fila(
                  'Sueldo semanal:',
                  '\$${sueldoSemanal.toStringAsFixed(2)}',
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _resumenNomina(NominaChoferesModel resumen) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ALabel(texto: 'Reporte general de nómina', esTitulo: true),
            const SizedBox(height: 12),
            _fila('Chofer con más horas lunes:', resumen.choferMasHorasLunes),
            _fila(
              'Total general a pagar:',
              '\$${resumen.totalGeneral.toStringAsFixed(2)}',
              destacado: true,
            ),
            const Divider(height: 30),
            const ALabel(texto: 'Detalle por chofer', esTitulo: true),
            const SizedBox(height: 12),
            ...resumen.choferes.map((chofer) {
              final double horasTotales = controller.calcularHorasTotales(
                chofer,
              );
              final double sueldoSemanal = controller.calcularSueldoSemanal(
                chofer,
              );
              final double bono = controller.calcularBono(chofer);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _fila('Nombre:', chofer.nombre),
                  _fila('Horas totales:', horasTotales.toStringAsFixed(1)),
                  _fila(
                    'Sueldo semanal:',
                    '\$${sueldoSemanal.toStringAsFixed(2)}',
                  ),
                  _fila('Pago por bono:', '\$${bono.toStringAsFixed(2)}'),
                  const Divider(),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _fila(String titulo, String valor, {bool destacado = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titulo,
            style: TextStyle(
              fontWeight: destacado ? FontWeight.bold : FontWeight.w500,
              fontSize: destacado ? 16 : 15,
            ),
          ),
          Flexible(
            child: Text(
              valor,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: destacado ? FontWeight.bold : FontWeight.normal,
                fontSize: destacado ? 16 : 15,
                color: destacado ? Colors.blue : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
