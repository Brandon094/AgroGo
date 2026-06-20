import 'package:flutter/material.dart';

class TemaApp {
  // Paleta Premium "Modern Rural"
  static const Color esmeralda = Color(0xFF00695C); // Verde Esmeralda Profundo
  static const Color bosque = Color(0xFF2E7D32);   // Verde Bosque Vivo
  static const Color atardecer = Color(0xFFF57C00); // Naranja para acentos/alertas
  static const Color arena = Color(0xFFF9FBF9);    // Fondo ultra claro
  static const Color pizarra = Color(0xFF37474F);  // Texto gris azulado profundo

  static ThemeData get temaClaro {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: esmeralda,
        primary: esmeralda,
        secondary: atardecer,
        surface: Colors.white,
        surfaceContainerLowest: Colors.white,
        outlineVariant: Color(0xFFE0E0E0),
      ),
      scaffoldBackgroundColor: arena,
      
      // Estilo de Tarjetas Global
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8),
      ),

      // Tipografía Refinada
      textTheme: const TextTheme(
        displaySmall: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: pizarra, letterSpacing: -1),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: pizarra),
        bodyLarge: TextStyle(fontSize: 18, color: pizarra, height: 1.4),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1.2, color: Colors.grey),
      ),

      // Botones Premium
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: esmeralda,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 64),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 8,
          shadowColor: esmeralda.withOpacity(0.3),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),

      // Inputs con estilo
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: esmeralda, width: 2)),
        labelStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
      ),

      // Barra de Navegación
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: esmeralda.withOpacity(0.1),
        height: 85,
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)
        ),
      ),
    );
  }
}
