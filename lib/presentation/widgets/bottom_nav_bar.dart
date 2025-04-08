import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0; // Track the selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // TODO: Implement navigation logic based on index
    switch (index) {
      case 0:
        // Navigate to Home or handle Home tap
        print("Home tapped");
        break;
      case 1:
        // Navigate to Activity or handle Activity tap
        print("Activity tapped");
        break;
      case 2:
        // Navigate to Driver Profiles or handle Driver Profiles tap
        print("Driver Profiles tapped");
        break;
      case 3:
        // Navigate to Profile or handle Profile tap
        print("Profile tapped");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home), // Provide a different icon for the active state
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_car_outlined), // Example icon, replace if needed
          activeIcon: Icon(Icons.directions_car),
          label: 'Activity',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment_ind_outlined), // Example icon, replace if needed
          activeIcon: Icon(Icons.assignment_ind),
          label: 'Driver Profiles',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: colorScheme.primary, // Use primary color for selected item
      unselectedItemColor: colorScheme.onSurfaceVariant, // Use a muted color for unselected items
      onTap: _onItemTapped,
      showUnselectedLabels: true, // Ensure labels are always visible
      type: BottomNavigationBarType.fixed, // Use fixed type for 4 items
      backgroundColor: colorScheme.surface, // Set background color from theme
      elevation: 8.0, // Add some elevation
    );
  }
} 