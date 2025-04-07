import 'package:flutter/material.dart';

// Define your core colors based on the palette
const Color kOxfordBlue = Color(0xFF011638);
const Color kCharcoal = Color(0xFF364156);
const Color kJordyBlue = Color(0xFF98B2F4); // Primary Action / Accent
const Color kIndianRed = Color(0xFFDB5461); // Maybe Error or Warning
const Color kWhite = Colors.white;
const Color kBlack = Colors.black;
const Color kGrey = Color(0xFF9E9E9E); // General grey for text/icons
const Color kLightGrey = Color(0xFFEEEEEE); // Input field background / dividers

/// Dark Color Scheme using the provided palette
const ColorScheme kDarkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // Core Colors
  primary: kJordyBlue,         // Main action button (Continue)
  onPrimary: kOxfordBlue,     // Text on Primary button
  secondary: kCharcoal,       // Maybe for secondary actions or borders
  onSecondary: kWhite,        // Text on Secondary
  tertiary: kIndianRed,       // Optional accent
  onTertiary: kWhite,

  // Backgrounds
  background: kOxfordBlue,    // Main background of the screen
  onBackground: kWhite,       // Main text color on background
  surface: kCharcoal,         // Cards, Dialogs, Input Field backgrounds (Apple/Google buttons)
  onSurface: kWhite,          // Text/icons on surface (Apple/Google button text)
  surfaceContainerHighest: kCharcoal, // For the slightly elevated input fields / country code
  onSurfaceVariant: kGrey,    // Hint text, dividers, disabled elements, consent text

  // Other
  outline: kGrey,             // Borders, dividers
  outlineVariant: kLightGrey, // Subtle dividers like the 'or' lines
  error: kIndianRed,          // Error states
  onError: kWhite,            // Text on error backgrounds
  inverseSurface: kWhite,     // For elements needing contrast on dark background
  onInverseSurface: kOxfordBlue,// Text on inverse surface
  shadow: kBlack,             // Shadows
  scrim: Color(0x80000000), // 50% opacity black for scrims
);

/// Light Color Scheme - Derived or defined separately if needed
// For now, we focus on the dark theme as per the screenshot
// A light theme would need its own color definitions mapping
// to the roles (primary, background, surface, etc.)
const ColorScheme kLightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: kJordyBlue, // Example mapping
  onPrimary: kOxfordBlue,
  secondary: kCharcoal,
  onSecondary: kWhite,
  error: kIndianRed,
  onError: kWhite,
  background: kWhite,
  onBackground: kOxfordBlue,
  surface: kLightGrey,
  onSurface: kOxfordBlue,
  surfaceContainerHighest: kWhite, // Example
  onSurfaceVariant: kGrey,
  outline: kGrey,
  outlineVariant: kLightGrey,
);
