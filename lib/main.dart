import 'package:flutter/material.dart';
import 'screens/converter_screen.dart';

/// Main entry point for the Measures Converter Flutter application
/// This application provides unit conversion functionality for distance, weight, and temperature
void main() {
  runApp(const MeasuresConverterApp());
}

/// Root widget that configures the MaterialApp for the entire application
/// Sets up the theme, app bar styling, and navigation structure
class MeasuresConverterApp extends StatelessWidget {
  const MeasuresConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: const ConverterScreen(),
    );
  }
}