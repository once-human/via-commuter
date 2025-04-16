import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting (add to pubspec if needed)
import 'package:via_commuter/app/theme/colors.dart'; // For custom colors

// --- Dummy Data ---

// Dummy data for active subscriptions
const List<Map<String, dynamic>> dummySubscriptions = [
  {
    'id': 'sub1',
    'routeName': 'BOOKING: Loni Kalbhor to Magarpatta',
    'totalRides': 10,
    'completedRides': 3,
  },
  {
    'id': 'sub2',
    'routeName': 'BOOKING: Koregaon park to Hadapsar',
    'totalRides': 20,
    'completedRides': 15,
  },
];

// Dummy data for past rides, grouped by date category
final Map<String, List<Map<String, dynamic>>> dummyPastRides = {
  'Today': [
    {
      'id': 'ride1',
      'pickupTime': DateTime.now().subtract(const Duration(hours: 2)),
      'dropTime': DateTime.now().subtract(const Duration(hours: 1)),
      'pickupLocation': '123 Main St',
      'dropLocation': 'Central Park',
      'driverName': 'Soham Thatte',
      'vehicleModel': 'Omni Van',
      'vehicleNumber': 'KA 12 8091',
      'status': 'Completed',
      'creditsUsed': 1,
    }
  ],
  'Last Week': [
    {
      'id': 'ride2',
      'pickupTime': DateTime.now().subtract(const Duration(days: 3, hours: 5)),
      'dropTime': DateTime.now().subtract(const Duration(days: 3, hours: 4, minutes: 15)),
      'pickupLocation': 'Tech Hub Tower',
      'dropLocation': 'Galaxy Diner',
      'driverName': 'Onkar Yaglewad',
      'vehicleModel': 'BMW X1',
      'vehicleNumber': 'MH 12 PR 6215',
      'status': 'Cancelled',
      'creditsUsed': 0,
    },
    {
      'id': 'ride3',
      'pickupTime': DateTime.now().subtract(const Duration(days: 5, hours: 8)),
      'dropTime': DateTime.now().subtract(const Duration(days: 5, hours: 7, minutes: 30)),
      'pickupLocation': 'Airport Terminal 3',
      'dropLocation': 'Hilton Hotel',
      'driverName': 'Raj Kumar',
      'vehicleModel': 'Toyota Innova',
      'vehicleNumber': 'MH 01 AB 1234',
      'status': 'Completed',
      'creditsUsed': 1,
    }
  ],
  'Older': [
     {
      'id': 'ride4',
      'pickupTime': DateTime.now().subtract(const Duration(days: 10, hours: 6)),
      'dropTime': DateTime.now().subtract(const Duration(days: 10, hours: 5, minutes: 0)),
      'pickupLocation': 'Shopping Mall',
      'dropLocation': 'City Center',
      'driverName': 'Amit Shah',
      'vehicleModel': 'Honda City',
      'vehicleNumber': 'DL 01 XY 5678',
      'status': 'Completed',
      'creditsUsed': 1,
    },
  ]
};

// --- End Dummy Data ---


class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  String _formatTimeRange(DateTime start, DateTime end) {
    // Use intl package for locale-aware time formatting
    return '${DateFormat.jm().format(start)} - ${DateFormat.jm().format(end)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Helper to build status widget
    Widget buildStatusWidget(String status) {
      bool isCompleted = status == 'Completed';
      Color statusColor = isCompleted ? kPrimaryGreen : colorScheme.error; // Use kPrimaryGreen for completed
      IconData statusIcon = isCompleted ? Icons.arrow_forward_ios : Icons.cancel_outlined; // Arrow for completed

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            status,
            style: textTheme.labelLarge?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (isCompleted) ...[
             const SizedBox(width: 4),
             Icon(
               statusIcon,
               color: statusColor,
               size: 14,
             ),
          ] else ... [
             const SizedBox(width: 4), // Keep spacing consistent
              Icon(
               statusIcon,
               color: statusColor,
               size: 16, // Slightly larger cancel icon
             ),
          ]
        ],
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity'),
        backgroundColor: theme.scaffoldBackgroundColor, // Match background
        elevation: 0, // Flat app bar
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          // --- Subscription Progress Section ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: Text(
                'Subscription Activity',
                style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final sub = dummySubscriptions[index];
                  final double progress = sub['completedRides'] / sub['totalRides'];
                  final int remainingRides = sub['totalRides'] - sub['completedRides'];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      elevation: 1.0, // Subtle elevation
                      margin: EdgeInsets.zero,
                      color: colorScheme.surfaceVariant, // Use surface variant
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sub['routeName'],
                              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 12.0),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3, // Give more space to progress bar
                                  child: ClipRRect( // Clip the progress bar corners
                                     borderRadius: BorderRadius.circular(8.0),
                                     child: LinearProgressIndicator(
                                        value: progress,
                                        minHeight: 8.0, // Make bar slightly thicker
                                        backgroundColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                                        valueColor: AlwaysStoppedAnimation<Color>(kPrimaryGreenDarker), // Use darker green
                                      ),
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                Expanded(
                                  flex: 2, // Space for text
                                  child: Text(
                                    '${(progress * 100).toStringAsFixed(0)}% used ($remainingRides left)',
                                    style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0), // Space before button
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  // TODO: Navigate to subscription details
                                  print('View details for ${sub['id']}');
                                },
                                child: const Text('Details'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: dummySubscriptions.length,
              ),
            ),
          ),

          // --- Past Rides Section ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0), // More top padding
              child: Text(
                'Past Rides',
                style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Dynamically create sections for each date group
          ...dummyPastRides.entries.expand((entry) {
            String dateHeader = entry.key;
            List<Map<String, dynamic>> rides = entry.value;

            // Return a list containing the header and the list of ride cards
            return [
              // Date Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 16.0, 16.0, 4.0), // Indent header slightly
                  child: Text(
                    dateHeader,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              // List of Rides for this date group
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final ride = rides[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0), // Tighter vertical padding
                        child: Card(
                          elevation: 1.0,
                          margin: EdgeInsets.zero,
                          color: colorScheme.surface, // Use base surface color
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: InkWell( // Make the card tappable
                            onTap: () {
                              // TODO: Navigate to Ride Detail Screen for past rides
                              print('Tapped on ride: ${ride['id']}');
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Row 1: Time Range and Status
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _formatTimeRange(ride['pickupTime'], ride['dropTime']),
                                        style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                                      ),
                                      buildStatusWidget(ride['status']),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  // Row 2: Pickup Location
                                  Row(
                                    children: [
                                      Icon(Icons.trip_origin, size: 18, color: colorScheme.primary),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          ride['pickupLocation'] ?? 'N/A',
                                          style: textTheme.bodyMedium,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4.0),
                                  // Row 3: Drop Location
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined, size: 18, color: colorScheme.error),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          ride['dropLocation'] ?? 'N/A',
                                          style: textTheme.bodyMedium,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(height: 20.0, thickness: 0.5),
                                  // Row 4: Driver, Vehicle, Credits
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded( // Allow text to take space and wrap/ellipsis
                                        child: Text(
                                          '${ride['driverName']} - ${ride['vehicleModel']} (${ride['vehicleNumber']})',
                                          style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      const SizedBox(width: 8), // Add space before credits
                                      if (ride['creditsUsed'] > 0) // Show credits only if > 0
                                        Text(
                                          '-${ride['creditsUsed']} Credit${ride['creditsUsed'] > 1 ? 's' : ''}',
                                          style: textTheme.bodySmall?.copyWith(
                                            color: colorScheme.onSurfaceVariant, // Keep it subtle
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: rides.length,
                  ),
                ),
              ),
            ];
          }),

          // Add padding at the bottom for the Nav Bar
           SliverToBoxAdapter(
             child: SizedBox(height: MediaQuery.of(context).padding.bottom + 90.0),
           ),
        ],
      ),
    );
  }
} 