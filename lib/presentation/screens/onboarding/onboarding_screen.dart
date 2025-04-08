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

  // Define animations for different elements
  late Animation<double> _fadeHeaderAnimation;
  late Animation<Offset> _slideHeaderAnimation;

  late Animation<double> _fadeInputAnimation;
  late Animation<Offset> _slideInputAnimation;

  late Animation<double> _fadeContinueBtnAnimation;
  late Animation<Offset> _slideContinueBtnAnimation;

  late Animation<double> _fadeDivider1Animation; // New
  late Animation<Offset> _slideDivider1Animation; // New

  late Animation<double> _fadeSocial1Animation;
  late Animation<Offset> _slideSocial1Animation;

  late Animation<double> _fadeSocial2Animation;
  late Animation<Offset> _slideSocial2Animation;

  late Animation<double> _fadeDivider2Animation; // New
  late Animation<Offset> _slideDivider2Animation; // New

  late Animation<double> _fadeFooterAnimation;
  late Animation<Offset> _slideFooterAnimation;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // Adjusted duration if needed
    );

    // Define STAGGERED animations using Intervals
    _fadeHeaderAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.0, 0.4, curve: Curves.easeOut)),
    );
    _slideHeaderAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.0, 0.4, curve: Curves.easeOut)),
    );

    _fadeInputAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.1, 0.5, curve: Curves.easeOut)),
    );
    _slideInputAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.1, 0.5, curve: Curves.easeOut)),
    );

    _fadeContinueBtnAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.2, 0.6, curve: Curves.easeOut)),
    );
    _slideContinueBtnAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.2, 0.6, curve: Curves.easeOut)),
    );

    // Divider 1 Animation
    _fadeDivider1Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.25, 0.65, curve: Curves.easeOut)),
    );
    _slideDivider1Animation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.25, 0.65, curve: Curves.easeOut)),
    );

    _fadeSocial1Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.3, 0.7, curve: Curves.easeOut)),
    );
    _slideSocial1Animation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.3, 0.7, curve: Curves.easeOut)),
    );

    _fadeSocial2Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.35, 0.75, curve: Curves.easeOut)),
    );
    _slideSocial2Animation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.35, 0.75, curve: Curves.easeOut)),
    );

    // Divider 2 Animation
     _fadeDivider2Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.40, 0.80, curve: Curves.easeOut)),
    );
     _slideDivider2Animation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.40, 0.80, curve: Curves.easeOut)),
    );

    // Footer includes "Find account" and "Consent"
    _fadeFooterAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.45, 0.85, curve: Curves.easeOut)),
    );
    _slideFooterAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.45, 0.85, curve: Curves.easeOut)),
    );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Widget _buildCountryCodeSelector(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return SizedBox(
      height: 58,
      child: TapScaleEffect(
        onTap: () {
          HapticFeedback.mediumImpact();
          _showCountryPicker(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
            mainAxisAlignment: MainAxisAlignment.center,
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
        // Navigator.pop(context); // Removed as picker handles its own dismissal
      },
      countryListTheme: CountryListThemeData(
          backgroundColor: theme.colorScheme.surface,
          searchTextStyle: TextStyle(color: theme.colorScheme.onSurface),
          textStyle: TextStyle(color: theme.colorScheme.onSurface),
          bottomSheetHeight: MediaQuery.of(context).size.height * 0.7,
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
              fillColor: theme.colorScheme.surfaceContainerHighest, // Consider changing this color if needed
          ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    Widget _buildPhoneInput(BuildContext context) {
      return Expanded(
        child: TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
          decoration: const InputDecoration(
            hintText: 'Enter phone number',
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
      );
    }

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
      // Note: This custom button builder isn't currently used by ElevatedButtonTheme
      // It was kept from previous iterations but isn't needed if relying on theme
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // Theme now handles this
          foregroundColor: foregroundColor, // Theme now handles this
          minimumSize: Size(minWidth ?? double.infinity, minHeight ?? 56),
          padding: padding, // Theme now defines padding
          shape: RoundedRectangleBorder( // Theme now defines shape
            borderRadius: BorderRadius.circular(16),
            side: side ?? BorderSide.none,
          ),
          elevation: elevation,
          shadowColor: Colors.black.withOpacity(0.1),
        ),
        child: child,
      );
    }

    Widget buildSocialButton({
      required VoidCallback onPressed,
      required Widget icon,
      required String label,
      double opacity = 0.7,
    }) {
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;
      final textTheme = theme.textTheme;

      return TapScaleEffect(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: colorScheme.surface.withOpacity(opacity),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 24, height: 24, child: Center(child: icon)),
              const SizedBox(width: 12),
              Text(
                label,
                style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Add some top spacing if needed after removing logo
                 const SizedBox(height: 20), 

                // Input Row (Top Section)
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

                // Continue Button (Top Section)
                FadeTransition(
                  opacity: _fadeContinueBtnAnimation,
                  child: SlideTransition(
                    position: _slideContinueBtnAnimation,
                    child: Builder( // Use Builder to easily access controller state
                      builder: (context) {
                        final bool isEnabled = _phoneController.text.length >= 6;
                        return Opacity(
                          opacity: isEnabled ? 1.0 : 0.5, // Fade button slightly when disabled
                          child: TapScaleEffect( 
                            onTap: () { // Main logic remains here
                              if (isEnabled) {
                                HapticFeedback.heavyImpact();
                                context.go('/home');
                              } else {
                                HapticFeedback.mediumImpact(); // Still provide feedback on tap
                              }
                            },
                            child: ElevatedButton( 
                              // onPressed only handles haptics now, enabled state controls visual
                              onPressed: () => HapticFeedback.mediumImpact(), 
                              // Remove forced style, let theme + Opacity handle appearance
                              // style: ElevatedButton.styleFrom(...).merge(...), 
                              child: const Text('CONTINUE'),
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                ),
                 // Add significant spacing to push middle content down
                 const SizedBox(height: 60), 

                // --- Middle Section --- 
                // First Divider
                FadeTransition(
                  opacity: _fadeDivider1Animation,
                  child: SlideTransition(
                     position: _slideDivider1Animation,
                     child: _buildDivider(context),
                  ),
                 ),
                const SizedBox(height: 32),

                // Apple Button
                 FadeTransition(
                  opacity: _fadeSocial1Animation,
                  child: SlideTransition(
                    position: _slideSocial1Animation,
                    child: buildSocialButton(
                      onPressed: () { HapticFeedback.mediumImpact(); /* TODO */ },
                      icon: Icon(Icons.apple, color: colorScheme.onSurface, size: 26),
                      label: 'Continue with Apple',
                      opacity: 0.6,
                    ),
                  ),
                 ),
                const SizedBox(height: 16),

                // Google Button
                 FadeTransition(
                   opacity: _fadeSocial2Animation,
                   child: SlideTransition(
                     position: _slideSocial2Animation,
                     child: buildSocialButton(
                       onPressed: () { HapticFeedback.mediumImpact(); /* TODO */ },
                       icon: SvgPicture.asset('assets/images/google_logo.svg', width: 22, height: 22),
                       label: 'Continue with Google',
                       opacity: 0.6,
                     ),
                   ),
                 ),
                 // Add significant spacing to push footer content down
                 const SizedBox(height: 60),

                // --- Footer Section --- 
                // Second Divider
                FadeTransition(
                   opacity: _fadeDivider2Animation,
                   child: SlideTransition(
                     position: _slideDivider2Animation,
                     child: _buildDivider(context),
                   ),
                 ),
                const SizedBox(height: 24),

                // Find Account Button
                 FadeTransition(
                   opacity: _fadeFooterAnimation,
                   child: SlideTransition(
                     position: _slideFooterAnimation,
                     child: _buildFindAccount(context),
                   ),
                 ),
                const SizedBox(height: 24),

                // Consent Text
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
     // Add Padding for visual spacing and ensure it's not Expanded
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 40.0), // Adjust horizontal padding as needed
       child: Row(
         children: [
           Expanded(child: Divider(color: theme.colorScheme.outlineVariant, thickness: 1)),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16.0),
             child: Text('or', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
           ),
           Expanded(child: Divider(color: theme.colorScheme.outlineVariant, thickness: 1)),
         ],
       ),
     );
  }

  // Updated Find Account Button Builder
  Widget _buildFindAccount(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return TapScaleEffect( // Keep tap effect
      onTap: () {
        HapticFeedback.lightImpact();
        // TODO: Implement Find Account logic
      },
      child: Container( // Wrap with Container for styling
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Adjust padding
          decoration: BoxDecoration(
            color: colorScheme.surface.withOpacity(0.4), // Subtle background
            borderRadius: BorderRadius.circular(12),
             // Optional: Add subtle shadow for depth
             boxShadow: [
               BoxShadow(
                 color: Colors.black.withOpacity(0.1), 
                 blurRadius: 4,
                 offset: const Offset(0, 2),
               )
             ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center the row content
            mainAxisSize: MainAxisSize.min, // Row takes minimum space needed
            children: [
              Icon(
                Icons.search,
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                'Find my account',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
      ),
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
        textAlign: TextAlign.justify,
      ),
    );
  }
}