import 'package:flutter/material.dart';

// Define your core colors based on the palette
const Color kOxfordBlue = Color(0xFF011638);
const Color kCharcoal = Color(0xFF364156);

// Define new green primary colors
const Color kPrimaryGreen = Color(0xFF24EB68);
const Color kPrimaryGreenDarker = Color(0xFF41C763);

const Color kIndianRed = Color(0xFFDB5461); // Maybe Error or Warning
const Color kWhite = Colors.white;
const Color kBlack = Colors.black;
const Color kGrey = Color(0xFF9E9E9E); // General grey for text/icons
const Color kLightGrey = Color(0xFFEEEEEE); // Input field background / dividers

// New Dark Theme Colors (Inspired by How We Feel)
const Color kDeepDarkBackground = Color(0xFF121212);
const Color kDarkSurface = Color(0xFF1E1E1E);
const Color kGreyTransparent = Color(0x339E9E9E); // ~20% opacity Grey for outlineVariant

/// Dark Color Scheme using the provided palette
const ColorScheme kDarkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // Core Colors (Updated Primary to Green)
  primary: kPrimaryGreenDarker, // Use darker green for dark theme primary
  onPrimary: kBlack,          // Use black text on the green primary for contrast
  secondary: kCharcoal,       // Maybe for secondary actions or borders
  onSecondary: kWhite,        // Text on Secondary
  tertiary: kIndianRed,       // Optional accent
  onTertiary: kWhite,

  // Backgrounds (Updated for darker theme)
  background: kDeepDarkBackground,    // Main background of the screen (Now much darker)
  onBackground: kWhite,           // Main text color on background
  surface: kDarkSurface,            // Cards, Dialogs, Input Field backgrounds (Slightly lighter dark)
  onSurface: kWhite,              // Text/icons on surface
  surfaceContainerHighest: kDarkSurface, // Keep consistent with surface for now
  onSurfaceVariant: kGrey,        // Hint text, dividers, disabled elements, consent text

  // Other
  outline: kGrey,                 // Borders, dividers
  outlineVariant: kGreyTransparent, // Subtle dividers like the 'or' lines (Use const color)
  error: kIndianRed,              // Error states
  onError: kWhite,                // Text on error backgrounds
  inverseSurface: kWhite,         // For elements needing contrast on dark background
  onInverseSurface: kOxfordBlue,    // Text on inverse surface
  shadow: kBlack,                 // Shadows
  scrim: Color(0x80000000),     // 50% opacity black for scrims
);

/// Light Color Scheme - Derived or defined separately if needed
// For now, we focus on the dark theme as per the screenshot
// A light theme would need its own color definitions mapping
// to the roles (primary, background, surface, etc.)
const ColorScheme kLightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: kPrimaryGreen, // Use lighter green for light theme primary
  onPrimary: kBlack, // Use black text on the green primary for contrast
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
