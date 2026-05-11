import '../../model/escuela/escuela_model.dart';

class EscuelaController {

  EscuelaModel? procesar(List<String> inputsSalones) {
    try {
      if (inputsSalones.isEmpty) return null;
      List<List<int>> edadesProcesadas = [];
      for (String input in inputsSalones) {
        if (input.trim().isEmpty) {
          return null;
        }
        List<String> edadesStr = input.split(',');
        List<int> edadesSalon = [];

        for (String edadStr in edadesStr) {
          String edadLimpia = edadStr.trim();
          if (edadLimpia.isNotEmpty) {
            int edad = int.parse(edadLimpia);
            if (edad <= 0 || edad > 120) {
              return null;
            }
            edadesSalon.add(edad);
          }
        }
        if (edadesSalon.isEmpty) {
          return null;
        }
        edadesProcesadas.add(edadesSalon);
      }
      return EscuelaModel.calcular(edadesProcesadas);
    } catch (e) {
      return null;
    }
  }
}