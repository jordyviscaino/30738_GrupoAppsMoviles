// Ruta: lib/views/escuela/escuela_view.dart
import 'package:flutter/material.dart';
// 1. Importamos desde las carpetas específicas
import '../../model/escuela/escuela_model.dart';
import '../../controllers/escuela/escuela_controller.dart';
// 2. Importamos los widgets compartidos
import '../../widgets/shared/shared_widgets.dart';

// Molécula específica para esta vista
class MSalonInput extends StatelessWidget {
  final TextEditingController controlador;
  final int indice;
  final VoidCallback alEliminar;
  final Color colorTema;

  const MSalonInput({
    super.key,
    required this.controlador,
    required this.indice,
    required this.alEliminar,
    required this.colorTema,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: ATextField(
              controlador: controlador,
              textoAyuda: 'Edades Salón ${indice + 1} (ej: 12,14,13)',
              icono: Icons.groups,
              colorPrincipal: colorTema,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle, color: Colors.redAccent),
            onPressed: alEliminar,
          ),
        ],
      ),
    );
  }
}

class EscuelaVista extends StatefulWidget {
  final Color colorTema;
  const EscuelaVista({super.key, required this.colorTema});

  @override
  State<EscuelaVista> createState() => _EscuelaVistaState();
}

class _EscuelaVistaState extends State<EscuelaVista> {
  final List<TextEditingController> _controllers = [TextEditingController()];
  final EscuelaController _controllerBusqueda = EscuelaController();

  EscuelaModel? resultado;
  String error = '';

  void _agregarSalon() => setState(() => _controllers.add(TextEditingController()));

  void _eliminarSalon(int index) {
    if (_controllers.length > 1) {
      setState(() {
        _controllers[index].dispose();
        _controllers.removeAt(index);
      });
    }
  }

  void _ejecutarCalculo() {
    FocusScope.of(context).unfocus(); // Ocultar teclado
    List<String> inputs = _controllers.map((c) => c.text).toList();
    final respuesta = _controllerBusqueda.procesar(inputs);

    setState(() {
      if (respuesta != null) {
        resultado = respuesta;
        error = '';
      } else {
        resultado = null;
        error = 'Error: Revisa que todos los campos tengan edades válidas (1-120).';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- ZONA SUPERIOR: RESULTADOS (TIPO HISTORIAL DE CHAT) ---
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              if (error.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(10)),
                  child: Text(error, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
                ),
              if (resultado != null) ...[
                MResultados(
                  titulo: 'Promedio Global',
                  valor: resultado!.promedioGlobal.toStringAsFixed(2),
                  icono: Icons.analytics,
                  color: widget.colorTema,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text("Promedios por Salón:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                ),
                ...resultado!.promediosSalones.asMap().entries.map((entry) => MResultados(
                  titulo: 'Salón ${entry.key + 1}',
                  valor: entry.value.toStringAsFixed(2),
                  icono: Icons.meeting_room,
                  color: Colors.green,
                )),
              ] else if (error.isEmpty) ...[
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Text("Agrega los salones abajo y presiona enviar", style: TextStyle(color: Colors.grey)),
                  ),
                )
              ]
            ],
          ),
        ),

        // --- ZONA INFERIOR: ENTRADA DE DATOS (TIPO BARRA DE CHAT) ---
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Se adapta al contenido
            children: [
              // Lista de TextFields (limitada en altura para no cubrir toda la pantalla si hay muchos salones)
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _controllers.length,
                  itemBuilder: (context, index) => MSalonInput(
                    controlador: _controllers[index],
                    indice: index,
                    colorTema: widget.colorTema,
                    alEliminar: () => _eliminarSalon(index),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              // Controles inferiores
              Row(
                children: [
                  TextButton.icon(
                    onPressed: _agregarSalon,
                    icon: const Icon(Icons.add),
                    label: const Text("Añadir Salón"),
                    style: TextButton.styleFrom(foregroundColor: widget.colorTema),
                  ),
                  const Spacer(),
                  ABoton(
                    texto: 'Calcular',
                    presionar: _ejecutarCalculo,
                    colorBoton: widget.colorTema,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class EscuelaView extends StatelessWidget {
  const EscuelaView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color micolor = Color(0xFF1E28E9);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promedio Escolar'),
        backgroundColor: micolor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: const EscuelaVista(colorTema: micolor),
    );
  }
}