import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For HapticFeedback
import 'package:via_commuter/presentation/widgets/bottom_navbar.dart'; // Adjust import path if needed

class HomeScreen extends StatelessWidget {
  // Add const constructor for the StatelessWidget itself
  const HomeScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> upcomingRides = [
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
];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
              delegate: SliverChildListDelegate([
                // Cannot be const due to MediaQuery
                SizedBox(height: MediaQuery.of(context).padding.top + 24),

                // --- Greeting and Points ---
                _buildGreeting(context, colorScheme, textTheme,
                    userName), // Cannot be const (needs context/theme)
                const SizedBox(height: 24),

                // --- Upcoming Ride Section Title ---
                if (hasUpcomingRides)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Upcoming Ride Details',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ]),
            ),
            // --- Upcoming Rides List ---
            if (hasUpcomingRides)
              SliverList.builder(
                itemCount: upcomingRides.length,
                itemBuilder: (context, index) {
                  final rideData = upcomingRides[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _buildUpcomingRideCard(
                        context, colorScheme, textTheme, rideData),
                  );
                },
              ),
            SliverList(
              delegate: SliverChildListDelegate([
                // --- Add Test Builds Button ---
                const SizedBox(height: 24),
                Center(
                  child: _buildTestBuildButton(context, colorScheme),
                ),
                const SizedBox(height: 16),
                SizedBox(height: 80 + kBottomNavigationBarHeight),
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
          // TODO: Navigate to booking screen : Navigate to booking screen
    

  Widget _buildTestBuildButton(BuildContext context, ColorScheme colorScheme) {
    return OutlinedButton.icon(
        icon: const Icon(Icons.science_outlined, size: 18),
        label: const Text('View Test Builds'),
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.secondary,
          side: BorderSide(color: colorScheme.secondary.withOpacity(0.5)),
        ),
        icon: const Icon(Icons.add), // Can be const
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0), // Already const
    );
  }
        label: const Text('Book New Ride'),
  // --- Helper Widgets --- 


        onPressed: () {
          HapticFeedback.lightImpact();
          // TODO: Implement test builds action
  Widget _buildGreeting(BuildContext context, ColorScheme colorScheme, TextTheme textTheme, String userName) {
    // ... inside _buildGreeting ...
            ),
            const SizedBox(height: 4), // Can be const
            Text(
              'Ready for your ride today?',
              style: textTheme.bodyLarge?.copyWith(
                // ... inside _buildGreeting ...
        Chip(
          avatar: CircleAvatar(
            backgroundColor: Colors.amber.shade700,
            child: const Icon(Icons.add, size: 16, color: Colors.white), // Can be const
          ),
          label: Text('Points', style: textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
          backgroundColor: colorScheme.surfaceVariant.withOpacity(0.5),
          side: BorderSide.none, // BorderSide.none is const
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Can be const
        ),
      ],
    );
  }

  // New Main Card Widget for a Single Ride
  Widget _buildUpcomingRideCard(BuildContext context, ColorScheme colorScheme,
      TextTheme textTheme, Map<String, dynamic> rideData) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            child: _buildRideDetailsSection(
                context,
                colorScheme,
                textTheme,
                rideData['date'],
                rideData['pickupLocation'],
                rideData['drop'],
                rideData['pickupTime'],
                rideData['dropTime']),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildDriverDetailsSection(
                context,
                 colorScheme,
                textTheme,
                rideData['driverName'],
                rideData['driverImage'],
                rideData['driverRating'],
                rideData['otp'],
                rideData['vehicleModel'],
                rideData['vehicleNumber']),
          ),
          _buildCancelButton(context),
        ],
      ),
    );
  }
  Widget _buildCancelButton(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: TextButton.icon(
          onPressed: () {
            HapticFeedback.lightImpact();
            _showCancelConfirmationDialog(context);
          },
          icon: const Icon(Icons.cancel_outlined,
              color: Colors.redAccent, size: 18),
          label: const Text('Cancel Ride',
              style: TextStyle(color: Colors.redAccent)),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            foregroundColor: Colors.redAccent,
          ).copyWith(
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return Colors.redAccent.withOpacity(0.04);
                }
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed)) {
                  return Colors.redAccent.withOpacity(0.12);
                }
                return null;
              },
            ),
          ),
        ),
      ),
    );
  }

  // Helper for Ride Details Section within the main card
  Widget _buildRideDetailsSection(
      BuildContext context,
      ColorScheme colorScheme,
      TextTheme textTheme,
      String date,
      String pickup,
      String drop,
      String pickupTime,
      String dropTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
               date,
              style: textTheme.titleMedium
                  ?.copyWith(color: colorScheme.onSurfaceVariant),
            ),
            IconButton(
              icon: Icon(Icons.edit_outlined,
                  color: colorScheme.primary, size: 20),
              onPressed: () {
                HapticFeedback.lightImpact();
                /* TODO: Edit action */
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                  child: _buildLocationTimeColumn(context, colorScheme,
                      Icons.location_on, pickup, pickupTime, 
                      isPickup: true)),
              const VerticalDivider(width: 32),
              Expanded(
                 child: _buildLocationTimeColumn(context, colorScheme,
                      Icons.location_on, drop, dropTime,
                      isDrop: true)),
            ],
          ),
        ),
      ],
    );
  }

  // Simplified column for location/time display
  Widget _buildLocationTimeColumn(
      BuildContext context,
      ColorScheme colorScheme,
      IconData icon,
      String location,
      String time,
      {bool isPickup = false,
      bool isDrop = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon,
                color: isDrop ? Colors.redAccent : colorScheme.primary,
                size: 20),
            const SizedBox(width: 8),
            Flexible(
                child: Text(location,
                   style: TextStyle(color: colorScheme.onSurfaceVariant),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2)),
          ],
        const Spacer(),
        const SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.access_time,
                color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                size: 16),
            const SizedBox(width: 6),
            Flexible(
                child: Text(time,
                    style: TextStyle(
                        color: colorScheme.onSurfaceVariant.withOpacity(0.9)),
                    overflow: TextOverflow.ellipsis)),
          ],
        ),
          ],
    );
  }

  // Helper for Driver Details Section within the main card (includes contact buttons)
  Widget _buildDriverDetailsSection(
      BuildContext context,
      ColorScheme colorScheme,
      TextTheme textTheme,
      String name,
      String imageUrl,
      double rating,
      String otp,
      String vehicleModel,
      String vehicleNumber) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Driver Details',
                  style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant.withOpacity(0.7))),
              const SizedBox(height: 8),
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: colorScheme.primaryContainer,
                    child: Icon(Icons.person,
                        color: colorScheme.onPrimaryContainer),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurfaceVariant),
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        _buildRatingStars(rating, colorScheme),
                         
                         ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildContactButton(
                      context, Icons.phone_outlined, colorScheme),
                  const SizedBox(width: 12),
                  _buildContactButton(
                      context, Icons.message_outlined, colorScheme),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(otp,
                  style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurfaceVariant)),
              const SizedBox(height: 4),
              Text(vehicleModel,
                  style: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onSurfaceVariant)),
              const SizedBox(height: 4),
              Text(vehicleNumber,
                 style: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onSurfaceVariant)),
            ],
          ),
        ),
      ],
    );
  }

  // Unchanged Contact Button Helper
  Widget _buildContactButton(
      BuildContext context, IconData icon, ColorScheme colorScheme) {
    return ElevatedButton(
      onPressed: () {
        HapticFeedback.lightImpact();
      },
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

    Widget _buildRatingStars(double rating, ColorScheme colorScheme) {
    // Pre-generate the list of star widgets for efficiency
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      IconData icon;
      if (i < rating.floor()) {
        icon = Icons.star;
      } else if (i < rating) {
        icon = Icons.star_half;
      } else {
        icon = Icons.star_border;
      }
      stars.add(Icon(icon, color: Colors.amber, size: 18));
    }
    return Row(children: stars);
  }


  // ... Add Confirmation Dialog (already exists) ...
}

            IconButton(
               icon: Icon(Icons.edit_outlined, color: colorScheme.primary, size: 20), 
              padding: EdgeInsets.zero, // EdgeInsets.zero is const
              constraints: const BoxConstraints(), // Can be const
            ),
          ],
        ),
        const SizedBox(height: 16), // Can be const
        // Using IntrinsicHeight to ensure columns have same height for alignment
        IntrinsicHeight(
          child: Row(
            children: [
              // Pickup Column
              Expanded(child: _buildLocationTimeColumn(context, colorScheme, Icons.location_on, pickup, pickupTime, isPickup: true)),
              const VerticalDivider(width: 32), // Can be const
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
            // Cannot be const due to dynamic icon/color
            Icon(icon, color: isDrop ? Colors.redAccent : colorScheme.primary, size: 20),
            const SizedBox(width: 8), // Can be const
            // Allow location text to wrap if needed
            Flexible(child: Text(location, style: TextStyle(color: colorScheme.onSurfaceVariant), overflow: TextOverflow.ellipsis, maxLines: 2)),
          ],
        ),
        // Add vertical space - adjust as needed
        const Spacer(), // Can be const
        const SizedBox(height: 12), // Can be const
         Row(
           children: [
        // Icon can be const, color uses theme
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
  Widget _buildDriverDetailsSection(BuildContext context, ColorScheme colorScheme, TextTheme textTheme, String name, String imageUrl, double rating, String otp, String vehicleModel, String vehicleNumber){
    
            children: [
              Text('Driver Details', style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant.withOpacity(0.7))), 
              const SizedBox(height: 8), // Can be const
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: colorScheme.primaryContainer,
                    // Icon can be const, color uses theme
                    child: Icon(Icons.person, color: colorScheme.onPrimaryContainer), 
                  ),
                  const SizedBox(width: 12), // Can be const
                  // Flexible to prevent overflow if name is long
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurfaceVariant), overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4), // Can be const
                        Row(
                          children: List.generate(5, (index) => Icon(
                            index < rating.floor() ? Icons.star : (index < rating ? Icons.star_half : Icons.star_border),
                            color: Colors.amber, // Hardcoded color
                            size: 18, // Can be const size
                          )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12), // Can be const
              // Contact Buttons moved here
              Row(
                children: [
                  _buildContactButton(context, Icons.phone_outlined, colorScheme),
                  const SizedBox(width: 12), // Can be const
                  _buildContactButton(context, Icons.message_outlined, colorScheme),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 16), // Can be const
        
        // Right Side: OTP & Vehicle
        Expanded(
          // ... inside _buildDriverDetailsSection ...
            children: [
              Text(otp, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurfaceVariant)),
              const SizedBox(height: 4), // Can be const
              Text(vehicleModel, style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
              const SizedBox(height: 4), // Can be const
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
        shape: const CircleBorder(), // Can be const
        padding: const EdgeInsets.all(10), // Can be const
        backgroundColor: colorScheme.surfaceVariant.withOpacity(0.5),
        foregroundColor: colorScheme.onSurfaceVariant,
        elevation: 0,
      ),
      child: Icon(icon, size: 20), // Icon can be const, but icon data itself comes from argument
    );
  }

  // ... Add Confirmation Dialog (already exists) ... 

}