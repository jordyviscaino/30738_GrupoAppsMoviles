class Pedido {
  final int? id;
  final String cliente;
  final String? fecha;
  final int cantidad;
  final double? total;
  final int platoId;
  final String? platoNombre;
  final double? platoPrecio;

  Pedido({
    this.id,
    required this.cliente,
    this.fecha,
    required this.cantidad,
    this.total,
    required this.platoId,
    this.platoNombre,
    this.platoPrecio,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'],
      cliente: json['cliente'],
      fecha: json['fecha'],
      cantidad: json['cantidad'],
      total: json['total'] != null
          ? double.parse(json['total'].toString())
          : null,
      platoId: json['plato_id'],
      platoNombre: json['plato_nombre'],
      platoPrecio: json['plato_precio'] != null
          ? double.parse(json['plato_precio'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'cliente': cliente, 'cantidad': cantidad, 'plato_id': platoId};
  }
}
