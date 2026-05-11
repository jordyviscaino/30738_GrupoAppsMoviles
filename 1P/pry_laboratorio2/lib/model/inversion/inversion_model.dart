class InversionModel {
  final double depositoMensual;
  final int anios;
  final List<double> totalesPorAnio;

  InversionModel({
    required this.depositoMensual,
    required this.anios,
    required this.totalesPorAnio,
  });

  static InversionModel calcular({
    required double depositoMensual,
    required int anios,
  }) {
    const double interesAnual = 0.10;
    double total = 0.0;
    List<double> resultados = [];

    for (int anio = 1; anio <= anios; anio++) {
      total += depositoMensual * 12;
      total += total * interesAnual;
      resultados.add(total);
    }

    return InversionModel(
      depositoMensual: depositoMensual,
      anios: anios,
      totalesPorAnio: resultados,
    );
  }
}
