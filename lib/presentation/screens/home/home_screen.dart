import 'dart:ui'; // Import for ImageFilter
import 'package:flutter/material.dart';
// Import the custom bottom nav bar
import 'package:via_commuter/presentation/widgets/bottom_navbar.dart'; // Adjust import path if needed

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Use a slightly darker background for better contrast with glass effect
    return Scaffold(
      backgroundColor: colorScheme.background.withOpacity(0.95), // Darker background
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: colorScheme.onSurface), // Ensure title is visible
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent, // Keep app bar transparent
        elevation: 0,
        flexibleSpace: ClipRRect( // Apply clipping for potential rounding
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              // Slightly more opaque surface for app bar
              color: colorScheme.surface.withOpacity(0.2), 
              // Optional: Add border if needed
              // decoration: BoxDecoration(
              //   border: Border(bottom: BorderSide(color: colorScheme.outline.withOpacity(0.2))),
              // ),
            ),
          ),
        ),
      ),
      extendBody: true, // Extend body behind AppBar and BottomNavBar
      extendBodyBehindAppBar: true, // Ensure body goes behind AppBar
      body: SafeArea( // SafeArea handles notches and system bars
        bottom: false, // Don't apply bottom padding, handled by BottomNavBar spacing
        child: Padding(
          // Adjust top padding to account for AppBar height + extra space
          padding: EdgeInsets.only(
            top: kToolbarHeight + MediaQuery.of(context).padding.top + 16.0, 
            left: 16.0, 
            right: 16.0,
            // No bottom padding here, let content scroll behind nav bar
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // No top SizedBox needed, handled by padding
              Text(
                'Good morning!',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface, // Ensure text visibility
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Here are your upcoming rides',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 16), // Reduced spacing before card
              // Glassmorphism container for rides list
              Expanded(
                child: ClipRRect( // Clip for rounded corners
                  borderRadius: BorderRadius.circular(24.0), // Slightly more rounded corners
                  child: BackdropFilter( // Apply blur effect
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Increased blur slightly
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0), // Padding for the list items
                      // Semi-transparent background with subtle border
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceVariant.withOpacity(0.2), // Keep opacity
                        borderRadius: BorderRadius.circular(24.0), // Match ClipRRect
                        border: Border.all(
                          color: colorScheme.outline.withOpacity(0.15), // Subtle border
                          width: 1,
                        ),
                      ),
                      // Replace Center with a ListView containing dummy data
                      child: ListView(
                        padding: EdgeInsets.zero, // Remove default ListView padding
                        children: [
                          _buildDummyRideTile(context, 
                            icon: Icons.location_on_outlined,
                            title: '123 Main St, Anytown',
                            subtitle: 'Today, 4:30 PM - John D.',
                            colorScheme: colorScheme,
                          ),
                          Divider(height: 1, thickness: 0.5, indent: 16, endIndent: 16, color: colorScheme.outline.withOpacity(0.2)),
                          _buildDummyRideTile(context, 
                            icon: Icons.work_outline, 
                            title: 'Office Complex B',
                            subtitle: 'Tomorrow, 9:00 AM - Sarah K.',
                            colorScheme: colorScheme,
                          ),
                          Divider(height: 1, thickness: 0.5, indent: 16, endIndent: 16, color: colorScheme.outline.withOpacity(0.2)),
                          _buildDummyRideTile(context, 
                            icon: Icons.local_airport_outlined, 
                            title: 'Anytown International Airport',
                            subtitle: 'Wed, 11:15 AM - Michael P.',
                            colorScheme: colorScheme,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Add padding at the bottom to prevent content from hiding behind nav bar
              SizedBox(height: kBottomNavigationBarHeight + 32), // Increased bottom padding slightly 
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  // Helper method to build styled dummy ride list tiles
  Widget _buildDummyRideTile(BuildContext context, {required IconData icon, required String title, required String subtitle, required ColorScheme colorScheme}) {
    return ListTile(
      leading: Icon(icon, color: colorScheme.primary, size: 28),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface, // Ensure visibility
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: colorScheme.onSurface.withOpacity(0.7), // Slightly faded subtitle
        ),
      ),
      // Optional: Add trailing info if needed
      // trailing: Icon(Icons.chevron_right, color: colorScheme.onSurface.withOpacity(0.5)),
    );
  }
} 