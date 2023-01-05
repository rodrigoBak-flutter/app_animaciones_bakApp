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
  //Opacidad
  late Animation<double> opacidad;

  //Mover animacion
  late Animation<double> mover;

  //Agrandar animacion
  late Animation<double> agrandar;

  @override
  void initState() {
    //Inicializando el controlador
    controller = AnimationController(
      vsync: this,
      //milliseconds 1000 = 1 segundo
      duration: const Duration(milliseconds: 4000),
    );

    //Especificar tipo de animacion
    // rotation = Tween(begin: 0.0, end: 2 * Math.pi).animate(controller);
    rotation = Tween(begin: 0.0, end: 2 * Math.pi).animate(
      CurvedAnimation(parent: controller, curve: Curves.bounceOut),
    );

    //Especifica la transparencia de la animacion 1=visible y 0=invisible
    // opacidad = Tween(begin: 0.1, end: 1.0).animate(controller);

    //Interval(0, 1)= cuanto dura la animacion 0=inicio y 1=completado
    opacidad = Tween(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.25, curve: Curves.easeOut),
      ),
    );

    //Desplazar hacia los lados
    mover = Tween(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );

    //Agrandar la animacion, cambiar el tamaño de mi animacion
    agrandar = Tween(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );

    controller.addListener(() {
      //Saber el Status de mi Animacion
      // print('Scatus: ${controller.status}');

      //Condicion para que se retroceda
      if (controller.status == AnimationStatus.completed) {
        // controller.reset();
        // controller.repeat();
        controller.reverse();
      }

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
          child: RectanguloScreen(),
          builder: (BuildContext context, Widget? child) {
            //Saber el Status de mi Animacion
            // print('Rotacion: ' + rotation.value.toString());
            // print('Opacidad: ${opacidad.value}');
            //print('Rotacion: ${rotation.value}');
            //Propiedad translate = desplazamiento
            return Transform.translate(
              //Offset = (x,y), igual que el eje carteciano
              offset: Offset(mover.value, 0.0),
              //Propiedad rotate = girar
              child: Transform.rotate(
                angle: rotation.value,
                //Propiedad opacity = mas visible o menos visible
                child: Opacity(
                  opacity: opacidad.value,
                  //Propiedad scale = determina el tamaño de mi animacion
                  child: Transform.scale(
                    scale: agrandar.value,
                    child: child,
                  ),
                ),
              ),
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
