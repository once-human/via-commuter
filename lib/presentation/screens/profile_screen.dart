import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
            onPressed: () {
              // Navigate to settings screen
              context.push('/settings'); // Assuming you have a route named '/settings'
            },
          ),
        ],
      ),
      body: Center(
        // Wrap content in a Column to add the button
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            const Text('Profile Screen'), // Keep existing content
            const SizedBox(height: 32), // Add spacing
            ElevatedButton.icon(
              icon: const Icon(Icons.replay_outlined),
              label: const Text('Revisit Onboarding'),
              onPressed: () {
                // Navigate back to the onboarding screen
                context.go('/onboarding'); // Assuming '/onboarding' is your route
              },
            ),
          ],
        ),
      ),
    );
  }
} 