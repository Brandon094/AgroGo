import 'package:flutter/material.dart';

/// Configuración de tema principal de AgroGo.
/// Optimizado para alta visibilidad y legibilidad en exteriores para trabajadores del campo.
class TemaApp {
  // Paleta de colores de alto contraste
  static const Color verdePrimario = Color(0xFF1B5E20); // Verde bosque profundo
  static const Color amarilloAcento = Color(0xFFFFB300); // Amarillo de alto contraste
  static const Color fondoClaro = Color(0xFFFAFAFA);
  static const Color superficieClara = Colors.white;
  static const Color textoOscuro = Color(0xFF212121);
  static const Color textoClaro = Colors.white;

  static ThemeData get temaClaro {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: verdePrimario,
        primary: verdePrimario,
        secondary: amarilloAcento,
        surface: superficieClara,
        onPrimary: textoClaro,
        onSecondary: textoOscuro,
      ),
      scaffoldBackgroundColor: fondoClaro,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: textoOscuro,
        ),
        titleLarge: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          color: textoOscuro,
        ),
        bodyLarge: TextStyle(
          fontSize: 18.0, // Texto grande para fácil lectura
          color: textoOscuro,
        ),
        bodyMedium: TextStyle(
          fontSize: 16.0,
          color: textoOscuro,
        ),
      ),
      // Botones grandes con alto contraste para fácil pulsación
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: verdePrimario,
          foregroundColor: textoClaro,
          minimumSize: const Size(double.infinity, 56.0), // Altura grande
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
