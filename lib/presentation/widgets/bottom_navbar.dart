// lib/presentation/widgets/bottom_navbar.dart
import 'dart:ui'; // Import for ImageFilter
import 'package:flutter/material.dart';
// Remove go_router import if no longer needed here
// import 'package:go_router/go_router.dart';

/// A custom bottom navigation bar with a blurred, gradient background effect.
class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap; // Add onTap callback parameter

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap, // Make onTap required
  });

  // Remove internal navigation logic - handled by MainScreen
  /*
  void _onTap(BuildContext context, int index) {
    final currentLocation = GoRouterState.of(context).uri.toString();
    switch (index) {
      case 0: // Home
        if (currentLocation != '/home') context.go('/home');
        break;
      case 1: // Activity
        if (currentLocation != '/activity') print("Navigate to Activity (Route not implemented yet)");
        break;
      case 2: // Driver Profiles
        if (currentLocation != '/driver-profiles') print("Navigate to Driver Profiles (Route not implemented yet)");
        break;
      case 3: // Profile
        if (currentLocation != '/profile') print("Navigate to Profile (Route not implemented yet)");
        break;
      default:
        break;
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    // Use MediaQuery to respect bottom safe area padding
    final safePadding = MediaQuery.of(context).padding.bottom;

    // Define the navigation items data
    final items = [
      _NavBarItemData(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
      _NavBarItemData(icon: Icons.timeline_outlined, activeIcon: Icons.timeline, label: 'Activity'),
      _NavBarItemData(icon: Icons.badge_outlined, activeIcon: Icons.badge, label: 'Driver Profiles'),
      _NavBarItemData(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile'),
    ];

    // Height of the visual bar content
    const double barHeight = 65.0;

    // Remove ClipRect and BackdropFilter, apply styling directly to Container
    // return ClipRect( 
    //   child: BackdropFilter(
    //     filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0), 
    //     child: Container(
    return Container(
      // Total height includes bar height and safe area padding
      height: barHeight + safePadding,
      padding: EdgeInsets.only(bottom: safePadding), // Apply safe area padding only at the bottom
      // Use a semi-transparent background based on the theme background
      decoration: BoxDecoration(
        color: colorScheme.background.withOpacity(0.85), // Theme background, semi-transparent
        // Remove solid color from previous step
        // color: colorScheme.surface.withOpacity(0.90), 
        // Optional Gradient:
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [
        //     colorScheme.surface.withOpacity(0.80), // More transparent at top
        //     colorScheme.surface.withOpacity(0.95), // More opaque at bottom
        //   ],
        // ),
        // Optional subtle top border if needed
        // border: Border(
        //   top: BorderSide(color: colorScheme.outline.withOpacity(0.1), width: 0.5),
        // ),
      ),
      // Remove the inner color property, handled by decoration now
      // color: Colors.black.withOpacity(0.15), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center, // Center items vertically within barHeight
        children: List.generate(items.length, (index) {
          final item = items[index];
          final bool isActive = index == currentIndex;
          // Determine colors based on active state and theme
          final Color itemColor = isActive ? colorScheme.primary : (Colors.grey[600] ?? Colors.grey);

          return Expanded(
            child: InkWell( // Use InkWell for tap feedback
              // Call the provided onTap callback
              onTap: () => onTap(index),
              // Make splash/highlight transparent for a cleaner look
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container( // Ensure InkWell covers the full height for tap area
                 height: barHeight, // Fill the visual height
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isActive ? item.activeIcon : item.icon,
                      color: itemColor,
                      size: 26, // Icon size
                    ),
                    const SizedBox(height: 4), // Space between icon and label
                    Text(
                      item.label,
                      style: TextStyle(
                        color: itemColor,
                        fontSize: 10, // Small font size for label
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// Helper class to hold data for each navigation bar item
class _NavBarItemData {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  _NavBarItemData({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}