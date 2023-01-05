import 'package:flutter/material.dart';

class RectanguloScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.25,
      height: size.height * 0.15,
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
    );
  }
}



class CirculoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.25,
      height: size.height * 0.13,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(100.0),
          topRight: Radius.circular(100.0),
          bottomLeft: Radius.circular(100.0),
          bottomRight: Radius.circular(100.0),
        ),
        color: Colors.blue,
        boxShadow: [
          BoxShadow(color: Colors.lightBlue, spreadRadius: 3),
        ],
      ),
    );
  }
}
