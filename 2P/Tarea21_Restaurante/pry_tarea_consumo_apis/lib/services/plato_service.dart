import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core/constants/api_constants.dart';
import '../models/plato.dart';

class PlatoService {
  Future<List<Plato>> obtenerPlatos() async {
    final response = await http.get(Uri.parse(ApiConstants.platos));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Plato.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los platos');
    }
  }

  Future<Plato> obtenerPlatoPorId(int id) async {
    final response = await http.get(Uri.parse('${ApiConstants.platos}/$id'));

    if (response.statusCode == 200) {
      return Plato.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener el plato');
    }
  }

  Future<void> crearPlato(Plato plato) async {
    final response = await http.post(
      Uri.parse(ApiConstants.platos),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(plato.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear el plato');
    }
  }

  Future<void> actualizarPlato(int id, Plato plato) async {
    final response = await http.put(
      Uri.parse('${ApiConstants.platos}/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(plato.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el plato');
    }
  }

  Future<void> eliminarPlato(int id) async {
    final response = await http.delete(Uri.parse('${ApiConstants.platos}/$id'));

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el plato');
    }
  }
}
