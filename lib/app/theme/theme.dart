import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData light(ColorScheme? dynamicScheme) {
    final scheme = dynamicScheme ?? kLightColorScheme;
    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 0,
      ),
    );
  }

  static ThemeData dark(ColorScheme? dynamicScheme) {
    final scheme = dynamicScheme ?? kDarkColorScheme;
    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
      ),
    );
  }
}
