class ChoferModel {
  final String nombre;
  final double sueldoHora;
  final List<double> horasPorDia;
  final bool activo;
  final bool recibeBono;
  final String jornada;

  ChoferModel({
    required this.nombre,
    required this.sueldoHora,
    required this.horasPorDia,
    required this.activo,
    required this.recibeBono,
    required this.jornada,
  }) : assert(horasPorDia.length == 6);
}

class NominaChoferesModel {
  final List<ChoferModel> choferes;
  final double totalGeneral;
  final String choferMasHorasLunes;

  NominaChoferesModel({
    required this.choferes,
    required this.totalGeneral,
    required this.choferMasHorasLunes,
  });
}
