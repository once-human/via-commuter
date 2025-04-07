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

    // Wrap with TapScaleEffect
    return TapScaleEffect(
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
      // Wrap the ElevatedButton's child logic with TapScaleEffect
      // NOTE: We wrap the *button itself* later when we call this builder
      return ElevatedButton(
        onPressed: onPressed, // Haptics/logic handled where button is used
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          minimumSize: Size(minWidth ?? double.infinity, minHeight ?? 56),
          padding: EdgeInsets.zero, // Padding applied inside TapScaleEffect child
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: side ?? BorderSide.none,
          ),
          elevation: elevation,
          shadowColor: Colors.black.withOpacity(0.15),
        ),
        // The actual content passed to the button
        child: Padding(padding: padding, child: child),
      );
    }

    // Updated buildSocialButton
    Widget buildSocialButton({
      required VoidCallback onPressed,
      required Widget icon,
      required String label,
    }) {
      // The button built here will be wrapped later
      return buildStyledButton(
        onPressed: onPressed, // Pass the original callback
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        padding: const EdgeInsets.symmetric(vertical: 16),
        minHeight: 52,
        side: BorderSide(
          color: colorScheme.outline.withOpacity(0.15),
          width: 1,
        ),
        elevation: 1.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 24, height: 24, child: icon),
            const SizedBox(width: 12),
            Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
                fontSize: 15,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              // Remove the overall Fade/Slide transition from here
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 80),
                  // Wrap Input Row with its animation
                  FadeTransition(
                    opacity: _fadeInputAnimation,
                    child: SlideTransition(
                      position: _slideInputAnimation,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCountryCodeSelector(context),
                          const SizedBox(width: 8),
                          buildPhoneNumberInput(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Continue Button Animation
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
                  const SizedBox(height: 30),
                  // "or" Separator - Apply footer animation (or a separate one if needed)
                  FadeTransition(
                    opacity: _fadeFooterAnimation, // Reuse footer or create specific one
                    child: SlideTransition(
                      position: _slideFooterAnimation,
                      child: Row(
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
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Social Button 1 Animation
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
                          size: 22,
                        ),
                        label: 'Continue with Apple',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Social Button 2 Animation
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
                          colorFilter: ColorFilter.mode(colorScheme.onSurface, BlendMode.srcIn),
                          placeholderBuilder: (context) => Icon(
                            Icons.g_mobiledata,
                            color: colorScheme.onSurface,
                            size: 24,
                          ),
                        ),
                        label: 'Continue with Google',
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // "or" Separator - Apply footer animation
                  FadeTransition(
                    opacity: _fadeFooterAnimation,
                    child: SlideTransition(
                      position: _slideFooterAnimation,
                      child: Row(
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
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Find Account & Consent Animation Group
                  FadeTransition(
                    opacity: _fadeFooterAnimation,
                    child: SlideTransition(
                      position: _slideFooterAnimation,
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              // TODO: Implement Find Account logic
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: colorScheme.onSurfaceVariant,
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
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Find my account',
                                  style: textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
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
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
          // Positioned Back Button (FAB style)
          Positioned(
            left: 24,
            bottom: 30,
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