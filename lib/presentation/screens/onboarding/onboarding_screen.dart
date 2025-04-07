import 'dart:ui'; // For BackdropFilter
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart'; // Import country_picker
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String _selectedCountryCode = '+91';
  String _selectedCountryFlag = '🇮🇳'; // Store flag separately if needed
  final TextEditingController _phoneController = TextEditingController();

  // Country object from country_picker
  Country _selectedCountry = Country(
    phoneCode: '91',
    countryCode: 'IN',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'India',
    example: '9123456789',
    displayName: 'India (IN) [+91]',
    displayNameNoCountryCode: 'India (IN)',
    e164Key: '91-IN-0',
  );

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  // Updated buildCountryCodeSelector
  Widget _buildCountryCodeSelector(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        _showCountryPicker(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _selectedCountry.flagEmoji,
              style: textTheme.titleMedium?.copyWith(fontSize: 24),
            ),
            const SizedBox(width: 6),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: colorScheme.onSurfaceVariant,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  // Updated _showCountryPicker using country_picker package
  void _showCountryPicker(BuildContext context) {
    final theme = Theme.of(context);
    showCountryPicker(
      context: context,
      favorite: ['IN', 'US', 'GB'], // Optional: Add favorite countries
      showPhoneCode: true,
      onSelect: (Country country) {
        HapticFeedback.mediumImpact();
        setState(() {
          _selectedCountry = country;
          _selectedCountryCode = '+${country.phoneCode}';
        });
      },
      countryListTheme: CountryListThemeData(
        backgroundColor: theme.colorScheme.surface, // Dark surface for the list
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        inputDecoration: InputDecoration(
          hintText: 'Search country',
          hintStyle: TextStyle(color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7)),
          prefixIcon: Icon(Icons.search, color: theme.colorScheme.onSurfaceVariant),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: theme.colorScheme.surfaceContainerHighest,
        ),
        searchTextStyle: TextStyle(color: theme.colorScheme.onSurface),
        textStyle: TextStyle(color: theme.colorScheme.onSurface),
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.7, // Control height
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Updated buildPhoneNumberInput
    Widget buildPhoneNumberInput() {
      return Expanded(
        child: TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurface, // Text color inside input
            letterSpacing: 1.2, // Increased spacing like Figma
            fontSize: 16, // Adjust font size if needed
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: colorScheme.surface,
            hintText: '+${_selectedCountry.phoneCode} XXXX XXXX', // Dynamic hint
            hintStyle: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant.withOpacity(0.5), // Hint color
              letterSpacing: 1.2,
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none, // No border by default
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colorScheme.outline.withOpacity(0.1), // Subtle border when enabled
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colorScheme.primary, // Highlight on focus
                width: 1.5, // Slightly thicker border on focus
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Icon(
                Icons.account_circle_outlined, // Icon matching Figma
                color: colorScheme.onSurfaceVariant,
                size: 24,
              ),
            ),
          ),
        ),
      );
    }

    // buildStyledButton remains largely the same, adjust colors if needed
    ElevatedButton buildStyledButton({
      required VoidCallback onPressed,
      required Widget child,
      required Color backgroundColor,
      required Color foregroundColor,
      double? minWidth,
      double? minHeight,
      EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 18),
      BorderSide? side,
      double elevation = 2.0, // Default elevation
    }) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          minimumSize: Size(minWidth ?? double.infinity, minHeight ?? 56),
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: side ?? BorderSide.none,
          ),
          elevation: elevation,
          shadowColor: Colors.black.withOpacity(0.15),
        ),
        child: child,
      );
    }

    // Updated buildSocialButton
    Widget buildSocialButton({
      required VoidCallback onPressed,
      required Widget icon,
      required String label,
    }) {
      return buildStyledButton(
        onPressed: () {
          HapticFeedback.mediumImpact();
          onPressed();
        },
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        padding: const EdgeInsets.symmetric(vertical: 16),
        minHeight: 52,
        side: BorderSide(
          color: colorScheme.outline.withOpacity(0.15), // Slightly more visible border
          width: 1,
        ),
        elevation: 1.0, // Less elevation for social buttons
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 24, height: 24, child: icon),
            const SizedBox(width: 12),
            Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600, // Slightly bolder text
                color: colorScheme.onSurface, // Ensure dark text
                fontSize: 15,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.background, // Keep dark background
      body: Stack(
        children: [
          SafeArea(
            bottom: false, // Allow content to go behind the back button area
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 80), // Increased top padding
                  // Phone Input Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCountryCodeSelector(context), // Pass context
                      const SizedBox(width: 8),
                      buildPhoneNumberInput(),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Continue Button - Use Jordy Blue from theme
                  buildStyledButton(
                    onPressed: () {
                      if (_phoneController.text.length >= 6) {
                        HapticFeedback.heavyImpact();
                        context.go('/home');
                      } else {
                        HapticFeedback.mediumImpact();
                      }
                    },
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    elevation: 3.0,
                    child: Text(
                      'CONTINUE',
                      style: textTheme.labelLarge?.copyWith(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold, // Bold
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // "or" Separator
                  Row(
                    children: [
                      Expanded(child: Divider(color: colorScheme.outline.withOpacity(0.2), thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'or',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: colorScheme.outline.withOpacity(0.2), thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Social Login Buttons
                  buildSocialButton(
                    onPressed: () { /* TODO: Implement Apple Sign In */ },
                    icon: Icon(
                      Icons.apple,
                      color: colorScheme.onSurface,
                      size: 22,
                    ),
                    label: 'Continue with Apple',
                  ),
                  const SizedBox(height: 16),
                  buildSocialButton(
                    onPressed: () { /* TODO: Implement Google Sign In */ },
                    icon: SvgPicture.asset(
                      'assets/images/google_logo.svg',
                      width: 22,
                      height: 22,
                      colorFilter: ColorFilter.mode(colorScheme.onSurface, BlendMode.srcIn),
                      placeholderBuilder: (context) => Icon(
                        Icons.g_mobiledata,
                        color: colorScheme.onSurface,
                        size: 24,
                      ),
                    ),
                    label: 'Continue with Google',
                  ),
                  const SizedBox(height: 40),
                  // "or" Separator
                  Row(
                    children: [
                      Expanded(child: Divider(color: colorScheme.outline.withOpacity(0.2), thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'or',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: colorScheme.outline.withOpacity(0.2), thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Find My Account
                  TextButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      // TODO: Implement Find Account logic
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.onSurfaceVariant, // Less prominent text color
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          size: 22,
                          color: colorScheme.onSurfaceVariant, // Match text color
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Find my account',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: colorScheme.onSurfaceVariant, // Match icon color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Consent Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'By proceeding, you consent to get calls, Whatsapp or SMS/RCS messages, including by automated means, from XYZ and its affiliates to the number provided',
                      textAlign: TextAlign.center,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                        height: 1.4,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 120), // Ensure enough space at bottom for FAB
                ],
              ),
            ),
          ),
          // Positioned Back Button (FAB style)
          Positioned(
            left: 24,
            bottom: 30, // Adjust bottom padding
            child: SafeArea(
              child: FloatingActionButton(
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  if (context.canPop()) {
                    context.pop();
                  }
                },
                backgroundColor: colorScheme.surfaceContainerHighest,
                foregroundColor: colorScheme.onSurface,
                elevation: 4,
                shape: const CircleBorder(),
                child: const Icon(Icons.arrow_back_rounded, size: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 