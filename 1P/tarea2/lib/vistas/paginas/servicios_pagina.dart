import 'package:flutter/material.dart';

import '../../controladores/servicios_controller.dart';
import '../../modelos/servicios_model.dart';

//import atomos
import '../atomos/a_label.dart';
import '../atomos/a_textfield.dart';
import '../atomos/a_boton.dart';
import '../atomos/a_checkbox.dart';
import '../atomos/a_radiobutton.dart';

//import moleculas
import '../moleculas/m_resultado_card.dart';
import '../moleculas/m_opcion_check.dart';
import '../moleculas/m_opcion_radio.dart';
import '../moleculas/m_ingreso_dato.dart';

//import temas
import '../../tema/tema_fondo.dart';
import '../../tema/tema_appbar.dart';
import '../../tema/tema_botones.dart';
import '../../tema/tema_formularios.dart';
import '../../tema/tema_tipografia.dart';

class ServiciosPagina extends StatefulWidget {
  const ServiciosPagina({super.key});

  @override
  State<ServiciosPagina> createState() => _ServiciosPaginaState();
}

class _ServiciosPaginaState extends State<ServiciosPagina> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController valorController = TextEditingController();

  final ServiciosController controller = ServiciosController();

  String tipoServicio = 'Agua potable';
  String formaPago = 'Efectivo';

  bool tieneMora = false;
  bool servicioAdicional = false;

  ServiciosModel? resultado;

  final List<String> servicios = [
    'Agua potable',
    'Energía eléctrica',
    'Internet y telefonía',
    'TV por cable y streaming',
    'Otros pagos frecuentes',
  ];

  final List<String> formasPago = ['Efectivo', 'Tarjeta', 'Transferencia'];

  void calcular() {
    final error = controller.validarCampos(
      nombreCliente: nombreController.text,
      cedulaCliente: cedulaController.text,
      valorBaseTexto: valorController.text,
    );

    if (error != null) {
      setState(() {
        resultado = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: Colors.redAccent),
      );
      return;
    }

    final pago = controller.procesar(
      nombreCliente: nombreController.text,
      cedulaCliente: cedulaController.text,
      valorBaseTexto: valorController.text,
      tipoServicio: tipoServicio,
      formaPago: formaPago,
      tieneMora: tieneMora,
      servicioAdicional: servicioAdicional,
    );

    setState(() {
      resultado = pago;
    });
  }

  void limpiar() {
    setState(() {
      nombreController.clear();
      cedulaController.clear();
      valorController.clear();

      tipoServicio = 'Agua potable';
      formaPago = 'Efectivo';

      tieneMora = false;
      servicioAdicional = false;

      resultado = null;
    });
  }

  @override
  void dispose() {
    nombreController.dispose();
    cedulaController.dispose();
    valorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: TemaFondo.degradadoPastel,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Pagos de servicios básicos'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ALabel(texto: 'Datos del cliente', esTitulo: true),

              const SizedBox(height: 15),

              ATextField(
                controlador: nombreController,
                textoAyuda: 'Nombre del cliente',
                icono: Icons.person,
              ),

              const SizedBox(height: 12),

              ATextField(
                controlador: cedulaController,
                textoAyuda: 'Cédula',
                icono: Icons.badge,
                tipoTeclado: TextInputType.number,
              ),

              const SizedBox(height: 12),

              ATextField(
                controlador: valorController,
                textoAyuda: 'Consumo o valor base',
                icono: Icons.attach_money,
                tipoTeclado: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),

              const SizedBox(height: 25),

              const ALabel(texto: 'Tipo de servicio', esTitulo: true),

              const SizedBox(height: 8),

              ...servicios.map(
                (servicio) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      ARadioButton<String>(
                        valor: servicio,
                        grupoValor: tipoServicio,
                        alCambiar: (value) {
                          setState(() {
                            tipoServicio = value!;
                          });
                        },
                      ),
                      Expanded(child: ALabel(texto: servicio)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              const ALabel(texto: 'Condiciones adicionales', esTitulo: true),

              const SizedBox(height: 8),

              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    ACheckBox(
                      valor: tieneMora,
                      alCambiar: (value) {
                        setState(() {
                          tieneMora = value ?? false;
                        });
                      },
                    ),
                    const Expanded(
                      child: ALabel(texto: 'Aplicar recargo por mora del 10%'),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    ACheckBox(
                      valor: servicioAdicional,
                      alCambiar: (value) {
                        setState(() {
                          servicioAdicional = value ?? false;
                        });
                      },
                    ),
                    const Expanded(
                      child: ALabel(
                        texto: 'Agregar servicio adicional de \$3.50',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              const ALabel(texto: 'Forma de pago', esTitulo: true),

              const SizedBox(height: 8),

              ...formasPago.map(
                (pago) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      ARadioButton<String>(
                        valor: pago,
                        grupoValor: formaPago,
                        alCambiar: (value) {
                          setState(() {
                            formaPago = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ALabel(texto: pago),
                            Text(
                              pago == 'Efectivo'
                                  ? 'Aplica 5% de descuento'
                                  : pago == 'Tarjeta'
                                  ? 'Aplica 3% de recargo'
                                  : 'No aplica descuento ni recargo',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: ABoton(
                      texto: 'Calcular',
                      icono: Icons.calculate,
                      presionar: calcular,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ABoton(
                      texto: 'Limpiar',
                      icono: Icons.cleaning_services,
                      presionar: limpiar,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              if (resultado != null) _resumenPago(resultado!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _resumenPago(ServiciosModel pago) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ALabel(texto: 'Resumen del pago realizado', esTitulo: true),

            const SizedBox(height: 12),

            _fila('Cliente:', pago.nombreCliente),
            _fila('Cédula:', pago.cedulaCliente),
            _fila('Servicio:', pago.tipoServicio),
            _fila('Forma de pago:', pago.formaPago),
            _fila(
              pago.tipoServicio == 'Agua potable' ||
                      pago.tipoServicio == 'Energía eléctrica'
                  ? 'Consumo ingresado:'
                  : 'Valor base:',
              pago.tipoServicio == 'Agua potable' ||
                      pago.tipoServicio == 'Energía eléctrica'
                  ? pago.valorBase.toStringAsFixed(2)
                  : '\$${pago.valorBase.toStringAsFixed(2)}',
            ),
            _fila('Tarifa del Servicio:', pago.tarifa.toStringAsFixed(2)),
            _fila('Subtotal:', '\$${pago.subtotal.toStringAsFixed(2)}'),
            _fila(
              'Descuento (del subtotal):',
              '\$${pago.descuento.toStringAsFixed(2)}',
            ),
            _fila(
              'Recargo (del subtotal):',
              '\$${pago.recargo.toStringAsFixed(2)}',
            ),
            _fila('Adicional:', '\$${pago.adicional.toStringAsFixed(2)}'),

            const Divider(),

            _fila(
              'Total a pagar:',
              '\$${pago.total.toStringAsFixed(2)}',
              destacado: true,
            ),
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
              fontSize: destacado ? 18 : 15,
            ),
          ),
          Flexible(
            child: Text(
              valor,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: destacado ? FontWeight.bold : FontWeight.normal,
                fontSize: destacado ? 18 : 15,
                color: destacado ? Colors.blue : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
