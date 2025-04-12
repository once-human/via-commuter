import 'dart:ui'; // Import for ImageFilter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For HapticFeedback
import 'package:via_commuter/presentation/widgets/bottom_navbar.dart'; // Adjust import path if needed
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class HomeScreen extends StatelessWidget {
  // Add const constructor for the StatelessWidget itself
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ... existing code ...
              delegate: SliverChildListDelegate([
                // Cannot be const due to MediaQuery
                SizedBox(height: MediaQuery.of(context).padding.top + 24), 
                
                // --- Greeting and Points --- 
                _buildGreeting(context, colorScheme, textTheme, userName), // Cannot be const (needs context/theme)
                const SizedBox(height: 24), // Can be const

                // --- Upcoming Ride Section Title --- 
                if (hasUpcomingRides)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0), // Can be const
                    child: Text(
                      'Upcoming Ride Details',
                      style: textTheme.titleLarge?.copyWith(
                        // ... existing code ...
                  return Padding(
                    // Add padding below each card except the last?
                    // For now, add padding below all cards
                    padding: const EdgeInsets.only(bottom: 16.0), // Can be const
                    child: _buildUpcomingRideCard(context, colorScheme, textTheme, rideData),
                  );
                }).toList(),
                
                // --- Add Test Builds Button --- 
                const SizedBox(height: 24), // Can be const
                Center(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.science_outlined, size: 18), // Can be const
                    label: const Text('View Test Builds'), // Can be const
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.secondary, // Use secondary color
                      side: BorderSide(color: colorScheme.secondary.withOpacity(0.5)),
                    // ... existing code ...
                  ),
                ),
                const SizedBox(height: 16), // Can be const

                // Add significant padding at the bottom if using FAB
                // Keep existing padding below
                // Cannot be const due to kBottomNavigationBarHeight (might not be compile-time const)
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
          // TODO: Navigate to booking screen
        },
        label: const Text('Book New Ride'), // Assuming style comes from theme, Text itself is const
        icon: const Icon(Icons.add), // Can be const
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0), // Already const
    );
  }

  // --- Helper Widgets --- 

  // Note: Helper methods themselves cannot be const, but widgets returned CAN be.

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
  Widget _buildUpcomingRideCard(BuildContext context, ColorScheme colorScheme, TextTheme textTheme, Map<String, dynamic> rideData) {
    return Card(
      elevation: 0,
      color: colorScheme.surfaceVariant.withOpacity(0.5), // Main card background
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Can be const
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Can be const
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... inside _buildUpcomingRideCard ...
              rideData['pickupTime'], rideData['dropTime']
            ),
            const Divider(height: 32), // Can be const
            
            // Section 2: Driver Details + Actions
            _buildDriverDetailsSection(context, colorScheme, textTheme, 
            // ... inside _buildUpcomingRideCard ...
              rideData['vehicleModel'], rideData['vehicleNumber']
            ),
            const SizedBox(height: 16), // Can be const

            // Section 3: Cancel Button
            Center(
              // ... inside _buildUpcomingRideCard ...
                  _showCancelConfirmationDialog(context);
                },
                icon: const Icon(Icons.cancel_outlined, color: Colors.redAccent.shade100, size: 18), // Icon can be const, color is hardcoded
                label: const Text('Cancel Ride', style: TextStyle(color: Colors.redAccent.shade100)), // Text+Style can be const (color is hardcoded)
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Can be const
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // Can be const
                  // Add subtle highlight overlay
                  foregroundColor: Colors.redAccent.shade100, 
                ).copyWith( // Apply overlayColor using copyWith
                // ... existing code ...

  // Helper for Ride Details Section within the main card
  Widget _buildRideDetailsSection(BuildContext context, ColorScheme colorScheme, TextTheme textTheme, String date, String pickup, String drop, String pickupTime, String dropTime) {
    // ... inside _buildRideDetailsSection ...
            ),
            // Cannot be const due to onPressed and theme color
            IconButton(
              icon: Icon(Icons.edit_outlined, color: colorScheme.primary, size: 20), 
              onPressed: () { HapticFeedback.lightImpact(); /* TODO: Edit action */ },
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
          children: [
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
  Widget _buildDriverDetailsSection(BuildContext context, ColorScheme colorScheme, TextTheme textTheme, String name, String imageUrl, double rating, String otp, String vehicleModel, String vehicleNumber) {
    // ... inside _buildDriverDetailsSection ...
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