import 'package:app_animaciones_bakapp/src/screens/home_screen.dart';
import 'package:flutter/material.dart';

//Para agregar calculos a mi animacion
import 'dart:math' as Math;

//Mis widgets personalizados
import 'package:app_animaciones_bakapp/src/widgets/rectancgulo_widget.dart';

class RetoCuadradoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      body: const Center(
        child: CuadradoAnimado(),
      ),
    );
  }
}

//Animacion del cuadrado
class CuadradoAnimado extends StatefulWidget {
  const CuadradoAnimado({
    Key? key,
  }) : super(key: key);

  @override
  State<CuadradoAnimado> createState() => _CuadradoAnimadoState();
}

class _CuadradoAnimadoState extends State<CuadradoAnimado>
    with SingleTickerProviderStateMixin {
  //controller = poner play, stop, ir hacia adelante, ir hacia atras, etc
  late AnimationController controller;

  //Mover animacion
  late Animation<double> moverDerecha;

  //Mover animacion
  late Animation<double> moverArriba;

  //Mover animacion
  late Animation<double> moverAtras;

  //Mover animacion
  late Animation<double> moverAbajo;

  @override
  void initState() {
    //Inicializando el controlador
    controller = AnimationController(
      vsync: this,
      //milliseconds 1000 = 1 segundo
      duration: const Duration(milliseconds: 4000),
    );

    //Desplazar hacia los lados (hacia la derecha)
    moverDerecha = Tween(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.25, curve: Curves.bounceOut),
      ),
    );

    //Desplazar hacia los lados (hacia arriba)
    moverArriba = Tween(begin: 0.0, end: -100.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.25, 0.5, curve: Curves.bounceOut),
      ),
    );

    //Desplazar hacia los lados (hacia Atras)
    moverAtras = Tween(begin: 0.0, end: -100.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 0.75, curve: Curves.bounceOut),
      ),
    );

    //Desplazar hacia los lados (hacia Abajo)
    moverAbajo = Tween(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.75, 1.0, curve: Curves.bounceOut),
      ),
    );

    controller.addListener(() {
      //Saber el Status de mi Animacion
      // print('Scatus: ${controller.status}');

      if (controller.status == AnimationStatus.completed) {
        /*
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
         */
        controller.reset();
        // controller.repeat();
        //controller.reverse();
      }

      //Condicion para que se retroceda
      /*
        else if(controller.status == AnimationStatus.dismissed){
        controller.forward();
      }
       */
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Si el controllador esta a esta altura la animacion arranca automaticamente
    // controller.forward();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reto cuadrado'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: controller,
            child: CirculoScreen(),
            //child: RectanguloScreen(),
            builder: (BuildContext context, Widget? child) {
              //Propiedad translate = desplazamiento
              return Transform.translate(
                  //Offset = (x,y), igual que el eje carteciano
                  offset: Offset(
                    moverDerecha.value + moverAtras.value,
                    moverArriba.value + moverAbajo.value,
                  ),
                  child: child);
            },
          ),
          const SizedBox(
            height: 100,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                //PLAY / Reproducir
                controller.forward();

                //Bucle, se repite una y otra vez
                // controller.repeat();
              },
              child: const Text('Activar animacion'),
            ),
          ),
        ],
      ),
    );
  }
}
