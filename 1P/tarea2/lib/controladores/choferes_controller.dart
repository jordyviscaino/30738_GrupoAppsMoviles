import '../modelos/choferes_model.dart';

class ChoferesController {
  String? validarChofer({
    required String nombre,
    required String sueldoHoraTexto,
    required List<String> horasTexto,
  }) {
    final String nombreTrim = nombre.trim();
    final String sueldoTrim = sueldoHoraTexto.trim();

    if (nombreTrim.isEmpty) {
      return 'Ingrese el nombre del chofer.';
    }

    if (!_validarNombre(nombreTrim)) {
      return 'El nombre solo debe contener letras, espacios y tildes. No ingrese números ni caracteres especiales.';
    }

    if (sueldoTrim.isEmpty) {
      return 'Ingrese el sueldo por hora.';
    }

    if (!_validarNumeroDecimal(sueldoTrim)) {
      return 'El sueldo por hora solo debe contener números positivos. Puede usar punto o coma decimal.';
    }

    final double sueldo = double.parse(sueldoTrim.replaceAll(',', '.'));
    if (sueldo <= 0) {
      return 'El sueldo por hora debe ser mayor que cero.';
    }

    if (horasTexto.length != 6) {
      return 'Ingrese las horas trabajadas para los seis días de la semana.';
    }

    for (final horaTexto in horasTexto) {
      final String horaTrim = horaTexto.trim();
      if (horaTrim.isEmpty) {
        return 'Ingrese las horas trabajadas para todos los días.';
      }

      if (!_validarNumeroDecimal(horaTrim)) {
        return 'Las horas trabajadas deben ser números válidos y mayores o iguales a cero.';
      }

      final double valor = double.parse(horaTrim.replaceAll(',', '.'));
      if (valor < 0) {
        return 'Las horas no pueden ser negativas.';
      }
      if (valor > 24) {
        return 'Las horas no pueden superar 24 en un día.';
      }
    }

    return null;
  }

  ChoferModel crearChofer({
    required String nombre,
    required String sueldoHoraTexto,
    required List<String> horasTexto,
    required bool activo,
    required bool recibeBono,
    required String jornada,
  }) {
    final double sueldoHora = double.parse(
      sueldoHoraTexto.trim().replaceAll(',', '.'),
    );
    final List<double> horasPorDia = horasTexto
        .map((horaTexto) => double.parse(horaTexto.trim().replaceAll(',', '.')))
        .toList();

    return ChoferModel(
      nombre: nombre.trim(),
      sueldoHora: sueldoHora,
      horasPorDia: horasPorDia,
      activo: activo,
      recibeBono: recibeBono,
      jornada: jornada,
    );
  }

  double calcularHorasTotales(ChoferModel chofer) {
    double horasTotales = 0.0;
    for (final hora in chofer.horasPorDia) {
      horasTotales += hora;
    }
    return horasTotales;
  }

  double calcularBono(ChoferModel chofer) {
    if (chofer.recibeBono) {
      final double horasTotales = calcularHorasTotales(chofer);
      return horasTotales * chofer.sueldoHora * 0.10;
    }

    return 0.0;
  }

  double calcularSueldoSemanal(ChoferModel chofer) {
    final double horasTotales = calcularHorasTotales(chofer);
    final double bono = calcularBono(chofer);
    return horasTotales * chofer.sueldoHora + bono;
  }

  ChoferModel obtenerChoferMasHorasLunes(List<ChoferModel> choferes) {
    ChoferModel choferMasHoras = choferes.first;

    for (final chofer in choferes) {
      if (chofer.horasPorDia[0] > choferMasHoras.horasPorDia[0]) {
        choferMasHoras = chofer;
      }
    }

    return choferMasHoras;
  }

  NominaChoferesModel calcularNomina(List<ChoferModel> choferes) {
    double totalGeneral = 0.0;
    for (final chofer in choferes) {
      totalGeneral += calcularSueldoSemanal(chofer);
    }

    final ChoferModel choferMasHorasLunes = obtenerChoferMasHorasLunes(
      choferes,
    );

    return NominaChoferesModel(
      choferes: choferes,
      totalGeneral: totalGeneral,
      choferMasHorasLunes: choferMasHorasLunes.nombre,
    );
  }

  bool _validarNombre(String nombre) {
    final RegExp regexNombre = RegExp(r"^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]+$");
    return regexNombre.hasMatch(nombre);
  }

  bool _validarNumeroDecimal(String valor) {
    final RegExp regexNumero = RegExp(r'^\d+([,.]\d{1,2})?$');
    return regexNumero.hasMatch(valor);
  }
}
