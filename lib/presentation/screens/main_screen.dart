import 'package:flutter/material.dart';
import 'package:via_commuter/presentation/screens/activity_screen.dart';
import 'package:via_commuter/presentation/screens/driver_profiles_screen.dart';
import 'package:via_commuter/presentation/screens/home_screen.dart';
import 'package:via_commuter/presentation/screens/profile_screen.dart';
import 'package:via_commuter/presentation/widgets/bottom_navbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // List of screens corresponding to the bottom nav indices
  final List<Widget> _screens = [
    const HomeScreen(),
    const ActivityScreen(),
    const DriverProfilesScreen(),
    const ProfileScreen(),
  ];

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Handle back button press
      canPop: _currentIndex == 0, // Allow popping only if on the Home tab
      onPopInvoked: (didPop) {
        if (didPop) {
          return; // If already popped (because canPop was true), do nothing
        }
        // If not on the Home tab, switch to Home tab instead of popping
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
        }
      },
      child: Scaffold(
        // Allow body to extend behind the bottom navigation bar
        extendBody: true, 
        // Use IndexedStack to keep the state of each screen when switching tabs
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        // Pass the callback to the BottomNavBar
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onNavBarTap, // Pass the handler function
        ),
        // Remove the FloatingActionButton from here if it's specific to HomeScreen
        // floatingActionButton: ..., 
        // floatingActionButtonLocation: ..., 
      ),
    );
  }
} 