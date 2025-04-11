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
    const String userName = "Khushi";
    const String points = "+"; // Placeholder for points icon/value
    const String pickupLocation = "Pickup: location";
    const String dropLocation = "Drop: Location";
    const String pickupTime = "9:00 am";
    const String dropTime = "10:00 am";
    const String driverName = "Soham Thatte";
    const String driverImageUrl = ""; // Placeholder - use asset or network
    const double driverRating = 4.5;
    const String otp = "OTP 1234";
    const String vehicleModel = "Omni Van";
    const String vehicleNumber = "KA 12 8091";
    // --- End Placeholder Data ---

    return Scaffold(
      backgroundColor: colorScheme.background, // Dark background
      // No AppBar in this design
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 24), // Top safe area + padding
              
              // --- Greeting and Points --- 
              Row(
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
                      backgroundColor: Colors.amber.shade700, // Use a color for the plus
                      child: const Icon(Icons.add, size: 16, color: Colors.white), // Replace with image if needed
                    ),
                    label: Text('Points', style: textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                    backgroundColor: colorScheme.surfaceVariant.withOpacity(0.5),
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // --- Illustration Placeholder --- 
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceVariant.withOpacity(0.3), // Placeholder color
                  borderRadius: BorderRadius.circular(16),
                  // TODO: Replace with actual Image asset
                ),
                child: const Center(child: Text('Illustration Placeholder', style: TextStyle(color: Colors.grey))), // Placeholder text
              ),
              const SizedBox(height: 32),

              // --- Upcoming Ride Title --- 
              Text(
                'Upcoming Ride Details',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 16),

              // --- Ride Details Card --- 
              _buildRideDetailsCard(context, colorScheme, textTheme, pickupLocation, dropLocation, pickupTime, dropTime),
              const SizedBox(height: 24),

              // --- Driver Details Card --- 
              _buildDriverDetailsCard(context, colorScheme, textTheme, driverName, driverImageUrl, driverRating, otp, vehicleModel, vehicleNumber),
              const SizedBox(height: 24),

              // --- Contact Driver Section --- 
              Row(
                children: [
                  Text(
                    'Contact Driver :',
                    style: textTheme.bodyMedium?.copyWith(color: colorScheme.onBackground.withOpacity(0.7)),
                  ),
                  const Spacer(),
                  _buildContactButton(context, Icons.phone_outlined, colorScheme),
                  const SizedBox(width: 12),
                  _buildContactButton(context, Icons.message_outlined, colorScheme),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      // TODO: Implement Cancel Ride action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.shade200,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text('Cancel Ride'),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // --- Book New Ride Button --- 
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    // TODO: Implement Book New Ride action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primaryContainer, // Light blue color from image
                    foregroundColor: colorScheme.onPrimaryContainer,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    minimumSize: const Size(double.infinity, 50), // Full width, fixed height
                  ),
                  child: Text('Book New Ride', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: kBottomNavigationBarHeight + 32), // Padding below button before nav bar
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  // --- Helper Widgets --- 

  Widget _buildRideDetailsCard(BuildContext context, ColorScheme colorScheme, TextTheme textTheme, String pickup, String drop, String pickupTime, String dropTime) {
    return Card(
      elevation: 0, // No shadow
      color: colorScheme.surfaceVariant.withOpacity(0.5), // Card background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurfaceVariant, 
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit_outlined, color: colorScheme.primary, size: 20),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    // TODO: Implement Edit action
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildLocationColumn(context, colorScheme, Icons.location_on, Icons.more_vert, pickup, pickupTime),
                const SizedBox(width: 16),
                _buildLocationColumn(context, colorScheme, Icons.location_on, null, drop, dropTime, isDrop: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationColumn(BuildContext context, ColorScheme colorScheme, IconData startIcon, IconData? connectorIcon, String location, String time, {bool isDrop = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(startIcon, color: isDrop ? Colors.redAccent : colorScheme.primary, size: 20),
            const SizedBox(width: 8),
            Text(location, style: TextStyle(color: colorScheme.onSurfaceVariant)),
          ],
        ),
        if (connectorIcon != null) 
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4, bottom: 4), // Adjust alignment
            child: Icon(connectorIcon, color: colorScheme.onSurfaceVariant.withOpacity(0.5), size: 18), // Vertical dots
          ),
        if (connectorIcon == null) const SizedBox(height: 26), // Spacer for alignment if no connector
        Row(
          children: [
            // Invisible icon for alignment unless it's the drop pin 
            Icon(isDrop ? (startIcon) : null, color: isDrop ? Colors.transparent : Colors.transparent, size: 20),
            const SizedBox(width: 8),
            Icon(Icons.access_time, color: colorScheme.onSurfaceVariant.withOpacity(0.7), size: 16),
            const SizedBox(width: 8),
            Text(time, style: TextStyle(color: colorScheme.onSurfaceVariant.withOpacity(0.9))),
          ],
        ),
      ],
    );
  }

  Widget _buildDriverDetailsCard(BuildContext context, ColorScheme colorScheme, TextTheme textTheme, String name, String imageUrl, double rating, String otp, String vehicleModel, String vehicleNumber) {
    return Card(
      elevation: 0,
      color: colorScheme.surfaceVariant.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Left Side: Driver Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Driver Details', style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant.withOpacity(0.7))), // Implicit title
                const SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: colorScheme.primaryContainer,
                      // TODO: Replace backgroundImage with actual image
                      // backgroundImage: NetworkImage(imageUrl), 
                      child: Icon(Icons.person, color: colorScheme.onPrimaryContainer), // Placeholder
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurfaceVariant)),
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
                  ],
                ),
              ],
            ),
            const Spacer(),
            // Right Side: OTP & Vehicle
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(otp, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurfaceVariant)),
                const SizedBox(height: 4),
                Text(vehicleModel, style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                const SizedBox(height: 4),
                Text(vehicleNumber, style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
              ],
            ),
          ],
        ),
      ),
    );
  }

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

  // Helper method to build styled dummy ride list tiles (No longer needed for this design)
  /* Widget _buildDummyRideTile(...) { ... } */
} 