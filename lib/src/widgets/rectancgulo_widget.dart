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
