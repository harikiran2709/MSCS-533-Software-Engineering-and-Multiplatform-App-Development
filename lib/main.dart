import 'package:flutter/material.dart';
import 'screens/conversion_screen.dart';

/// Main entry point for the Unit Converter Flutter application
/// This application provides unit conversion functionality for distance, weight, and temperature
void main() {
  runApp(const UnitConverterApp());
}

/// Root widget that configures the MaterialApp for the entire application
/// Sets up the theme, app bar styling, and navigation structure
class UnitConverterApp extends StatelessWidget {
  const UnitConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: const ConversionScreen(),
    );
  }
}