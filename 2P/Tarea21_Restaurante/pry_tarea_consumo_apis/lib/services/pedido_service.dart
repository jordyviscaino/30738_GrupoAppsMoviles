import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core/constants/api_constants.dart';
import '../models/pedido.dart';

class PedidoService {
  Future<List<Pedido>> obtenerPedidos() async {
    final response = await http.get(Uri.parse(ApiConstants.pedidos));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Pedido.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los pedidos');
    }
  }

  Future<Pedido> obtenerPedidoPorId(int id) async {
    final response = await http.get(Uri.parse('${ApiConstants.pedidos}/$id'));

    if (response.statusCode == 200) {
      return Pedido.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener el pedido');
    }
  }

  Future<void> crearPedido(Pedido pedido) async {
    final response = await http.post(
      Uri.parse(ApiConstants.pedidos),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pedido.toJson()),
    );

    if (response.statusCode != 201) {
      final data = jsonDecode(response.body);
      throw Exception(data['error'] ?? 'Error al crear el pedido');
    }
  }

  Future<void> actualizarPedido(int id, Pedido pedido) async {
    final response = await http.put(
      Uri.parse('${ApiConstants.pedidos}/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pedido.toJson()),
    );

    if (response.statusCode != 200) {
      final data = jsonDecode(response.body);
      throw Exception(data['error'] ?? 'Error al actualizar el pedido');
    }
  }

  Future<void> eliminarPedido(int id) async {
    final response = await http.delete(
      Uri.parse('${ApiConstants.pedidos}/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el pedido');
    }
  }
}
