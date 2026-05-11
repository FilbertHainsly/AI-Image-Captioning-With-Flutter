import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ── Color Palette ──
  static const Color primaryDark = Color(0xFF0D0D1A);
  static const Color surfaceDark = Color(0xFF161630);
  static const Color cardDark = Color(0xFF1E1E3F);
  static const Color accentPurple = Color(0xFF7C4DFF);
  static const Color accentBlue = Color(0xFF448AFF);
  static const Color accentPink = Color(0xFFFF4081);
  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFFB0B0CC);
  static const Color glassBorder = Color(0x30FFFFFF);
  static const Color glassBackground = Color(0x15FFFFFF);
  static const Color successGreen = Color(0xFF69F0AE);
  static const Color errorRed = Color(0xFFFF5252);

  // ── Gradients ──
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentPurple, accentBlue],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0A0A1E),
      Color(0xFF12122B),
      Color(0xFF1A1A40),
    ],
  );

  static const LinearGradient shimmerGradient = LinearGradient(
    colors: [
      Color(0xFF1E1E3F),
      Color(0xFF2A2A5A),
      Color(0xFF1E1E3F),
    ],
  );

  // ── Theme Data ──
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: primaryDark,
      colorScheme: const ColorScheme.dark(
        primary: accentPurple,
        secondary: accentBlue,
        surface: surfaceDark,
        error: errorRed,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: textPrimary,
            letterSpacing: -0.5,
          ),
          headlineMedium: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textSecondary,
            height: 1.6,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textSecondary,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            letterSpacing: 0.5,
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),
    );
  }

  // ── Glass decoration ──
  static BoxDecoration get glassCard => BoxDecoration(
        color: glassBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: glassBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      );

  static BoxDecoration get gradientCard => BoxDecoration(
        gradient: primaryGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: accentPurple.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      );
}
