import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                bottom: 16.0, // Add some padding below the greeting
              ),
              child: _buildGreeting(context, colorScheme, textTheme, userName),
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
                  // Remove SliverPersistentHeader - padding handled above
                  // Remove SliverToBoxAdapter for greeting - moved above

                  // Spacing before "Upcoming Ride Details"
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 8), // Reduced top spacing
                  ),
                  if (hasUpcomingRides)
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
                  if (hasUpcomingRides)
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
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(height: 24),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
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
        Chip(
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

  Widget _buildUpcomingRideCard(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
    Map<String, dynamic> rideData,
  ) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      child: Padding(
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
                  ),
                ),
                Text(
                  '${rideData['pickupTime']} - ${rideData['dropTime']}',
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              rideData['pickupLocation'] as String,
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              rideData['dropLocation'] as String,
              style: textTheme.bodyMedium,
            ),
            const Divider(height: 24),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: colorScheme.primaryContainer,
                  child: Text(
                    rideData['driverName'].toString()[0],
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer,
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
          ],
        ),
      ),
    );
  }
}