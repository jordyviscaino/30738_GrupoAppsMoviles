import '../../model/caja/caja_model.dart';
class CajaController {

  // Recibe los datos crudos desde la vista
  CajaModel? procesar(List<Map<String, String>> inputsCaja) {
    try {
      if (inputsCaja.isEmpty) return null;

      Map<double, int> ingresosProcesados = {};

      for (var input in inputsCaja) {
        String valorStr = input['valor']?.trim() ?? '';
        String cantidadStr = input['cantidad']?.trim() ?? '';

        // Si el usuario dejó la fila completamente vacía, la ignoramos y pasamos a la siguiente
        if (valorStr.isEmpty && cantidadStr.isEmpty) {
          continue;
        }

        // Reemplazamos comas por puntos para los decimales (ej. monedas de "0,50" -> "0.50")
        double valor = double.parse(valorStr.replaceAll(',', '.'));
        int cantidad = int.parse(cantidadStr);

        // Validaciones de seguridad:
        // No existen billetes de valor negativo o 0, ni cantidades negativas
        if (valor <= 0 || cantidad <= 0) {
          return null;
        }

        // Si el usuario ingresa la misma denominación en dos filas distintas (ej. dos filas de billetes de 20),
        // acumulamos la cantidad en lugar de sobrescribirla.
        if (ingresosProcesados.containsKey(valor)) {
          ingresosProcesados[valor] = ingresosProcesados[valor]! + cantidad;
        } else {
          ingresosProcesados[valor] = cantidad;
        }
      }

      // Si después de ignorar filas vacías el mapa quedó vacío, es un error
      if (ingresosProcesados.isEmpty) {
        return null;
      }

      // Enviamos el mapa validado y limpio al Modelo
      return CajaModel.calcular(ingresosProcesados);

    } catch (e) {
      // Capturamos cualquier error (ej. si escriben letras en vez de números)
      return null;
    }
  }
}