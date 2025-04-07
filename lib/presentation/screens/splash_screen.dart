import 'package:flutter/material.dart';
import 'package:via_commuter/app/theme/colors.dart'; // adjust import as per your structure

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme; // Get ColorScheme

    return Scaffold(
      backgroundColor: colorScheme.background, // Use colorScheme.background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/via_logo.png',
              height: 100,
            ),
            const SizedBox(height: 20),
            Text(
              'a subscription-based ride booking service',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.secondary, // Use colorScheme.secondary
              ),
            ),
          ],
        ),
      ),
    );
  }
}
