import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue, // Main color for the app
    scaffoldBackgroundColor: Colors.white, // Background color
    cardColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black), // Large Headline
      displayMedium: TextStyle(
          fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black87),
      displaySmall: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black87),

      headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black), // Headlines
      headlineMedium: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
      headlineSmall: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),

      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ), // Titles
      titleMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
      titleSmall: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),

      bodyLarge: TextStyle(fontSize: 16, color: Colors.black), // Body Text
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
      bodySmall: TextStyle(fontSize: 12, color: Colors.black54),

      labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black), // Buttons, Labels
      labelMedium: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87),
      labelSmall: TextStyle(
          fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black54),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(Colors.blue),
      trackColor: WidgetStateProperty.all(Colors.blue.shade200),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.orange, // Dark theme main color
    scaffoldBackgroundColor: Colors.black, // Dark background
    cardColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.orange,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
      displayMedium: TextStyle(
          fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white70),
      displaySmall: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white70),
      headlineLarge: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
      headlineMedium: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white70),
      headlineSmall: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white70),
      titleLarge: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
      titleMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white70),
      titleSmall: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white70),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
      bodySmall: TextStyle(fontSize: 12, color: Colors.white60),
      labelLarge: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
      labelMedium: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white70),
      labelSmall: TextStyle(
          fontSize: 10, fontWeight: FontWeight.w400, color: Colors.white60),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(Colors.orange),
      trackColor: WidgetStateProperty.all(Colors.orange.shade200),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.black,
      ),
    ),
  );
}
