import '../../model/escuela/escuela_model.dart';

class EscuelaController {

  EscuelaModel? procesar(List<String> inputsSalones) {
    try {
      if (inputsSalones.isEmpty) return null;

      List<List<int>> edadesProcesadas = [];

      for (String input in inputsSalones) {
        // 1. NUEVA VALIDACIÓN: Si el TextField del salón está completamente vacío
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

        // 2. NUEVA VALIDACIÓN: Asegurarnos de que el salón sí tenga alumnos válidos
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