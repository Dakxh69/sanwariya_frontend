import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFFF2CA50);
  static const Color onPrimary = Color(0xFF3C2F00);
  static const Color primaryContainer = Color(0xFFD4AF37);
  static const Color onPrimaryContainer = Color(0xFF554300);

  static const Color secondary = Color(0xFFDAC58D);
  static const Color onSecondary = Color(0xFF3C2F05);
  static const Color secondaryContainer = Color(0xFF544519);
  static const Color onSecondaryContainer = Color(0xFFC8B37D);

  static const Color tertiary = Color(0xFFBFCDFF);
  static const Color onTertiary = Color(0xFF082B72);
  static const Color tertiaryContainer = Color(0xFF97B0FF);
  static const Color onTertiaryContainer = Color(0xFF254188);

  static const Color error = Color(0xFFFFB4AB);
  static const Color onError = Color(0xFF690005);
  static const Color errorContainer = Color(0xFF93000A);
  static const Color onErrorContainer = Color(0xFFFFDAD6);

  static const Color background = Color(0xFF131313);
  static const Color onBackground = Color(0xFFE5E2E1);

  static const Color surface = Color(0xFF131313);
  static const Color onSurface = Color(0xFFE5E2E1);
  static const Color surfaceVariant = Color(0xFF353534);
  static const Color onSurfaceVariant = Color(0xFFD0C5AF);

  static const Color outline = Color(0xFF99907C);
  static const Color outlineVariant = Color(0xFF4D4635);

  static const Color surfaceContainerHighest = Color(0xFF353534);
  static const Color surfaceContainerHigh = Color(0xFF2A2A2A);
  static const Color surfaceContainer = Color(0xFF201F1F);
  static const Color surfaceContainerLow = Color(0xFF1C1B1B);
  static const Color surfaceContainerLowest = Color(0xFF0E0E0E);

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: onPrimaryContainer,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,
    tertiary: tertiary,
    onTertiary: onTertiary,
    tertiaryContainer: tertiaryContainer,
    onTertiaryContainer: onTertiaryContainer,
    error: error,
    onError: onError,
    errorContainer: errorContainer,
    onErrorContainer: onErrorContainer,
    surface: surface,
    onSurface: onSurface,
    surfaceContainerHighest: surfaceContainerHighest,
    surfaceContainerHigh: surfaceContainerHigh,
    surfaceContainer: surfaceContainer,
    surfaceContainerLow: surfaceContainerLow,
    surfaceContainerLowest: surfaceContainerLowest,
    onSurfaceVariant: onSurfaceVariant,
    outline: outline,
    outlineVariant: outlineVariant,
    shadow: Color(0x80000000),
  );

  static TextTheme textTheme() {
    final natoSerif = GoogleFonts.notoSerifTextTheme();
    final inter = GoogleFonts.interTextTheme();

    return inter.copyWith(
      displayLarge: natoSerif.displayLarge?.copyWith(
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      displayMedium: natoSerif.displayMedium?.copyWith(
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      displaySmall: natoSerif.displaySmall?.copyWith(
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      headlineLarge: natoSerif.headlineLarge?.copyWith(
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      headlineMedium: natoSerif.headlineMedium?.copyWith(
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      headlineSmall: natoSerif.headlineSmall?.copyWith(
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      titleLarge: natoSerif.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: onSurface,
      ),
      titleMedium: natoSerif.titleMedium?.copyWith(
        fontWeight: FontWeight.w500,
        color: onSurface,
      ),
      titleSmall: natoSerif.titleSmall?.copyWith(
        fontWeight: FontWeight.w500,
        color: onSurface,
      ),

      bodyLarge: natoSerif.bodyLarge?.copyWith(
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      bodyMedium: natoSerif.bodyMedium?.copyWith(
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      bodySmall: natoSerif.bodySmall?.copyWith(
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),

      labelLarge: inter.labelLarge?.copyWith(
        fontWeight: FontWeight.w500,
        color: primary,
      ),
      labelMedium: inter.labelMedium?.copyWith(
        fontWeight: FontWeight.w500,
        color: primary,
      ),
      labelSmall: inter.labelSmall?.copyWith(
        fontWeight: FontWeight.w500,
        color: primary,
      ),
    );
  }

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      scaffoldBackgroundColor: background,
      textTheme: textTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: onSurface,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
