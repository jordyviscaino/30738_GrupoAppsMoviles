class Plato {
  final int? id;
  final String nombre;
  final String? descripcion;
  final double precio;
  final bool disponible;

  Plato({
    this.id,
    required this.nombre,
    this.descripcion,
    required this.precio,
    required this.disponible,
  });

  factory Plato.fromJson(Map<String, dynamic> json) {
    return Plato(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precio: double.parse(json['precio'].toString()),
      disponible: json['disponible'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'disponible': disponible,
    };
  }
}
