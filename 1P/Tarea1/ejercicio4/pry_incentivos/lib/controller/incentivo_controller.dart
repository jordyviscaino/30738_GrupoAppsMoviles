import 'package:pry_inventivos/model/incentivo_model.dart';

class IncentivoController {
  String incentivoUnidad(
    String lunes,
    String martes,
    String miercoles,
    String jueves,
    String viernes,
    String sabado,
  ) {
    //validaciones
    if ([
      lunes,
      martes,
      miercoles,
      jueves,
      viernes,
      sabado,
    ].any((e) => e.isEmpty)) {
      return 'Rellenar todos los campos';
    }

    final int lun, mart, mier, juev, vier, sab;

    try {
      lun = int.parse(lunes);
      mart = int.parse(martes);
      mier = int.parse(miercoles);
      juev = int.parse(jueves);
      vier = int.parse(viernes);
      sab = int.parse(sabado);
    } catch (e) {
      return 'Ingrese valores validos';
    }

    if (lun < 0 || mart < 0 || mier < 0 || juev < 0 || vier < 0 || sab < 0) {
      return 'Ingrese valores positivos';
    }
    //calculos
    final bool calculo = IncentivoModel.calculoUnidades(
      lun,
      mart,
      mier,
      juev,
      vier,
      sab,
    );
    return (calculo == true) ? 'Incentivo adicional' : 'No cumple el mínimo';
  }
}
