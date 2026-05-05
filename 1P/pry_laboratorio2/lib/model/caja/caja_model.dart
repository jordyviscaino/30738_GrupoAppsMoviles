class CajaModel {
  final double totalDinero;
  final int totalBilletesMonedas; // Opcional, pero útil para mostrar más datos en la UI

  CajaModel({
    required this.totalDinero,
    required this.totalBilletesMonedas,
  });

  // Lógica matemática pura
  // Recibe un Map donde la key es la Denominación (ej. $20) y el value es la Cantidad (ej. 3)
  static CajaModel calcular(Map<double, int> ingresosCaja) {
    double sumaTotal = 0.0;
    int conteoFisico = 0;

    // Iteramos sobre cada entrada de la caja registradora
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