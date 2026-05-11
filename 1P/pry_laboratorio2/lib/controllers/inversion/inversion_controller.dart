import '../../model/inversion/inversion_model.dart';

class InversionController {
  InversionModel? procesar(String depositoStr, String aniosStr) {
    try {
      if (depositoStr.trim().isEmpty || aniosStr.trim().isEmpty) {
        return null;
      }

      double deposito = double.parse(depositoStr.trim().replaceAll(',', '.'));
      int anios = int.parse(aniosStr.trim());

      if (deposito <= 0 || anios <= 0) {
        return null;
      }

      return InversionModel.calcular(depositoMensual: deposito, anios: anios);
    } catch (e) {
      return null;
    }
  }
}
