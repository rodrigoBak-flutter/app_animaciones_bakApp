

import 'package:app_animaciones_bakapp/src/screens/circular_progress_screen.dart';
import 'package:app_animaciones_bakapp/src/screens/reto_doble_screen.dart';
import 'package:flutter/material.dart';

import 'package:app_animaciones_bakapp/src/screens/reto_1_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// Este Widget le da inicio a la aplicacion.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animaciones Personalizadas',
      home: CircularProgressScreen(),
    );
  }
}
