import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: Colors.indigo,
    textTheme: GoogleFonts.poppinsTextTheme(),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.indigo,
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
  );
}

class AppColors {
  static const primary = Color(0xFF3F51B5);
  static const secondary = Color(0xFF5C6BC0);
  static const accent = Color(0xFF7986CB);
  static const background = Color(0xFFF5F5F5);
  static const surface = Color(0xFFFFFFFF);
  static const error = Color(0xFFB00020);
  
  // New vibrant colors for icons
  static const iconGK = Color(0xFF4CAF50);      // Green
  static const iconNews = Color(0xFFF44336);    // Red
  static const iconAI = Color(0xFF2196F3);      // Blue
  static const iconMore = Color(0xFF9C27B0);    // Purple
}
