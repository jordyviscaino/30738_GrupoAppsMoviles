class EscuelaModel {
  final List<double> promediosSalones;
  final double promedioGlobal;
  EscuelaModel({
    required this.promediosSalones,
    required this.promedioGlobal,
  });
  static EscuelaModel calcular(List<List<int>> edadesPorSalon) {
    List<double> listaPromedios = [];
    int sumaTotalEdadesGlobal = 0;
    int totalAlumnosGlobal = 0;

    for (var salon in edadesPorSalon) {
      if (salon.isEmpty) {
        listaPromedios.add(0.0);
        continue;
      }
      int sumaSalon = salon.reduce((a, b) => a + b);
      double promedioSalon = sumaSalon / salon.length;
      listaPromedios.add(promedioSalon);
      sumaTotalEdadesGlobal += sumaSalon;
      totalAlumnosGlobal += salon.length;
    }
    double global = totalAlumnosGlobal > 0
        ? sumaTotalEdadesGlobal / totalAlumnosGlobal
        : 0.0;
    return EscuelaModel(
      promediosSalones: listaPromedios,
      promedioGlobal: global,
    );
  }
}