import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double tamanho;

  const AppLogo({super.key, this.tamanho = 120});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: tamanho,
      height: tamanho,
    );
  }
}
