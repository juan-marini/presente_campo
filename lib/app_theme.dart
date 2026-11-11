import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color verdePresente = Color(0xFF1B7F5B);
  static const Color amareloDestaque = Color(0xFFFFC107);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: verdePresente),
    inputDecorationTheme: const InputDecorationTheme(filled: true),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: verdePresente,
      brightness: Brightness.dark,
    ),
    inputDecorationTheme: const InputDecorationTheme(filled: true),
  );
}
