import 'package:flutter/material.dart';

//Para agregar calculos a mi animacion
import 'dart:math' as Math;

//Mis widgets personalizados
import 'package:app_animaciones_bakapp/src/widgets/rectancgulo_widget.dart';

class HomeScreen extends StatelessWidget {
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

  //Ayuda a controlar
  late Animation<double> rotation;

  @override
  void initState() {
    //Inicializando el controlador
    controller = AnimationController(
      vsync: this,
      //milliseconds 1000 = 1 segundo
      duration: Duration(milliseconds: 4000),
    );

    //Especificar tipo de animacion
    rotation = Tween(begin: 0.0, end: 2 * Math.pi).animate(controller);

    controller.addListener(() {
      //Saber el Status de mi Animacion
      print('Scatus: ${controller.status}');

      //Condicion para que se retroceda

      /*
      if (controller.status == AnimationStatus.completed) {
        controller.reverse();
      } 
      
       */

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? child) {
            print(
              'Rotacion: ' + rotation.value.toString(),
            );
            return Transform.rotate(
              angle: rotation.value,
              child: RectanguloScreen(),
            );
          },
        ),
        const SizedBox(
          height: 100,
        ),
        ElevatedButton(
          onPressed: () {
            //PLAY / Reproducir
            controller.forward();

            //Bucle, se repite una y otra vez
           // controller.repeat();
          },
          child: const Text('Activar animacion'),
        ),
      ],
    );
  }
}
