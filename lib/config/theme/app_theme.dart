import 'package:flutter/material.dart';

class AppTheme {
  // Define the primary color
  static const primaryColor = Color(0xff692960);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    scaffoldBackgroundColor: Colors.white,

    // Colors
    colorScheme: ColorScheme.light(
      tertiary: const Color.fromARGB(255, 241, 240, 240),
      shadow: Colors.black.withOpacity(0.05), // light theme shadow
      primary: primaryColor,
      secondary: Color(0xFF8E8E93),
      surface: Colors.white,
      onSurfaceVariant: const Color(0xFFF1F0F0), // subtle card / helper bg
      onSurface: Colors.black,
      // Adding complementary colors that work well with #acdde0
      onPrimary:
          Colors.black87, // Dark text on primary color for better contrast
    ),

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: primaryColor.withOpacity(0.1),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(color: primaryColor),
      ),
      hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
    ),

    // Message Bubbles
    cardTheme: CardThemeData(
      color: primaryColor.withOpacity(0.1),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // Icons
    iconTheme: const IconThemeData(color: Colors.black87, size: 24),

    // Text Themes
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
      labelMedium: TextStyle(fontSize: 12, color: Colors.grey),
    ),

    // Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.black87,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: ColorScheme.dark(
      shadow: Colors.black.withOpacity(0.3),
      primary: primaryColor,
      secondary: Color(0xFF8E8E93),
      onSurfaceVariant: Colors.white70, // ← THIS
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white,
      tertiary: Color(0xFF2A2A2A), // <-- dark theme secondary card color
      // tertiary: Color(0xFF7CBEC2),
      onPrimary: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(color: primaryColor),
      ),
      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
    ),
    cardTheme: CardThemeData(
      color: Colors.white.withOpacity(0.05),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // stronger shadow for dark mode
    ),
    iconTheme: const IconThemeData(color: Colors.white70, size: 24),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
      labelMedium: TextStyle(fontSize: 12, color: Colors.grey),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );
}
