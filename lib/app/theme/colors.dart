import 'package:flutter/material.dart';

/// Fallback light color scheme (when dynamic theming isn't available)
const ColorScheme kLightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF007BFF),
  onPrimary: Colors.white,
  secondary: Color(0xFF1565C0),
  onSecondary: Colors.white,
  error: Color(0xFFD32F2F),
  onError: Colors.white,
  background: Color(0xFFF5F5F5),
  onBackground: Color(0xFF121212),
  surface: Colors.white,
  onSurface: Color(0xFF121212),
);

/// Fallback dark color scheme
const ColorScheme kDarkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF90CAF9),
  onPrimary: Color(0xFF121212),
  secondary: Color(0xFF64B5F6),
  onSecondary: Color(0xFF121212),
  error: Color(0xFFEF9A9A),
  onError: Color(0xFF121212),
  background: Color(0xFF121212),
  onBackground: Colors.white,
  surface: Color(0xFF1E1E1E),
  onSurface: Colors.white,
);
