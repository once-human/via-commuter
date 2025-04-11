import 'dart:ui'; // Import for ImageFilter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For HapticFeedback
// Import the custom bottom nav bar
import 'package:via_commuter/presentation/widgets/bottom_navbar.dart'; // Adjust import path if needed

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    // Get screen width for responsive adjustments if needed
    // final screenWidth = MediaQuery.of(context).size.width;

    // --- Placeholder Data --- 
    // Changed to a list to handle multiple rides
    final List<Map<String, dynamic>> upcomingRidesList = [
      {
        'userName': "Khushi", 
        'date': "Today", // Added date field
        'pickupLocation': "Pickup: 123 Main St",
        'dropLocation': "Drop: Central Park",
        'pickupTime': "9:00 am", // Time only
        'dropTime': "10:00 am", // Time only
        'driverName': "Soham Thatte",
        'driverImageUrl': "", 
        'driverRating': 4.5,
        'otp': "OTP 1234",
        'vehicleModel': "Omni Van",
        'vehicleNumber': "KA 12 8091",
      },
      {
        'userName': "Khushi", 
        'date': "Tomorrow", // Changed date
        'pickupLocation': "Pickup: Tech Hub Tower",
        'dropLocation': "Drop: Galaxy Diner",
        'pickupTime': "2:00 PM", // Time only
        'dropTime': "2:45 PM", // Time only
        'driverName': "Onkar Yaglewad",
        'driverImageUrl': "", 
        'driverRating': 5.0, 
        'otp': "OTP 8888",
        'vehicleModel': "Flux Capacitor Express", 
        'vehicleNumber': "OUTATIME",
      },
    ];
    // Use the list to determine if there are rides
    final bool hasUpcomingRides = upcomingRidesList.isNotEmpty; 
    // Fetch userName once if possible
    final String userName = hasUpcomingRides ? upcomingRidesList[0]['userName'] : "User"; 
    // --- End Placeholder Data ---

    return Scaffold(
      backgroundColor: colorScheme.background, // Dark background
      body: CustomScrollView( // Use CustomScrollView for potential slivers later
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: MediaQuery.of(context).padding.top + 24), // Top safe area + padding
                
                // --- Greeting and Points --- 
                _buildGreeting(context, colorScheme, textTheme, userName), // Use fetched userName
                const SizedBox(height: 24),

                // --- Upcoming Ride Section Title --- 
                if (hasUpcomingRides)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0), // Add padding below title
                    child: Text(
                      'Upcoming Ride Details',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onBackground,
                      ),
                    ),
                  ),
                // if (hasUpcomingRides) const SizedBox(height: 16), // Padding moved above

                // --- Upcoming Ride Card(s) --- 
                // Map over the list to create cards
                ...upcomingRidesList.map((rideData) {
                  return Padding(
                    // Add padding below each card except the last?
                    // For now, add padding below all cards
                    padding: const EdgeInsets.only(bottom: 16.0), 
                    child: _buildUpcomingRideCard(context, colorScheme, textTheme, rideData),
                  );
                }).toList(),
                
                // Add significant padding at the bottom if using FAB
                if (hasUpcomingRides) SizedBox(height: 80 + kBottomNavigationBarHeight), 
              ]),
            ),
          ),
        ],
      ),
      // --- Floating Action Button --- 
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Position in center
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          HapticFeedback.lightImpact();
          // TODO: Navigate to booking screen
        },
        label: Text('Book New Ride', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.add),
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  // --- Helper Widgets --- 

  Widget _buildGreeting(BuildContext context, ColorScheme colorScheme, TextTheme textTheme, String userName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi $userName,',
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Ready for your ride today?',
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onBackground.withOpacity(0.7),
              ),
            ),
          ],
        ),
        Chip(
          avatar: CircleAvatar(
            backgroundColor: Colors.amber.shade700,
            child: const Icon(Icons.add, size: 16, color: Colors.white),
          ),
          label: Text('Points', style: textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
          backgroundColor: colorScheme.surfaceVariant.withOpacity(0.5),
          side: BorderSide.none,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
      ],
    );
  }

  // New Main Card Widget for a Single Ride
  Widget _buildUpcomingRideCard(BuildContext context, ColorScheme colorScheme, TextTheme textTheme, Map<String, dynamic> rideData) {
    return Card(
      elevation: 0,
      color: colorScheme.surfaceVariant.withOpacity(0.5), // Main card background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Ride Details (Simplified from previous card)
            _buildRideDetailsSection(context, colorScheme, textTheme, 
              rideData['date'], // Pass date
              rideData['pickupLocation'], rideData['dropLocation'], 
              rideData['pickupTime'], rideData['dropTime']
            ),
            const Divider(height: 32), // Divider between sections
            
            // Section 2: Driver Details + Actions
            _buildDriverDetailsSection(context, colorScheme, textTheme, 
              rideData['driverName'], rideData['driverImageUrl'], 
              rideData['driverRating'], rideData['otp'], 
              rideData['vehicleModel'], rideData['vehicleNumber']
            ),
            const SizedBox(height: 16), // Space before cancel button

            // Section 3: Cancel Button
            Center(
              child: TextButton.icon(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  // Show confirmation dialog
                  _showCancelConfirmationDialog(context);
                  // print('Cancel Ride Tapped'); // Replaced by dialog
                },
                icon: Icon(Icons.cancel_outlined, color: Colors.redAccent.shade100, size: 18),
                label: Text('Cancel Ride', style: TextStyle(color: Colors.redAccent.shade100)),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  // Add subtle highlight overlay
                  foregroundColor: Colors.redAccent.shade100, 
                  // overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  //   (Set<MaterialState> states) {
                  //     if (states.contains(MaterialState.pressed))
                  //       return Colors.redAccent.withOpacity(0.12);
                  //     return null; // Defer to the widget's default.
                  //   },
                  // ), << Incorrect application
                ).copyWith( // Apply overlayColor using copyWith
                   overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.redAccent.withOpacity(0.12);
                      }
                      return null; // Use the default overlay color otherwise
                    },
                  ),                 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for Ride Details Section within the main card
  Widget _buildRideDetailsSection(BuildContext context, ColorScheme colorScheme, TextTheme textTheme, String date, String pickup, String drop, String pickupTime, String dropTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date, // Display the date passed in
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurfaceVariant, 
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit_outlined, color: colorScheme.primary, size: 20),
              onPressed: () { HapticFeedback.lightImpact(); /* TODO: Edit action */ },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Using IntrinsicHeight to ensure columns have same height for alignment
        IntrinsicHeight(
          child: Row(
            children: [
              // Pickup Column
              Expanded(child: _buildLocationTimeColumn(context, colorScheme, Icons.location_on, pickup, pickupTime, isPickup: true)),
              const VerticalDivider(width: 32), // Divider between locations
              // Drop Column
              Expanded(child: _buildLocationTimeColumn(context, colorScheme, Icons.location_on, drop, dropTime, isDrop: true)),
            ],
          ),
        ),
      ],
    );
  }

  // Simplified column for location/time display
  Widget _buildLocationTimeColumn(BuildContext context, ColorScheme colorScheme, IconData icon, String location, String time, {bool isPickup = false, bool isDrop = false}) {
     return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out elements vertically
      children: [
        Row(
          children: [
            Icon(icon, color: isDrop ? Colors.redAccent : colorScheme.primary, size: 20),
            const SizedBox(width: 8),
            // Allow location text to wrap if needed
            Flexible(child: Text(location, style: TextStyle(color: colorScheme.onSurfaceVariant), overflow: TextOverflow.ellipsis, maxLines: 2)),
          ],
        ),
        // Add vertical space - adjust as needed
        const Spacer(), 
        const SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.access_time, color: colorScheme.onSurfaceVariant.withOpacity(0.7), size: 16),
            const SizedBox(width: 6), // Reduced spacing to fix overflow
            // Wrap time in Flexible to prevent overflow even if time format changes
            Flexible(child: Text(time, style: TextStyle(color: colorScheme.onSurfaceVariant.withOpacity(0.9)), overflow: TextOverflow.ellipsis)),
          ],
        ),
      ],
    );
  }

  // Helper for Driver Details Section within the main card (includes contact buttons)
  Widget _buildDriverDetailsSection(BuildContext context, ColorScheme colorScheme, TextTheme textTheme, String name, String imageUrl, double rating, String otp, String vehicleModel, String vehicleNumber) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Align tops
      children: [
        // Left Side: Driver Info + Contact Actions
        Expanded(
          flex: 3, // Give more space to left side
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Driver Details', style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant.withOpacity(0.7))), 
              const SizedBox(height: 8),
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: colorScheme.primaryContainer,
                    child: Icon(Icons.person, color: colorScheme.onPrimaryContainer), // Placeholder
                  ),
                  const SizedBox(width: 12),
                  // Flexible to prevent overflow if name is long
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurfaceVariant), overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        Row(
                          children: List.generate(5, (index) => Icon(
                            index < rating.floor() ? Icons.star : (index < rating ? Icons.star_half : Icons.star_border),
                            color: Colors.amber,
                            size: 18,
                          )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12), // Space before contact buttons
              // Contact Buttons moved here
              Row(
                children: [
                  _buildContactButton(context, Icons.phone_outlined, colorScheme),
                  const SizedBox(width: 12),
                  _buildContactButton(context, Icons.message_outlined, colorScheme),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 16), // Space between left and right columns
        
        // Right Side: OTP & Vehicle
        Expanded(
          flex: 2, // Give less space to right side
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start, // Align top
            children: [
              Text(otp, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurfaceVariant)),
              const SizedBox(height: 4),
              Text(vehicleModel, style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
              const SizedBox(height: 4),
              Text(vehicleNumber, style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
            ],
          ),
        ),
      ],
    );
  }

  // Unchanged Contact Button Helper
  Widget _buildContactButton(BuildContext context, IconData icon, ColorScheme colorScheme) {
    return ElevatedButton(
      onPressed: () { HapticFeedback.lightImpact(); },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
        backgroundColor: colorScheme.surfaceVariant.withOpacity(0.5),
        foregroundColor: colorScheme.onSurfaceVariant,
        elevation: 0,
      ),
      child: Icon(icon, size: 20),
    );
  }

  // --- Add Confirmation Dialog --- 
  Future<void> _showCancelConfirmationDialog(BuildContext context) async {
    final theme = Theme.of(context);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: theme.colorScheme.surfaceVariant,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Cancel Ride?', style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to cancel this ride?', style: TextStyle(color: theme.colorScheme.onSurfaceVariant.withOpacity(0.8))),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('No', style: TextStyle(color: theme.colorScheme.primary)),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.redAccent.shade100),
              child: const Text('Yes, Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss the dialog
                // TODO: Add actual ride cancellation logic here!
                print('Ride Cancelled!'); 
                // Optional: Show a snackbar confirmation
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Ride cancelled'),
                    backgroundColor: Colors.redAccent.shade100,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  // Helper method to build styled dummy ride list tiles (No longer needed for this design)
  /* Widget _buildDummyRideTile(...) { ... } */
} 