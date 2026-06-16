import 'package:flutter/material.dart';

import '../models/pedido.dart';
import '../services/pedido_service.dart';

class PedidoViewModel extends ChangeNotifier {
  final PedidoService _pedidoService = PedidoService();

  List<Pedido> pedidos = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> cargarPedidos() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      pedidos = await _pedidoService.obtenerPedidos();
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<Pedido?> obtenerPedidoPorId(int id) async {
    try {
      return await _pedidoService.obtenerPedidoPorId(id);
    } catch (error) {
      errorMessage = error.toString();
      notifyListeners();
      return null;
    }
  }

  Future<bool> crearPedido(Pedido pedido) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await _pedidoService.crearPedido(pedido);
      await cargarPedidos();

      return true;
    } catch (error) {
      errorMessage = error.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> actualizarPedido(int id, Pedido pedido) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await _pedidoService.actualizarPedido(id, pedido);
      await cargarPedidos();

      return true;
    } catch (error) {
      errorMessage = error.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> eliminarPedido(int id) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await _pedidoService.eliminarPedido(id);
      await cargarPedidos();

      return true;
    } catch (error) {
      errorMessage = error.toString();
      notifyListeners();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
