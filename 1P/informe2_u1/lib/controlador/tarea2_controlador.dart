import '../modelo/tarea2_modelo.dart';

class Ejercicio1Controlador {
  String procesar(String compra) {
    try {
      final totalCompra = double.parse(compra);

      if (totalCompra < 0) return 'Ingresa un valor positivo';

      final iva = totalCompra * 0.15;
      double descuento = 0.0;
      if (totalCompra > 2000) {
        descuento = totalCompra * 0.20;
      }
      final subtotal = totalCompra + iva - descuento;
      final sueldoVendedor = subtotal * 0.05;

      final resultado = Ejercicio1Model(
        compra: totalCompra,
        iva: iva,
        descuento: descuento,
        subtotal: subtotal,
        total: subtotal,
        sueldoVendedor: sueldoVendedor,
      );

      return '''Factura de la venta:
    Compra: \$${resultado.compra.toStringAsFixed(2)}
    IVA (15%): \$${resultado.iva.toStringAsFixed(2)}
    Descuento: \$${resultado.descuento.toStringAsFixed(2)}
    Total a pagar: \$${resultado.total.toStringAsFixed(2)}

    Sueldo del vendedor (5% comisión): \$${resultado.sueldoVendedor.toStringAsFixed(2)}
    ''';
    } catch (e) {
      return 'Ingresa un número válido';
    }
  }
}

class Ejercicio2Controlador {
  String procesar(String depositoMensual, String anosTexto) {
    try {
      final deposito = double.parse(depositoMensual);
      final anos = int.parse(anosTexto);

      if (deposito <= 0) {
        return 'Ingresa un depósito mensual positivo';
      }

      if (anos <= 0) {
        return 'Ingresa un número de años positivo';
      }

      const interesAnual = 0.10;
      final totalesAnuales = <double>[];
      double totalAcumulado = 0.0;

      for (int ano = 1; ano <= anos; ano++) {
        totalAcumulado += deposito * 12;
        totalAcumulado = totalAcumulado * (1 + interesAnual);
        totalesAnuales.add(totalAcumulado);
      }

      final resultado = Ejercicio2Model(
        depositoMensual: deposito,
        anos: anos,
        interesAnual: interesAnual,
        totalesAnuales: totalesAnuales,
      );

      String mensaje = 'Inversión final por año:\n';
      for (int i = 0; i < resultado.totalesAnuales.length; i++) {
        mensaje +=
            'Año ${i + 1}: \$${resultado.totalesAnuales[i].toStringAsFixed(2)}\n';
      }
      mensaje +=
          '\nDepósito mensual: \$${resultado.depositoMensual.toStringAsFixed(2)}';
      mensaje +=
          '\nInterés anual: ${(resultado.interesAnual * 100).toStringAsFixed(0)}%';

      return mensaje;
    } catch (e) {
      return 'Ingresa números válidos';
    }
  }
}

class Ejercicio3Controlador {
  String procesar(String salonesTexto, List<String> edadesSalones) {
    try {
      final cantidadSalones = int.parse(salonesTexto);

      if (cantidadSalones <= 0) {
        return 'Ingresa una cantidad de salones válida';
      }

      if (edadesSalones.length != cantidadSalones) {
        return 'Debes ingresar las edades de todos los salones';
      }

      final promediosSalones = <double>[];
      double sumaPromedios = 0.0;

      for (int i = 0; i < edadesSalones.length; i++) {
        final textoSalon = edadesSalones[i].trim();
        if (textoSalon.isEmpty) {
          return 'Completa todas las edades de los salones';
        }

        final partes = textoSalon.split(',');
        double sumaSalon = 0.0;
        int cantidadEdades = 0;

        for (final parte in partes) {
          final textoEdad = parte.trim();
          if (textoEdad.isEmpty) {
            continue;
          }

          final edad = double.parse(textoEdad);
          if (edad < 0) {
            return 'Las edades deben ser positivas';
          }

          sumaSalon += edad;
          cantidadEdades += 1;
        }

        if (cantidadEdades == 0) {
          return 'Cada salón debe tener al menos una edad';
        }

        final promedioSalon = sumaSalon / cantidadEdades;
        promediosSalones.add(promedioSalon);
        sumaPromedios += promedioSalon;
      }

      final promedioEscuela = sumaPromedios / promediosSalones.length;

      final resultado = Ejercicio3Model(
        salones: cantidadSalones,
        promediosSalones: promediosSalones,
        promedioEscuela: promedioEscuela,
      );

      String mensaje = 'Promedio de cada salón:\n';
      for (int i = 0; i < resultado.promediosSalones.length; i++) {
        mensaje +=
            'Salón ${i + 1}: ${resultado.promediosSalones[i].toStringAsFixed(2)} años\n';
      }
      mensaje +=
          '\nPromedio de toda la escuela: ${resultado.promedioEscuela.toStringAsFixed(2)} años';

      return mensaje;
    } catch (e) {
      return 'Ingresa números válidos';
    }
  }
}

class Ejercicio4Controlador {
  String procesar(
    String billetesCantidadTexto,
    String valorBilletesTexto,
    String monedasCantidadTexto,
    String valorMonedasTexto,
  ) {
    try {
      final billetesCantidad = int.parse(billetesCantidadTexto);
      final valorBilletes = double.parse(valorBilletesTexto);
      final monedasCantidad = int.parse(monedasCantidadTexto);
      final valorMonedas = double.parse(valorMonedasTexto);

      if (billetesCantidad < 0 ||
          valorBilletes < 0 ||
          monedasCantidad < 0 ||
          valorMonedas < 0) {
        return 'Ingresa valores positivos';
      }

      final totalCaja =
          (billetesCantidad * valorBilletes) + (monedasCantidad * valorMonedas);

      final resultado = Ejercicio4Model(
        billetesCantidad: billetesCantidad,
        valorBilletes: valorBilletes,
        monedasCantidad: monedasCantidad,
        valorMonedas: valorMonedas,
        totalCaja: totalCaja,
      );

      final totalBilletes =
          resultado.billetesCantidad * resultado.valorBilletes;
      final totalMonedas = resultado.monedasCantidad * resultado.valorMonedas;

      return '''Total de la caja registradora:
    Billetes: ${resultado.billetesCantidad} x \$${resultado.valorBilletes.toStringAsFixed(2)} = \$${totalBilletes.toStringAsFixed(2)}
    Monedas: ${resultado.monedasCantidad} x \$${resultado.valorMonedas.toStringAsFixed(2)} = \$${totalMonedas.toStringAsFixed(2)}

    Total general: \$${resultado.totalCaja.toStringAsFixed(2)}''';
    } catch (e) {
      return 'Ingresa números válidos';
    }
  }
}

class Ejercicio5Controlador {
  String procesar(String cantidadVentasTexto, List<String> ventasTexto) {
    try {
      final cantidadVentas = int.parse(cantidadVentasTexto);

      if (cantidadVentas <= 0) {
        return 'Ingresa una cantidad de ventas válida';
      }

      if (ventasTexto.length != cantidadVentas) {
        return 'Debes ingresar el monto de todas las ventas';
      }

      final ventasPorCategoria = [0, 0];
      final montosPorCategoria = [0.0, 0.0];
      double montoGlobal = 0.0;

      int clasificarVenta(double monto) {
        if (monto <= 10000) return 0;
        if (monto < 20000) return 1;
        return -1;
      }

      for (int i = 0; i < ventasTexto.length; i++) {
        final textoVenta = ventasTexto[i].trim();
        if (textoVenta.isEmpty) {
          return 'Completa todos los montos de ventas';
        }

        final montoVenta = double.parse(textoVenta);
        if (montoVenta < 0) {
          return 'Los montos deben ser positivos';
        }

        montoGlobal += montoVenta;

        final cat = clasificarVenta(montoVenta);
        if (cat == 0) {
          ventasPorCategoria[0] = ventasPorCategoria[0] + 1;
          montosPorCategoria[0] = montosPorCategoria[0] + montoVenta;
        } else if (cat == 1) {
          ventasPorCategoria[1] = ventasPorCategoria[1] + 1;
          montosPorCategoria[1] = montosPorCategoria[1] + montoVenta;
        }
      }

      final resultado = Ejercicio5Model(
        cantidadVentas: cantidadVentas,
        ventasPorCategoria: ventasPorCategoria,
        montosPorCategoria: montosPorCategoria,
        montoGlobal: montoGlobal,
      );

      return '''Resumen de ventas:
Ventas de 10,000 o menos: ${resultado.ventasPorCategoria[0]}
Monto de esas ventas: \$${resultado.montosPorCategoria[0].toStringAsFixed(2)}

Ventas de más de 10,000 y menos de 20,000: ${resultado.ventasPorCategoria[1]}
Monto de esas ventas: \$${resultado.montosPorCategoria[1].toStringAsFixed(2)}

Monto global: \$${resultado.montoGlobal.toStringAsFixed(2)}''';
    } catch (e) {
      return 'Ingresa números válidos';
    }
  }
}

class SaludoControlador {
  static String obtenerSaludo() {
    final hora = DateTime.now().hour;
    if (hora >= 6 && hora < 12) {
      return 'Buenos días';
    } else if (hora >= 12 && hora < 18) {
      return 'Buenas tardes';
    } else {
      return 'Buenas noches';
    }
  }
}
