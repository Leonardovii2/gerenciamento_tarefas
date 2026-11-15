import 'package:flutter/material.dart';

class AppThemes {
  // =========================
  // TEMA CLARO
  // =========================
  static final ThemeData claro = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    primaryColor: const Color(0xFF047857),

    colorScheme: const ColorScheme.light(
      primary: Color(0xFF047857),
      onPrimary: Colors.white,
      secondary: Color(0xFF10B981),
      onSecondary: Color(0xFF064E3B),
      surface: Colors.white,
      onSurface: Color(0xFF064E3B),
      error: Color(0xFFDC2626),
      onError: Colors.white,
    ),

    scaffoldBackgroundColor: const Color(0xFFF5F9F6),

    // Textos
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF064E3B)),
      bodyMedium: TextStyle(color: Color(0xFF064E3B)),
      bodySmall: TextStyle(color: Color(0xFF427565)),
      titleLarge: TextStyle(
        color: Color(0xFF064E3B),
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Color(0xFF064E3B),
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(color: Color(0xFF064E3B)),
    ),

    // Barra superior
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF047857),
      foregroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),

    // Cards
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),

    // Botão flutuante
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF10B981),
      foregroundColor: Colors.white,
    ),

    // Botões
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF047857),
        foregroundColor: Colors.white,
      ),
    ),

    // Campos de texto
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: Color(0xFF427565)),
      hintStyle: const TextStyle(color: Color(0xFF78968B)),
      prefixIconColor: const Color(0xFF047857),
      suffixIconColor: const Color(0xFF047857),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD1E5D9)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF047857), width: 2),
      ),
    ),

    // Ícones e divisórias
    iconTheme: const IconThemeData(color: Color(0xFF047857)),
    dividerColor: const Color(0xFFD1E5D9),

    // Seleções
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFF047857);
        }
        return null;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFF047857);
        }
        return Colors.white;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFFB7E4CE);
        }
        return const Color(0xFFD1D5DB);
      }),
    ),

    dialogBackgroundColor: Colors.white,
  );

  // =========================
  // TEMA ESCURO
  // =========================
  static final ThemeData escuro = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    primaryColor: const Color(0xFF34D399),

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF34D399),
      onPrimary: Color(0xFF064E3B),
      secondary: Color(0xFF10B981),
      onSecondary: Color(0xFF064E3B),
      surface: Color(0xFF1B3028),
      onSurface: Color(0xFFE2F5EA),
      error: Color(0xFFF87171),
      onError: Color(0xFF450A0A),
    ),

    scaffoldBackgroundColor: const Color(0xFF102019),

    // Textos
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFE2F5EA)),
      bodyMedium: TextStyle(color: Color(0xFFE2F5EA)),
      bodySmall: TextStyle(color: Color(0xFFA7CDB9)),
      titleLarge: TextStyle(
        color: Color(0xFFE2F5EA),
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Color(0xFFE2F5EA),
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(color: Color(0xFFE2F5EA)),
    ),

    // Barra superior
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF065F46),
      foregroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),

    // Cards
    cardTheme: CardThemeData(
      color: const Color(0xFF1B3028),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),

    // Botão flutuante
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF34D399),
      foregroundColor: Color(0xFF064E3B),
    ),

    // Botões
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF34D399),
        foregroundColor: const Color(0xFF064E3B),
      ),
    ),

    // Campos de texto
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1B3028),
      labelStyle: const TextStyle(color: Color(0xFFA7CDB9)),
      hintStyle: const TextStyle(color: Color(0xFF8EAA9A)),
      prefixIconColor: const Color(0xFF34D399),
      suffixIconColor: const Color(0xFF34D399),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF365448)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF34D399), width: 2),
      ),
    ),

    // Ícones e divisórias
    iconTheme: const IconThemeData(color: Color(0xFF34D399)),
    dividerColor: const Color(0xFF365448),

    // Seleções
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFF34D399);
        }
        return null;
      }),
      checkColor: WidgetStateProperty.all(const Color(0xFF064E3B)),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFF34D399);
        }
        return const Color(0xFFA7CDB9);
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFF365448);
        }
        return const Color(0xFF263B31);
      }),
    ),

    dialogBackgroundColor: const Color(0xFF1B3028),
  );
}
