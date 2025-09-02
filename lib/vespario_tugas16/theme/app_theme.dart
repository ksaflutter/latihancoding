import 'package:flutter/material.dart';
import 'package:flutter_application_1/vespario_tugas16/theme/app_colors.dart';

class AppThemeFinal {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.teal,
    primaryColor: const Color.fromARGB(157, 1, 217, 217),
    scaffoldBackgroundColor: AppColorsFinal.lightGray,
    fontFamily: 'Roboto',

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.cyan,
      foregroundColor: AppColorsFinal.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColorsFinal.white,
      ),
    ),

    // ElevatedButton Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColorsFinal.orange,
        foregroundColor: AppColorsFinal.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    // InputDecoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorsFinal.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColorsFinal.mediumGray),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColorsFinal.mediumGray),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColorsFinal.mintGreen, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColorsFinal.redAccent),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppColorsFinal.white,
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColorsFinal.white,
      selectedItemColor: AppColorsFinal.mintGreen,
      unselectedItemColor: AppColorsFinal.mediumGray,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // Drawer Theme
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColorsFinal.white,
    ),
  );
}
