/* 
Ejercicio No.1:
Indicaciones al ejercicio en clase calcular el iva de 15%, si las compras superan 2000$ al cliente se agregar un descuento del 20%, mostrar tanto el sueldo a ganar del vendedor y la factura de la venta de productos. 
 */

class Ejercicio1Model {
  final double compra;
  final double iva;
  final double descuento;
  final double subtotal;
  final double total;
  final double sueldoVendedor;

  Ejercicio1Model({
    required this.compra,
    required this.iva,
    required this.descuento,
    required this.subtotal,
    required this.total,
    required this.sueldoVendedor,
  });
}

/* 
Ejercicio No.2:

Un cliente de un banco deposita equis cantidad de pesos cada mes en una cuenta de ahorros. La cuenta percibe un interés fijo durante un año de 10 % anual. Realice un algoritmo para determinar el total de la inversión final de cada año en los próximos N años. 

 */
class Ejercicio2Model {
  final double depositoMensual;
  final int anos;
  final double interesAnual;
  final List<double> totalesAnuales;

  Ejercicio2Model({
    required this.depositoMensual,
    required this.anos,
    required this.interesAnual,
    required this.totalesAnuales,
  });
}

/* 
Ejercicio No.3:
Los directivos de equis escuela requieren determinar cuál es la edad promedio de cada uno de los M salones y cuál es la edad promedio de toda la escuela. 

 */
class Ejercicio3Model {
  final int salones;
  final List<double> promediosSalones;
  final double promedioEscuela;

  Ejercicio3Model({
    required this.salones,
    required this.promediosSalones,
    required this.promedioEscuela,
  });
}

/* 
Ejercicio No.4:
Se desea saber el total de una caja registradora de un almacén, se conoce el número de billetes y monedas, así como su valor. Realice un algoritmo para determinar el total. 
 */
class Ejercicio4Model {
  final int billetesCantidad;
  final double valorBilletes;
  final int monedasCantidad;
  final double valorMonedas;
  final double totalCaja;

  Ejercicio4Model({
    required this.billetesCantidad,
    required this.valorBilletes,
    required this.monedasCantidad,
    required this.valorMonedas,
    required this.totalCaja,
  });
}

/* 
Ejercicio No.5: Un vendedor ha realizado N ventas y desea saber cuántas fueron por 10,000 o menos, cuántas fueron por más de 10,000 pero por menos de 20,000, y cuánto fue el monto de las ventas de cada una y el monto global. Realice un algoritmo para determinar los totales. 
 */
class Ejercicio5Model {
  final int cantidadVentas;
  final List<int> ventasPorCategoria;
  final List<double> montosPorCategoria;
  final double montoGlobal;

  Ejercicio5Model({
    required this.cantidadVentas,
    required this.ventasPorCategoria,
    required this.montosPorCategoria,
    required this.montoGlobal,
  });
}
