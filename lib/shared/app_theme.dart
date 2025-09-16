import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light, 
      scaffoldBackgroundColor: Colors.white, 
      primaryColor: const Color.fromARGB(255, 37, 102, 82),
      
    );
  }

}
