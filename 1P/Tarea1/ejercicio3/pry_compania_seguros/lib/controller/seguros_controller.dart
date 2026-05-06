import '../model/seguros_model.dart';

class SegurosController {
  String valorAPagar(String ingreso) {
    //validacion para el monto
    if (ingreso.isEmpty) {
      return "Ingrese un monto";
    }

    final double monto;

    try {
      monto = double.parse(ingreso);
    } catch (e) {
      return 'Ingrese valores validos';
    }

    if (monto < 0.0) {
      return "Ingrese valores positivos en el monto";
    }

    //traer los calculos
    final double montoAPagar = SegurosModel.cuotaPagar(monto);

    return 'La cuota a pagar del cliente es de: \$$montoAPagar';
  }
}
