class ServiciosModel {
  final String nombreCliente;
  final String cedulaCliente;
  final String tipoServicio;
  final String formaPago;
  final double valorBase;
  final double tarifa;
  final double subtotal;
  final double descuento;
  final double recargo;
  final double adicional;
  final double total;
  final bool tieneMora;
  final bool servicioAdicional;

  ServiciosModel({
    required this.nombreCliente,
    required this.cedulaCliente,
    required this.tipoServicio,
    required this.formaPago,
    required this.valorBase,
    required this.tarifa,
    required this.subtotal,
    required this.descuento,
    required this.recargo,
    required this.adicional,
    required this.total,
    required this.tieneMora,
    required this.servicioAdicional,
  });
}
