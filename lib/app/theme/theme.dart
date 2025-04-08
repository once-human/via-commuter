import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'colors.dart';

class AppTheme {
  static const String _fontFamily = 'Inter';

  static ThemeData _buildTheme(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      fontFamily: _fontFamily,
      useMaterial3: true,
      brightness: colorScheme.brightness,
      scaffoldBackgroundColor: colorScheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface, // Or background, depending on design
        foregroundColor: colorScheme.onSurface, // Or onBackground
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          color: colorScheme.onSurface, // Or onBackground
          fontSize: 18,
          fontWeight: FontWeight.w600, // SemiBold
        ),
      ),
      textTheme: _buildTextTheme(colorScheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          // Explicitly define background and foreground from ColorScheme
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          // Keep existing text style overrides
          textStyle: const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w600),
          // Add padding and shape for consistency if needed
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Match other elements
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
         style: TextButton.styleFrom(
           textStyle: const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w600),
         ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        // Define borders for different states
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          // Subtle border when not focused
          borderSide: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          // Highlight border using primary color when focused (reduced width)
          borderSide: BorderSide(color: colorScheme.primary, width: 1.0),
        ),
        // Ensure borderSide is none in the base 'border' to rely on enabled/focused
        border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(16),
           borderSide: BorderSide.none, // Base border is none
        ),
        filled: true,
        // Apply translucency to the default input background
        fillColor: colorScheme.surface.withOpacity(0.7),
        hintStyle: TextStyle(
          fontFamily: _fontFamily,
          color: colorScheme.onSurfaceVariant.withOpacity(0.6),
          fontWeight: FontWeight.w400, // Regular
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      // Define other component themes as needed
    );
  }

  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      // Define specific text styles if needed, otherwise defaults will be used
      // Example:
      displayLarge: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w700, color: colorScheme.onBackground),
      headlineLarge: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w600, color: colorScheme.onBackground),
      titleLarge: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w600, color: colorScheme.onSurface),
      bodyLarge: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, color: colorScheme.onSurface),
      bodyMedium: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, color: colorScheme.onSurfaceVariant),
      bodySmall: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, color: colorScheme.onSurfaceVariant, fontSize: 12),
      labelLarge: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w600, color: colorScheme.onPrimary), // Used in buttons
    ).apply(
      // Apply base colors if not specified above
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onBackground,
    );
  }

  static ThemeData light(ColorScheme? dynamicScheme) {
    final scheme = dynamicScheme?.harmonized() ?? kLightColorScheme;
    return _buildTheme(scheme);
  }

  static ThemeData dark(ColorScheme? dynamicScheme) {
    // Prioritize our custom dark scheme
    final scheme = kDarkColorScheme;
    // We ignore dynamicScheme for dark mode to enforce our specific colors
    // If you want dynamic dark colors, use: dynamicScheme?.harmonized() ?? kDarkColorScheme;
    return _buildTheme(scheme);
  }
}
