import '../../model/caja/caja_model.dart';
class CajaController {
  CajaModel? procesar(List<Map<String, String>> inputsCaja) {
    try {
      if (inputsCaja.isEmpty) return null;

      Map<double, int> ingresosProcesados = {};

      for (var input in inputsCaja) {
        String valorStr = input['valor']?.trim() ?? '';
        String cantidadStr = input['cantidad']?.trim() ?? '';
        if (valorStr.isEmpty && cantidadStr.isEmpty) {
          continue;
        }
        double valor = double.parse(valorStr.replaceAll(',', '.'));
        int cantidad = int.parse(cantidadStr);
        if (valor <= 0 || cantidad <= 0) {
          return null;
        }
        if (ingresosProcesados.containsKey(valor)) {
          ingresosProcesados[valor] = ingresosProcesados[valor]! + cantidad;
        } else {
          ingresosProcesados[valor] = cantidad;
        }
      }
      if (ingresosProcesados.isEmpty) {
        return null;
      }
      return CajaModel.calcular(ingresosProcesados);

    } catch (e) {
      return null;
    }
  }
}