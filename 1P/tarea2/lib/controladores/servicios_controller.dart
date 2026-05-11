import '../modelos/servicios_model.dart';

class ServiciosController {
  String? validarCampos({
    required String nombreCliente,
    required String cedulaCliente,
    required String valorBaseTexto,
  }) {
    String nombre = nombreCliente.trim();
    String cedula = cedulaCliente.trim();
    String valorTexto = valorBaseTexto.trim();

    if (nombre.isEmpty) {
      return 'Ingrese el nombre del cliente.';
    }

    if (!_validarNombre(nombre)) {
      return 'El nombre solo debe contener letras, espacios, tildes y ñ. No ingrese números ni caracteres especiales.';
    }

    if (cedula.isEmpty) {
      return 'Ingrese la cédula del cliente.';
    }

    if (!RegExp(r'^\d+$').hasMatch(cedula)) {
      return 'La cédula solo debe contener números.';
    }

    if (cedula.length != 10) {
      return 'La cédula ecuatoriana debe tener exactamente 10 dígitos.';
    }

    if (!_validarCedulaEcuatoriana(cedula)) {
      return 'La cédula ingresada no es válida en Ecuador.';
    }

    if (valorTexto.isEmpty) {
      return 'Ingrese el valor base del servicio.';
    }

    if (!_validarNumeroDecimal(valorTexto)) {
      return 'El valor base solo debe contener números positivos. Puede usar punto o coma decimal.';
    }

    double valorBase = double.parse(valorTexto.replaceAll(',', '.'));

    if (valorBase <= 0) {
      return 'El valor base debe ser mayor que cero.';
    }

    return null;
  }

  ServiciosModel? procesar({
    required String nombreCliente,
    required String cedulaCliente,
    required String valorBaseTexto,
    required String tipoServicio,
    required String formaPago,
    required bool tieneMora,
    required bool servicioAdicional,
  }) {
    try {
      final error = validarCampos(
        nombreCliente: nombreCliente,
        cedulaCliente: cedulaCliente,
        valorBaseTexto: valorBaseTexto,
      );

      if (error != null) {
        return null;
      }

      String nombre = nombreCliente.trim();
      String cedula = cedulaCliente.trim();
      String valorTexto = valorBaseTexto.trim();

      double valorBase = double.parse(valorTexto.replaceAll(',', '.'));

      double tarifa = obtenerTarifa(tipoServicio);
      double subtotal = valorBase + tarifa;

      double descuento = 0;
      double recargo = 0;
      double adicional = 0;

      if (tieneMora) {
        recargo += subtotal * 0.10;
      }

      if (servicioAdicional) {
        adicional += 3.50;
      }

      if (formaPago == 'Efectivo') {
        descuento = subtotal * 0.05;
      } else if (formaPago == 'Tarjeta') {
        recargo += subtotal * 0.03;
      }

      double total = subtotal + recargo + adicional - descuento;

      return ServiciosModel(
        nombreCliente: nombre,
        cedulaCliente: cedula,
        tipoServicio: tipoServicio,
        formaPago: formaPago,
        valorBase: valorBase,
        tarifa: tarifa,
        subtotal: subtotal,
        descuento: descuento,
        recargo: recargo,
        adicional: adicional,
        total: total,
        tieneMora: tieneMora,
        servicioAdicional: servicioAdicional,
      );
    } catch (e) {
      return null;
    }
  }

  double obtenerTarifa(String tipoServicio) {
    switch (tipoServicio) {
      case 'Agua potable':
        return 0.35;
      case 'Energía eléctrica':
        return 0.10;
      case 'Internet y telefonía':
        return 1.00;
      case 'TV por cable y streaming':
        return 1.00;
      case 'Otros pagos frecuentes':
        return 0.50;
      default:
        return 0.00;
    }
  }

  bool _validarNombre(String nombre) {
    final RegExp regexNombre = RegExp(r"^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]+$");

    return regexNombre.hasMatch(nombre);
  }

  bool _validarNumeroDecimal(String valor) {
    final RegExp regexNumero = RegExp(r"^\d+([,.]\d{1,2})?$");

    return regexNumero.hasMatch(valor);
  }

  bool _validarCedulaEcuatoriana(String cedula) {
    if (cedula.length != 10) {
      return false;
    }

    if (!RegExp(r'^\d+$').hasMatch(cedula)) {
      return false;
    }

    int provincia = int.parse(cedula.substring(0, 2));

    if (provincia < 1 || provincia > 24) {
      return false;
    }

    int tercerDigito = int.parse(cedula[2]);

    if (tercerDigito >= 6) {
      return false;
    }

    List<int> coeficientes = [2, 1, 2, 1, 2, 1, 2, 1, 2];

    int suma = 0;

    for (int i = 0; i < 9; i++) {
      int digito = int.parse(cedula[i]);
      int resultado = digito * coeficientes[i];

      if (resultado >= 10) {
        resultado -= 9;
      }

      suma += resultado;
    }

    int digitoVerificador = int.parse(cedula[9]);
    int decenaSuperior = ((suma + 9) ~/ 10) * 10;
    int digitoCalculado = decenaSuperior - suma;

    if (digitoCalculado == 10) {
      digitoCalculado = 0;
    }

    return digitoCalculado == digitoVerificador;
  }
}
