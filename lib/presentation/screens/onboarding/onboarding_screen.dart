import 'dart:ui'; // For BackdropFilter
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart'; // Import country_picker
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg

// New TapScaleEffect Widget
class TapScaleEffect extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const TapScaleEffect({super.key, required this.child, this.onTap});

  @override
  State<TapScaleEffect> createState() => _TapScaleEffectState();
}

class _TapScaleEffectState extends State<TapScaleEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100), // Quick press down
      reverseDuration: const Duration(milliseconds: 150), // Slightly slower release
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap?.call();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
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

  // Animation Controller for entrance animations
  late AnimationController _entranceController;
  // Remove single animations
  // late Animation<double> _fadeAnimation;
  // late Animation<Offset> _slideAnimation;

  // Define animations for different elements
  late Animation<double> _fadeHeaderAnimation;
  late Animation<Offset> _slideHeaderAnimation;

  late Animation<double> _fadeInputAnimation;
  late Animation<Offset> _slideInputAnimation;

  late Animation<double> _fadeContinueBtnAnimation;
  late Animation<Offset> _slideContinueBtnAnimation;

  late Animation<double> _fadeSocial1Animation;
  late Animation<Offset> _slideSocial1Animation;

  late Animation<double> _fadeSocial2Animation;
  late Animation<Offset> _slideSocial2Animation;

  late Animation<double> _fadeFooterAnimation;
  late Animation<Offset> _slideFooterAnimation;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      // Increase duration slightly to accommodate staggering
      duration: const Duration(milliseconds: 800),
    );

    // Define STAGGERED animations using Intervals
    // Intervals define the portion of the controller's duration each animation runs

    // Header (Implicit - if we add one later)
    _fadeHeaderAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );
     _slideHeaderAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _entranceController,
         curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    // Input Row (Phone number + Country code)
    _fadeInputAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.1, 0.5, curve: Curves.easeOut), // Starts slightly after header
      ),
    );
    _slideInputAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.1, 0.5, curve: Curves.easeOut),
      ),
    );

    // Continue Button
    _fadeContinueBtnAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.2, 0.6, curve: Curves.easeOut), // Starts after input
      ),
    );
     _slideContinueBtnAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _entranceController,
         curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
      ),
    );

     // Social Button 1 (Apple)
    _fadeSocial1Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
      ),
    );
     _slideSocial1Animation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _entranceController,
         curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
      ),
    );

     // Social Button 2 (Google)
    _fadeSocial2Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.35, 0.75, curve: Curves.easeOut), // Slightly after Apple
      ),
    );
     _slideSocial2Animation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _entranceController,
         curve: const Interval(0.35, 0.75, curve: Curves.easeOut),
      ),
    );

    // Footer elements (Find account, consent text)
     _fadeFooterAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.45, 0.85, curve: Curves.easeOut),
      ),
    );
     _slideFooterAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _entranceController,
         curve: const Interval(0.45, 0.85, curve: Curves.easeOut),
      ),
    );

    // Start the main animation controller
    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose(); // Dispose the controller
    _phoneController.dispose();
    super.dispose();
  }

  // Updated buildCountryCodeSelector
  Widget _buildCountryCodeSelector(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Wrap with SizedBox to enforce height matching the TextField
    return SizedBox(
      height: 58, // Explicit height to match TextField based on theme padding
      child: TapScaleEffect(
        onTap: () {
          HapticFeedback.mediumImpact();
          _showCountryPicker(context);
        },
        child: Container(
          // Keep existing padding for internal content alignment
          padding: const EdgeInsets.symmetric(horizontal: 16), // Vertical padding removed as height is fixed
          decoration: BoxDecoration(
            color: colorScheme.surface.withOpacity(0.7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
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
      ),
    );
  }

  // Updated _showCountryPicker using country_picker package
  void _showCountryPicker(BuildContext context) {
    final theme = Theme.of(context);
    showCountryPicker(
      context: context,
      favorite: ['IN', 'US', 'GB'],
      showPhoneCode: true,
      onSelect: (Country country) {
        HapticFeedback.mediumImpact();
        setState(() {
          _selectedCountry = country;
          _selectedCountryCode = '+${country.phoneCode}';
        });
      },
      // Use the correct parameter name and provide standard theme data
      countryListTheme: CountryListThemeData(
          backgroundColor: theme.colorScheme.surface, // Use surface color for sheet bg
          searchTextStyle: TextStyle(color: theme.colorScheme.onSurface),
          textStyle: TextStyle(color: theme.colorScheme.onSurface),
          bottomSheetHeight: MediaQuery.of(context).size.height * 0.7,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          // Keep input decoration styling
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
      ),
      // REMOVE the custom bottomSheetBuilder
      // bottomSheetBuilder: (context) { ... }, 
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Updated buildPhoneInput
    Widget _buildPhoneInput(BuildContext context) {
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;
      // No longer need explicit border radius or fill color here,
      // it will inherit from the theme's InputDecorationTheme
      return Expanded(
        child: TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w500, // Medium
          ),
          decoration: InputDecoration(
            hintText: 'Enter phone number',
            // Remove explicit decoration properties, inherit from theme
            // fillColor: colorScheme.surface.withOpacity(0.7),
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(16),
            //   borderSide: BorderSide.none,
            // ),
            // filled: true,
          ),
          onChanged: (value) {
            setState(() {
              // Basic validation logic could go here if needed
            });
          },
        ),
      );
    }

    // Updated buildStyledButton
    ElevatedButton buildStyledButton({
      required VoidCallback onPressed,
      required Widget child,
      required Color backgroundColor,
      required Color foregroundColor,
      double? minWidth,
      double? minHeight,
      EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 18),
      BorderSide? side,
      double elevation = 2.0,
    }) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor.withOpacity(backgroundColor == colorScheme.surface ? 0.85 : 1.0),
          foregroundColor: foregroundColor,
          minimumSize: Size(minWidth ?? double.infinity, minHeight ?? 56),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: side ?? BorderSide.none,
          ),
          elevation: elevation,
          shadowColor: Colors.black.withOpacity(0.1),
        ),
        child: Padding(padding: padding, child: child),
      );
    }

    // Updated buildSocialButton
    Widget buildSocialButton({
      required VoidCallback onPressed,
      required Widget icon,
      required String label,
      double opacity = 0.7, // Default opacity if not provided
    }) {
      return TapScaleEffect(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16), // Keep consistent vertical padding
          decoration: BoxDecoration(
            color: colorScheme.surface.withOpacity(opacity), // Use passed opacity
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 22, height: 22, child: Center(child: icon)),
              const SizedBox(width: 12),
              Text(
                label,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FadeTransition(
                  opacity: _fadeHeaderAnimation,
                  child: SlideTransition(
                    position: _slideHeaderAnimation,
                    child: Text(
                      'VIA',
                      style: theme.textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 64, // Reduce font size slightly
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                FadeTransition(
                  opacity: _fadeInputAnimation,
                  child: SlideTransition(
                    position: _slideInputAnimation,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCountryCodeSelector(context),
                        const SizedBox(width: 8),
                        _buildPhoneInput(context),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeTransition(
                  opacity: _fadeContinueBtnAnimation,
                  child: SlideTransition(
                    position: _slideContinueBtnAnimation,
                    child: buildStyledButton(
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
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                _buildDivider(context),
                const SizedBox(height: 32),
                FadeTransition(
                  opacity: _fadeSocial1Animation,
                  child: SlideTransition(
                    position: _slideSocial1Animation,
                    child: buildSocialButton(
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        // TODO: Implement Apple Sign In
                      },
                      icon: Icon(
                        Icons.apple,
                        color: colorScheme.onSurface,
                        size: 26,
                      ),
                      label: 'Continue with Apple',
                      opacity: 0.6, // Slightly reduced opacity for social buttons
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FadeTransition(
                  opacity: _fadeSocial2Animation,
                  child: SlideTransition(
                    position: _slideSocial2Animation,
                    child: buildSocialButton(
                      onPressed: () {
                         HapticFeedback.mediumImpact();
                        // TODO: Implement Google Sign In
                      },
                      icon: SvgPicture.asset(
                        'assets/images/google_logo.svg',
                        width: 22,
                        height: 22,
                        placeholderBuilder: (context) => Icon(
                          Icons.g_mobiledata,
                          color: colorScheme.onSurface,
                          size: 24,
                        ),
                      ),
                      label: 'Continue with Google',
                      opacity: 0.6, // Slightly reduced opacity for social buttons
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                _buildDivider(context),
                const SizedBox(height: 24),
                FadeTransition(
                  opacity: _fadeFooterAnimation,
                  child: SlideTransition(
                    position: _slideFooterAnimation,
                    child: _buildConsentText(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final theme = Theme.of(context);
    return Divider(
      color: theme.colorScheme.outlineVariant,
      thickness: 1,
    );
  }

  Widget _buildConsentText(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'By proceeding, you consent to get calls, Whatsapp or SMS/RCS messages, including by automated means, from XYZ and its affiliates to the number provided',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          height: 1.4,
        ),
        textAlign: TextAlign.start, // Left-align consent text
      ),
    );
  }
} 