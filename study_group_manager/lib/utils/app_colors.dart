import 'package:flutter/material.dart';

class AppColors {
  // Primary green colors matching the image
  static const Color primaryGreen = Color(0xFF4CAF50);
  static const Color primaryGreenDark = Color(0xFF388E3C);
  static const Color primaryGreenLight = Color(0xFF66BB6A);

  // Background colors
  static const Color backgroundGreen = Color(0xFF66BB6A);
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundWhite = Color(0xFFFFFFFF);

  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);

  // Card and surface colors
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color dividerColor = Color(0xFFE0E0E0);

  // Status colors
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color errorRed = Color(0xFFf44336);
  static const Color warningOrange = Color(0xFFFF9800);

  // Tab and category colors
  static const Color aiColor = Color(0xFF9C27B0);      // Purple for AI
  static const Color devColor = Color(0xFF2196F3);     // Blue for DEV
  static const Color osColor = Color(0xFFFF9800);      // Orange for OS

  // Custom MaterialColor for primary swatch
  static const MaterialColor primaryGreenSwatch = MaterialColor(
    0xFF4CAF50,
    <int, Color>{
      50: Color(0xFFE8F5E8),
      100: Color(0xFFC8E6C9),
      200: Color(0xFFA5D6A7),
      300: Color(0xFF81C784),
      400: Color(0xFF66BB6A),
      500: Color(0xFF4CAF50),
      600: Color(0xFF43A047),
      700: Color(0xFF388E3C),
      800: Color(0xFF2E7D32),
      900: Color(0xFF1B5E20),
    },
  );

  // Gradient definitions
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryGreen, primaryGreenLight],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [backgroundGreen, primaryGreenLight],
  );
}