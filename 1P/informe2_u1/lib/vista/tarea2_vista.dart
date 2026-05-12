import 'package:flutter/material.dart';
import '../controlador/tarea2_controlador.dart';

/* -- Átomos -- */
/* Label */
class Label extends StatelessWidget {
  final String texto;
  const Label(this.texto, {super.key});

  @override
  Widget build(BuildContext context) =>
      Text(texto, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
}

/* Button */
class PryButton extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;
  const PryButton({super.key, required this.texto, required this.onPressed});

  @override
  Widget build(BuildContext context) =>
      ElevatedButton(onPressed: onPressed, child: Text(texto));
}

class PurchaseField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  const PurchaseField({
    super.key,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    decoration: InputDecoration(hintText: hint, border: OutlineInputBorder()),
  );
}

class CardEjercicio1 extends StatefulWidget {
  const CardEjercicio1({super.key});

  @override
  State<CardEjercicio1> createState() => _CardEjercicio1State();
}

class _CardEjercicio1State extends State<CardEjercicio1> {
  final compraController = TextEditingController();
  String resultado = '';
  final controlador = Ejercicio1Controlador();

  void _calcular() {
    setState(() {
      resultado = controlador.procesar(compraController.text);
    });
  }

  void _reiniciar() {
    setState(() {
      compraController.clear();
      resultado = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 245, 206, 248),
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Label('Factura de Venta - IVA y Descuento'),
            SizedBox(height: 12),
            PurchaseField(
              hint: 'Total de la compra',
              controller: compraController,
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: PryButton(texto: 'Calcular', onPressed: _calcular),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: PryButton(texto: 'Reiniciar', onPressed: _reiniciar),
                ),
              ],
            ),
            SizedBox(height: 12),
            if (resultado.isNotEmpty)
              Text(resultado, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    compraController.dispose();
    super.dispose();
  }
}

class CardEjercicio2 extends StatefulWidget {
  const CardEjercicio2({super.key});

  @override
  State<CardEjercicio2> createState() => _CardEjercicio2State();
}

class _CardEjercicio2State extends State<CardEjercicio2> {
  final depositoController = TextEditingController();
  final anosController = TextEditingController();
  String resultado = '';
  final controlador = Ejercicio2Controlador();

  void _calcular() {
    setState(() {
      resultado = controlador.procesar(
        depositoController.text,
        anosController.text,
      );
    });
  }

  void _reiniciar() {
    setState(() {
      depositoController.clear();
      anosController.clear();
      resultado = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 245, 206, 248),
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Label('Inversión bancaria anual'),
            SizedBox(height: 12),
            PurchaseField(
              hint: 'Depósito mensual',
              controller: depositoController,
            ),
            SizedBox(height: 10),
            PurchaseField(hint: 'N de años', controller: anosController),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: PryButton(texto: 'Calcular', onPressed: _calcular),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: PryButton(texto: 'Reiniciar', onPressed: _reiniciar),
                ),
              ],
            ),
            SizedBox(height: 12),
            if (resultado.isNotEmpty)
              Text(resultado, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    depositoController.dispose();
    anosController.dispose();
    super.dispose();
  }
}

class CardEjercicio3 extends StatefulWidget {
  const CardEjercicio3({super.key});

  @override
  State<CardEjercicio3> createState() => _CardEjercicio3State();
}

class _CardEjercicio3State extends State<CardEjercicio3> {
  final salonesController = TextEditingController();
  final controlador = Ejercicio3Controlador();
  final List<TextEditingController> salonControllers = [];
  String resultado = '';
  int cantidadSalones = 0;

  void _generarCampos() {
    final cantidad = int.tryParse(salonesController.text);

    if (cantidad == null) {
      setState(() {
        resultado = 'Ingresa una cantidad válida de salones';
      });
      return;
    }

    if (cantidad <= 0) {
      setState(() {
        resultado = 'Ingresa una cantidad de salones mayor que cero';
      });
      return;
    }

    setState(() {
      cantidadSalones = cantidad;
      resultado = '';

      for (final controller in salonControllers) {
        controller.dispose();
      }
      salonControllers.clear();

      for (int i = 0; i < cantidadSalones; i++) {
        salonControllers.add(TextEditingController());
      }
    });
  }

  void _calcular() {
    final edadesSalones = <String>[];
    for (final controller in salonControllers) {
      edadesSalones.add(controller.text);
    }

    setState(() {
      resultado = controlador.procesar(salonesController.text, edadesSalones);
    });
  }

  void _reiniciar() {
    setState(() {
      salonesController.clear();
      resultado = '';
      cantidadSalones = 0;

      for (final controller in salonControllers) {
        controller.dispose();
      }
      salonControllers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 245, 206, 248),
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Label('Promedio de edades en la escuela'),
            SizedBox(height: 12),
            PurchaseField(
              hint: 'Cantidad de salones M',
              controller: salonesController,
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: PryButton(
                    texto: 'Generar salones',
                    onPressed: _generarCampos,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: PryButton(texto: 'Reiniciar', onPressed: _reiniciar),
                ),
              ],
            ),
            SizedBox(height: 12),
            if (cantidadSalones > 0)
              Column(
                children: [
                  for (int i = 0; i < salonControllers.length; i++) ...[
                    PurchaseField(
                      hint: 'Edades del salón ${i + 1} separadas por coma',
                      controller: salonControllers[i],
                    ),
                    SizedBox(height: 10),
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: PryButton(
                          texto: 'Calcular promedio',
                          onPressed: _calcular,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            SizedBox(height: 12),
            if (resultado.isNotEmpty)
              Text(resultado, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    salonesController.dispose();
    for (final controller in salonControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

class CardEjercicio4 extends StatefulWidget {
  const CardEjercicio4({super.key});

  @override
  State<CardEjercicio4> createState() => _CardEjercicio4State();
}

class _CardEjercicio4State extends State<CardEjercicio4> {
  final billetesCantidadController = TextEditingController();
  final valorBilletesController = TextEditingController();
  final monedasCantidadController = TextEditingController();
  final valorMonedasController = TextEditingController();
  String resultado = '';
  final controlador = Ejercicio4Controlador();

  void _calcular() {
    setState(() {
      resultado = controlador.procesar(
        billetesCantidadController.text,
        valorBilletesController.text,
        monedasCantidadController.text,
        valorMonedasController.text,
      );
    });
  }

  void _reiniciar() {
    setState(() {
      billetesCantidadController.clear();
      valorBilletesController.clear();
      monedasCantidadController.clear();
      valorMonedasController.clear();
      resultado = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 245, 206, 248),
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Label('Total de caja registradora'),
            SizedBox(height: 12),
            PurchaseField(
              hint: 'Cantidad de billetes',
              controller: billetesCantidadController,
            ),
            SizedBox(height: 10),
            PurchaseField(
              hint: 'Valor de cada billete',
              controller: valorBilletesController,
            ),
            SizedBox(height: 10),
            PurchaseField(
              hint: 'Cantidad de monedas',
              controller: monedasCantidadController,
            ),
            SizedBox(height: 10),
            PurchaseField(
              hint: 'Valor de cada moneda',
              controller: valorMonedasController,
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: PryButton(texto: 'Calcular', onPressed: _calcular),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: PryButton(texto: 'Reiniciar', onPressed: _reiniciar),
                ),
              ],
            ),
            SizedBox(height: 12),
            if (resultado.isNotEmpty)
              Text(resultado, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    billetesCantidadController.dispose();
    valorBilletesController.dispose();
    monedasCantidadController.dispose();
    valorMonedasController.dispose();
    super.dispose();
  }
}

class CardEjercicio5 extends StatefulWidget {
  const CardEjercicio5({super.key});

  @override
  State<CardEjercicio5> createState() => _CardEjercicio5State();
}

class _CardEjercicio5State extends State<CardEjercicio5> {
  final cantidadVentasController = TextEditingController();
  final controlador = Ejercicio5Controlador();
  final List<TextEditingController> ventaControllers = [];
  String resultado = '';
  int cantidadVentas = 0;

  void _generarCampos() {
    final cantidad = int.tryParse(cantidadVentasController.text);

    if (cantidad == null) {
      setState(() {
        resultado = 'Ingresa una cantidad válida de ventas';
      });
      return;
    }

    if (cantidad <= 0) {
      setState(() {
        resultado = 'Ingresa una cantidad de ventas mayor que cero';
      });
      return;
    }

    setState(() {
      cantidadVentas = cantidad;
      resultado = '';

      for (final controller in ventaControllers) {
        controller.dispose();
      }
      ventaControllers.clear();

      for (int i = 0; i < cantidadVentas; i++) {
        ventaControllers.add(TextEditingController());
      }
    });
  }

  void _calcular() {
    final ventasTexto = <String>[];
    for (final controller in ventaControllers) {
      ventasTexto.add(controller.text);
    }

    setState(() {
      resultado = controlador.procesar(
        cantidadVentasController.text,
        ventasTexto,
      );
    });
  }

  void _reiniciar() {
    setState(() {
      cantidadVentasController.clear();
      resultado = '';
      cantidadVentas = 0;

      for (final controller in ventaControllers) {
        controller.dispose();
      }
      ventaControllers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 245, 206, 248),
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Label('Resumen de ventas del vendedor'),
            SizedBox(height: 12),
            PurchaseField(
              hint: 'Cantidad de ventas N',
              controller: cantidadVentasController,
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: PryButton(
                    texto: 'Generar ventas',
                    onPressed: _generarCampos,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: PryButton(texto: 'Reiniciar', onPressed: _reiniciar),
                ),
              ],
            ),
            SizedBox(height: 12),
            if (cantidadVentas > 0)
              Column(
                children: [
                  for (int i = 0; i < ventaControllers.length; i++) ...[
                    PurchaseField(
                      hint: 'Monto de la venta ${i + 1}',
                      controller: ventaControllers[i],
                    ),
                    SizedBox(height: 10),
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: PryButton(
                          texto: 'Calcular resumen',
                          onPressed: _calcular,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            SizedBox(height: 12),
            if (resultado.isNotEmpty)
              Text(resultado, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    cantidadVentasController.dispose();
    for (final controller in ventaControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

// Shared navigation buttons used by exercise screens
class _ExerciseNavigation extends StatelessWidget {
  final String previousRoute;
  final String nextRoute;
  const _ExerciseNavigation({
    required this.previousRoute,
    required this.nextRoute,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (previousRoute.isNotEmpty)
                Navigator.pushNamed(context, previousRoute);
            },
            child: Text('Anterior ejercicio'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 182, 193),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 146, 209, 179),
            ),
            child: Text('Menu principal'),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (nextRoute.isNotEmpty) Navigator.pushNamed(context, nextRoute);
            },
            child: Text('Siguiente ejercicio'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 182, 193),
            ),
          ),
        ),
      ],
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('lib/resources/Logo_Jely.png', width: 200, height: 200),
            SizedBox(height: 20),
            Text(
              '¡Hola!, ${SaludoControlador.obtenerSaludo()}',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menú principal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: const Color.fromRGBO(230, 240, 255, 1),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/ej1'),
                  child: Text('Ejercicio 1 - IVA'),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/ej2'),
                  child: Text('Ejercicio 2 - Inversión'),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/ej3'),
                  child: Text('Ejercicio 3 - Promedios'),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/ej4'),
                  child: Text('Ejercicio 4 - Caja'),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/ej5'),
                  child: Text('Ejercicio 5 - Ventas'),
                ),
                SizedBox(height: 16),
                Image.asset('lib/resources/programacion.png', height: 250),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Ejercicio1Page extends StatelessWidget {
  const Ejercicio1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ejercicio 1 - Factura con IVA')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CardEjercicio1(),
            SizedBox(height: 12),
            _ExerciseNavigation(previousRoute: '/home', nextRoute: '/ej2'),
          ],
        ),
      ),
    );
  }
}

class Ejercicio2Page extends StatelessWidget {
  const Ejercicio2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ejercicio 2 - Inversión')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CardEjercicio2(),
            SizedBox(height: 12),
            _ExerciseNavigation(previousRoute: '/ej1', nextRoute: '/ej3'),
          ],
        ),
      ),
    );
  }
}

class Ejercicio3Page extends StatelessWidget {
  const Ejercicio3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ejercicio 3 - Promedios')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CardEjercicio3(),
            SizedBox(height: 12),
            _ExerciseNavigation(previousRoute: '/ej2', nextRoute: '/ej4'),
          ],
        ),
      ),
    );
  }
}

class Ejercicio4Page extends StatelessWidget {
  const Ejercicio4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ejercicio 4 - Caja registradora')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CardEjercicio4(),
            SizedBox(height: 12),
            _ExerciseNavigation(previousRoute: '/ej3', nextRoute: '/ej5'),
          ],
        ),
      ),
    );
  }
}

class Ejercicio5Page extends StatelessWidget {
  const Ejercicio5Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ejercicio 5 - Resumen de ventas')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CardEjercicio5(),
            SizedBox(height: 12),
            _ExerciseNavigation(previousRoute: '/ej4', nextRoute: '/home'),
          ],
        ),
      ),
    );
  }
}
