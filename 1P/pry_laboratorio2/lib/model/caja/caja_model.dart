class CajaModel {
  final double totalDinero;
  final int totalBilletesMonedas;

  CajaModel({
    required this.totalDinero,
    required this.totalBilletesMonedas,
  });

  static CajaModel calcular(Map<double, int> ingresosCaja) {
    double sumaTotal = 0.0;
    int conteoFisico = 0;

    ingresosCaja.forEach((denominacion, cantidad) {
      sumaTotal += (denominacion * cantidad);
      conteoFisico += cantidad;
    });

    return CajaModel(
      totalDinero: sumaTotal,
      totalBilletesMonedas: conteoFisico,
    );
  }
}