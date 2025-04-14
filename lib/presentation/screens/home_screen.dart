import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui'; // Import for ImageFilter
import 'package:via_commuter/presentation/widgets/bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final List<Map<String, dynamic>> upcomingRides = [
    {
      'userName': "Khushi",
      'date': "Today",
      'pickupLocation': "Pickup: 123 Main St",
      'dropLocation': "Drop: Central Park",
      'pickupTime': "9:00 am",
      'dropTime': "10:00 am",
      'driverName': "Soham Thatte",
      'driverImageUrl': "",
      'driverRating': 4.5,
      'otp': "OTP 1234",
      'vehicleModel': "Omni Van",
      'vehicleNumber': "KA 12 8091",
    },
    {
      'userName': "Khushi",
      'date': "Tomorrow",
      'pickupLocation': "Pickup: Tech Hub Tower",
      'dropLocation': "Drop: Galaxy Diner",
      'pickupTime': "2:00 PM",
      'dropTime': "2:45 PM",
      'driverName': "Onkar Yaglewad",
      'driverImageUrl': "",
      'driverRating': 5.0,
      'otp': "OTP 8888",
      'vehicleModel': "Flux Capacitor Express",
      'vehicleNumber': "OUTATIME",
    },
    {
      'userName': "Khushi",
      'date': "Next Week",
      'pickupLocation': "Pickup: Airport Terminal 3",
      'dropLocation': "Drop: Hilton Hotel",
      'pickupTime': "11:30 AM",
      'dropTime': "12:15 PM",
      'driverName': "Raj Kumar",
      'driverImageUrl': "",
      'driverRating': 4.8,
      'otp': "OTP 5678",
      'vehicleModel': "Toyota Innova",
      'vehicleNumber': "MH 01 AB 1234",
    },
    {
      'userName': "Khushi",
      'date': "Next Week",
      'pickupLocation': "Pickup: Shopping Mall",
      'dropLocation': "Drop: City Center",
      'pickupTime': "3:30 PM",
      'dropTime': "4:15 PM",
      'driverName': "Amit Shah",
      'driverImageUrl': "",
      'driverRating': 4.7,
      'otp': "OTP 9012",
      'vehicleModel': "Honda City",
      'vehicleNumber': "DL 01 XY 5678",
    },
    {
      'userName': "Khushi",
      'date': "Next Month",
      'pickupLocation': "Pickup: Railway Station",
      'dropLocation': "Drop: Business Park",
      'pickupTime': "8:45 AM",
      'dropTime': "9:30 AM",
      'driverName': "Priya Patel",
      'driverImageUrl': "",
      'driverRating': 4.9,
      'otp': "OTP 3456",
      'vehicleModel': "Maruti Swift",
      'vehicleNumber': "GJ 01 CD 9012",
    },
    {
      'userName': "Khushi",
      'date': "Next Month",
      'pickupLocation': "Pickup: Metro Station",
      'dropLocation': "Drop: Tech Park",
      'pickupTime': "5:15 PM",
      'dropTime': "6:00 PM",
      'driverName': "Vikram Singh",
      'driverImageUrl': "",
      'driverRating': 4.6,
      'otp': "OTP 7890",
      'vehicleModel': "Hyundai Verna",
      'vehicleNumber': "UP 01 EF 3456",
    },
    {
      'userName': "Khushi",
      'date': "Next Month",
      'pickupLocation': "Pickup: College Campus",
      'dropLocation': "Drop: Sports Complex",
      'pickupTime': "1:30 PM",
      'dropTime': "2:15 PM",
      'driverName': "Neha Sharma",
      'driverImageUrl': "",
      'driverRating': 4.8,
      'otp': "OTP 2345",
      'vehicleModel': "Tata Nexon",
      'vehicleNumber': "KA 01 GH 7890",
    },
    {
      'userName': "Khushi",
      'date': "Next Month",
      'pickupLocation': "Pickup: Hospital",
      'dropLocation': "Drop: Residential Complex",
      'pickupTime': "10:00 AM",
      'dropTime': "10:45 AM",
      'driverName': "Rahul Verma",
      'driverImageUrl': "",
      'driverRating': 4.7,
      'otp': "OTP 6789",
      'vehicleModel': "Mahindra XUV",
      'vehicleNumber': "MH 01 IJ 1234",
    },
  ];

  bool get hasUpcomingRides => upcomingRides.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    const userName = "Khushi";
    // Placeholder subscription data
    const subscriptionPlan = "Premium Plan";
    const subscriptionDetails = "Active until Dec 2024"; 

    // Enable high refresh rate
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: theme.brightness == Brightness.light ? Brightness.dark : Brightness.light,
      ),
    );

    return Scaffold(
      body: Column(
        children: [
          // Fixed Header Section
          RepaintBoundary(
            child: Container(
              // Use background color from theme
              color: theme.scaffoldBackgroundColor,
              padding: EdgeInsets.only(
                // Add status bar padding and horizontal padding
                top: MediaQuery.of(context).padding.top,
                left: 16.0,
                right: 16.0,
                bottom: 16.0, // Add some padding below the greeting & subscription
              ),
              child: Column( // Wrap greeting Row in a Column
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGreeting(context, colorScheme, textTheme, userName),
                  const SizedBox(height: 12), // Spacing before subscription status
                  _buildSubscriptionStatus(context, colorScheme, textTheme, subscriptionPlan, subscriptionDetails),
                ],
              ),
            ),
          ),
          // Scrollable Content Section
          Expanded(
            child: RepaintBoundary(
              child: CustomScrollView(
                physics: const ClampingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                cacheExtent: 1000,
                slivers: [
                  // --- Add Search Bar ---
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0), // Add padding around search bar
                      child: _buildSearchBar(context, colorScheme, textTheme),
                    ),
                  ),
                  // --- End Search Bar ---

                  // --- Conditional Content: Upcoming Rides or Empty State ---
                  if (hasUpcomingRides) ...[
                    // Spacing before "Upcoming Ride Details"
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 8),
                    ),
                    // Title
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Upcoming Ride Details',
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // List
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final rideData = upcomingRides[index];
                            return RepaintBoundary(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: _buildUpcomingRideCard(
                                  context,
                                  colorScheme,
                                  textTheme,
                                  rideData,
                                ),
                              ),
                            );
                          },
                          childCount: upcomingRides.length,
                        ),
                      ),
                    ),
                  ] else ...[
                    // Empty State Widget
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.event_busy_outlined,
                                size: 64,
                                color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No upcoming rides scheduled.',
                                style: textTheme.titleMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              FilledButton.icon(
                                icon: const Icon(Icons.add),
                                label: const Text('Book a Ride'),
                                onPressed: () {
                                  // TODO: Implement ride booking navigation
                                  print('Book ride from empty state pressed');
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  // --- End Conditional Content ---
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting(BuildContext context, ColorScheme colorScheme, TextTheme textTheme, String userName) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, $userName!',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Ready for your ride today?',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        // Use ActionChip to make it tappable
        ActionChip(
          onPressed: () {
            // TODO: Implement navigation to Points screen
            print('Points chip pressed');
          },
          avatar: CircleAvatar(
            backgroundColor: Colors.amber.shade700,
            child: const Icon(Icons.star, size: 16, color: Colors.white),
          ),
          label: Text(
            'Points',
            style: textTheme.labelMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          backgroundColor: colorScheme.surfaceVariant.withOpacity(0.5),
          side: BorderSide.none,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
      ],
    );
  }

  Widget _buildSubscriptionStatus(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
    String plan,
    String details,
  ) {
    return Row(
      children: [
        Icon(
          Icons.workspace_premium_outlined, // Or another relevant icon
          color: colorScheme.primary,
          size: 18,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plan,
              style: textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              details,
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return TextField(
      readOnly: true, // Make it non-editable for now, just UI
      onTap: () {
        // TODO: Implement navigation to search/booking screen
        print("Search bar tapped");
      },
      decoration: InputDecoration(
        hintText: 'Where to?',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: colorScheme.surfaceVariant.withOpacity(0.5),
        contentPadding: EdgeInsets.zero, // Remove default padding
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0), // Make it pill-shaped
          borderSide: BorderSide.none, // No border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.0), // Highlight on focus
        ),
      ),
    );
  }

  Widget _buildUpcomingRideCard(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
    Map<String, dynamic> rideData,
  ) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      // Adjust card color for gradient blending
      color: colorScheme.surfaceVariant.withOpacity(0.3),
      clipBehavior: Clip.antiAlias, // Ensure gradient is clipped to card shape
      child: Stack( // Use Stack to layer gradient behind content
        children: [
          // Simplified, Single Subtle Gradient Layer (No Blur)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  // Very faint gradient
                  colors: [
                    colorScheme.primary.withOpacity(0.03), // Extremely subtle start color
                    colorScheme.surfaceVariant.withOpacity(0.3), // Card base color
                  ],
                  stops: [
                    0.0, // Start color at the very beginning
                    0.4, // Fade completely to base color by 40% of the gradient
                  ],
                  begin: Alignment.topRight, // Start corner
                  end: Alignment.bottomLeft, // End corner (defines direction)
                ),
              ),
            ),
          ),
          // Layer 2: Original Card Content (On top of gradient)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      rideData['date'] as String,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    Text(
                      '${rideData['pickupTime']} - ${rideData['dropTime']}',
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Use RichText for Pickup line
                RichText(
                  text: TextSpan(
                    style: textTheme.bodyMedium, // Default style for the line
                    children: [
                      const TextSpan(text: 'Pickup: '), // Default color (white)
                      TextSpan(
                        text: rideData['pickupLocation']?.substring(7) ?? '', // Extract location part
                        style: TextStyle(color: colorScheme.onSurfaceVariant), // Greyish for location
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                // Use RichText for Drop line
                RichText(
                  text: TextSpan(
                    style: textTheme.bodyMedium, // Default style for the line
                    children: [
                      const TextSpan(text: 'Drop: '), // Default color (white)
                      TextSpan(
                        text: rideData['dropLocation']?.substring(6) ?? '', // Extract location part
                        style: TextStyle(color: colorScheme.onSurfaceVariant), // Greyish for location
                      ),
                    ],
                  ),
                ),
                const Divider(height: 24),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      // Use pure black/white based on theme brightness
                      backgroundColor: Theme.of(context).brightness == Brightness.dark 
                                         ? Colors.black 
                                         : Colors.white,
                      child: Text(
                        rideData['driverName'].toString()[0],
                        style: textTheme.titleMedium?.copyWith(
                          // Keep contrast color (onSurface: white on black, black on white)
                          color: colorScheme.onSurface, 
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rideData['driverName'] as String,
                            // Revert to default text color
                            style: textTheme.titleSmall,
                          ),
                          Text(
                            '${rideData['vehicleModel']} - ${rideData['vehicleNumber']}',
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, size: 16, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              rideData['driverRating'].toString(),
                              style: textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Text(
                          rideData['otp'] as String,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Conditionally render buttons only for Today/Tomorrow
                if (rideData['date'] == 'Today' || rideData['date'] == 'Tomorrow') ...[
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Align buttons to the start
                    children: [
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          // Change color to onSurfaceVariant (greyish)
                          foregroundColor: colorScheme.onSurfaceVariant,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: const Icon(Icons.message_outlined, size: 18),
                        label: const Text('Message'),
                        onPressed: () {
                          // TODO: Implement message functionality
                          print('Message button pressed for ${rideData['driverName']}');
                        },
                      ),
                      const SizedBox(width: 16), // Spacing between buttons
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          // Change color to onSurfaceVariant (greyish)
                          foregroundColor: colorScheme.onSurfaceVariant,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: const Icon(Icons.call_outlined, size: 18),
                        label: const Text('Call'),
                        onPressed: () {
                          // TODO: Implement call functionality
                          print('Call button pressed for ${rideData['driverName']}');
                        },
                      ),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}