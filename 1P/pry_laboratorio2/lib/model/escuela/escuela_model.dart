class EscuelaModel {
  final List<double> promediosSalones;
  final double promedioGlobal;

  EscuelaModel({
    required this.promediosSalones,
    required this.promedioGlobal,
  });

  // Lógica pura de cálculo
  static EscuelaModel calcular(List<List<int>> edadesPorSalon) {
    List<double> listaPromedios = [];
    int sumaTotalEdadesGlobal = 0;
    int totalAlumnosGlobal = 0;

    for (var salon in edadesPorSalon) {
      if (salon.isEmpty) {
        listaPromedios.add(0.0);
        continue;
      }

      // Calcular promedio del salón actual
      int sumaSalon = salon.reduce((a, b) => a + b);
      double promedioSalon = sumaSalon / salon.length;
      listaPromedios.add(promedioSalon);

      // Acumular para el promedio global
      sumaTotalEdadesGlobal += sumaSalon;
      totalAlumnosGlobal += salon.length;
    }

    // Calcular promedio global de toda la escuela
    double global = totalAlumnosGlobal > 0
        ? sumaTotalEdadesGlobal / totalAlumnosGlobal
        : 0.0;

    return EscuelaModel(
      promediosSalones: listaPromedios,
      promedioGlobal: global,
    );
  }
}