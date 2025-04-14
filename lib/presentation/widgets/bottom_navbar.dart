// lib/presentation/widgets/bottom_navbar.dart
import 'dart:ui'; // Import for ImageFilter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Correct import for HapticFeedback
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
    final textTheme = theme.textTheme;
    final safePadding = MediaQuery.of(context).padding.bottom;

    // Define the navigation items data
    final items = [
      _NavBarItemData(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
      _NavBarItemData(icon: Icons.timeline_outlined, activeIcon: Icons.timeline, label: 'Activity'),
      _NavBarItemData(icon: Icons.badge_outlined, activeIcon: Icons.badge, label: 'Drivers'),
      _NavBarItemData(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile'),
    ];

    const double itemHeight = 56.0; // Height for each item tap area
    const double verticalPadding = 8.0; // Padding inside the floating bar
    final BorderRadius borderRadius = BorderRadius.circular(28);
    final double containerHeight = itemHeight + (verticalPadding * 2);

    // Wrap the entire widget in a RepaintBoundary for optimization
    return RepaintBoundary(
      child: Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 6 + safePadding), // Keep reduced padding
        child: ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            // Restore strong blur radius
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Strong blur
            child: Container(
              height: containerHeight, 
              decoration: BoxDecoration(
                // Use a lighter surface color with high opacity
                // Try surfaceContainerHigh first, fallback to surfaceContainer if needed
                color: colorScheme.surfaceContainerHigh.withOpacity(0.90), 
                borderRadius: borderRadius, 
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15), 
                    blurRadius: 10, 
                    spreadRadius: 0, 
                    offset: const Offset(0, 1), 
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch, // Items fill height
                children: List.generate(items.length, (index) {
                  final item = items[index];
                  final bool isActive = index == currentIndex;
                  final Color activeColor = colorScheme.primary;
                  final Color inactiveColor = colorScheme.onSurfaceVariant;
                  final Color indicatorColor = colorScheme.secondaryContainer;

                  return Expanded(
                    child: InkWell(
                      onTap: () {
                        HapticFeedback.lightImpact(); 
                        onTap(index);
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isActive ? indicatorColor : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              item.icon, 
                              color: isActive ? activeColor : inactiveColor,
                              size: 24, 
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.label,
                            style: textTheme.labelSmall?.copyWith(
                              color: isActive ? activeColor : inactiveColor,
                              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
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