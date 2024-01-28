import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF92140C);
  static const Color secColor = Color(0xFFFFF8F0);
  static const Color buttonColor = Color(0xFF5E0F0A);
  static const Color borderColor = Color(0xFFFFCF99);
  ThemeData theme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      // textTheme: const TextTheme(
      //   titleLarge: TextStyle(color: Colors.black),
      //   titleMedium: TextStyle(color: Colors.black),
      //   titleSmall: TextStyle(color: Colors.black),
      //   bodyLarge: TextStyle(color: Colors.black),
      //   bodyMedium: TextStyle(color: Colors.black),
      //   bodySmall: TextStyle(color: Colors.black),
      // ),
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }
}
