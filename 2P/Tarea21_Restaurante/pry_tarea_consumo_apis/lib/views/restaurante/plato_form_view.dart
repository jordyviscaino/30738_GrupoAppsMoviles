import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/plato.dart';
import '../../viewmodels/plato_viewmodel.dart';

class PlatoFormView extends StatefulWidget {
  final Plato? plato;

  const PlatoFormView({super.key, this.plato});

  @override
  State<PlatoFormView> createState() => _PlatoFormViewState();
}

class _PlatoFormViewState extends State<PlatoFormView> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  late TextEditingController _precioController;

  bool _disponible = true;

  bool get _esEdicion => widget.plato != null;

  @override
  void initState() {
    super.initState();

    _nombreController = TextEditingController(text: widget.plato?.nombre ?? '');

    _descripcionController = TextEditingController(
      text: widget.plato?.descripcion ?? '',
    );

    _precioController = TextEditingController(
      text: widget.plato?.precio.toString() ?? '',
    );

    _disponible = widget.plato?.disponible ?? true;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _precioController.dispose();
    super.dispose();
  }

  Future<void> _guardarPlato() async {
    if (!_formKey.currentState!.validate()) return;

    final viewModel = context.read<PlatoViewModel>();

    final plato = Plato(
      nombre: _nombreController.text.trim(),
      descripcion: _descripcionController.text.trim(),
      precio: double.parse(_precioController.text.trim()),
      disponible: _disponible,
    );

    bool ok;

    if (_esEdicion) {
      ok = await viewModel.actualizarPlato(widget.plato!.id!, plato);
    } else {
      ok = await viewModel.crearPlato(plato);
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? _esEdicion
                    ? 'Plato actualizado correctamente'
                    : 'Plato creado correctamente'
              : viewModel.errorMessage ?? 'No se pudo guardar el plato',
        ),
      ),
    );

    if (ok) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PlatoViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(_esEdicion ? 'Editar plato' : 'Nuevo plato'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del plato',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.restaurant),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese el nombre del plato';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: _precioController,
                decoration: const InputDecoration(
                  labelText: 'Precio',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese el precio';
                  }

                  final precio = double.tryParse(value.trim());

                  if (precio == null) {
                    return 'Ingrese un número válido';
                  }

                  if (precio <= 0) {
                    return 'El precio debe ser mayor a 0';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 14),

              SwitchListTile(
                value: _disponible,
                title: const Text('Disponible'),
                subtitle: Text(
                  _disponible
                      ? 'El plato puede ser pedido'
                      : 'El plato no estará disponible',
                ),
                activeColor: Colors.deepOrange,
                onChanged: (value) {
                  setState(() {
                    _disponible = value;
                  });
                },
              ),

              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: viewModel.isLoading ? null : _guardarPlato,
                  icon: const Icon(Icons.save),
                  label: Text(
                    viewModel.isLoading
                        ? 'Guardando...'
                        : _esEdicion
                        ? 'Actualizar plato'
                        : 'Crear plato',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
