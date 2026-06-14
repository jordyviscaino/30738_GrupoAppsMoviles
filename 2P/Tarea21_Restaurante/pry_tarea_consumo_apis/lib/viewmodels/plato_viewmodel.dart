import 'package:flutter/material.dart';

import '../models/plato.dart';
import '../services/plato_service.dart';

class PlatoViewModel extends ChangeNotifier {
  final PlatoService _platoService = PlatoService();

  List<Plato> platos = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> cargarPlatos() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      platos = await _platoService.obtenerPlatos();
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<Plato?> obtenerPlatoPorId(int id) async {
    try {
      return await _platoService.obtenerPlatoPorId(id);
    } catch (error) {
      errorMessage = error.toString();
      notifyListeners();
      return null;
    }
  }

  Future<bool> crearPlato(Plato plato) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await _platoService.crearPlato(plato);
      await cargarPlatos();

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

  Future<bool> actualizarPlato(int id, Plato plato) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await _platoService.actualizarPlato(id, plato);
      await cargarPlatos();

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

  Future<bool> eliminarPlato(int id) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await _platoService.eliminarPlato(id);
      await cargarPlatos();

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
