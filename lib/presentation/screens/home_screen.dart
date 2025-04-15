import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui'; // Import for ImageFilter
import 'package:via_commuter/presentation/widgets/bottom_navbar.dart';
import 'package:via_commuter/presentation/screens/ride_detail_screen.dart'; // Import detail screen
// Add animation imports
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// Convert to StatefulWidget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// Add TickerProviderStateMixin
class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // --- Animation State for Header Buttons ---
  late AnimationController _pointsTapController;
  late Animation<double> _pointsScaleAnimation;

  late AnimationController _bookRideTapController;
  late Animation<double> _bookRideScaleAnimation;

  // Dummy data remains here for now
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
      'vehicleModel': "BMW X1",
      'vehicleNumber': "MH 12 PR 6215",
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
  void initState() {
    super.initState();
    // Initialize Points Chip Animation
    _pointsTapController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _pointsScaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _pointsTapController, curve: Curves.easeInOut),
    );

    // Initialize Book Ride Button Animation
    _bookRideTapController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _bookRideScaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _bookRideTapController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pointsTapController.dispose();
    _bookRideTapController.dispose();
    super.dispose();
  }

  // --- Tap Handlers for Animation ---
  void _handlePointsTapDown(TapDownDetails details) {
    _pointsTapController.forward();
  }

  void _handlePointsTapUp(TapUpDetails details) {
    // Trigger haptic immediately on tap up
    HapticFeedback.mediumImpact(); 
    // Still reverse the animation
    Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) _pointsTapController.reverse();
    });
     // Original tap logic (excluding haptic)
     print('Points chip pressed');
     // TODO: Implement navigation
  }

  void _handlePointsTapCancel() {
     if (mounted) _pointsTapController.reverse();
  }

   void _handleBookRideTapDown(TapDownDetails details) {
    _bookRideTapController.forward();
  }

  void _handleBookRideTapUp(TapUpDetails details) {
    // Trigger haptic immediately on tap up
    HapticFeedback.mediumImpact();
    // Still reverse the animation
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _bookRideTapController.reverse();
    });
    // Original tap logic (excluding haptic)
    print('Book ride from header pressed');
    // TODO: Implement navigation
  }

  void _handleBookRideTapCancel() {
     if (mounted) _bookRideTapController.reverse();
  }
  // --- End Animation Handlers ---

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    const userName = "Khushi";
    const subscriptionPlan = "Premium Plan";
    const subscriptionDetails = "Active until Sept 2025";

    // Enable high refresh rate
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: theme.brightness == Brightness.light ? Brightness.dark : Brightness.light,
      ),
    );

    return Scaffold(
      // body is now a Stack to layer background and content
      body: Stack(
        children: [
          // Layer 1: Background Doodle Pattern
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                // Base background color (optional, provides fallback)
                color: theme.scaffoldBackgroundColor,
                // --- Temporarily Commented Out Background Image ---
                // Ensure you have added the image to assets/images/
                // and declared it in pubspec.yaml before uncommenting.
                /*
                image: DecorationImage(
                  // IMPORTANT: Replace with your actual asset path
                  image: const AssetImage('assets/images/ride_doodle_pattern.png'),
                  repeat: ImageRepeat.repeat, // Tile the image
                  // Make the pattern very faint and tinted
                  colorFilter: ColorFilter.mode(
                    colorScheme.onSurface.withOpacity(0.03), // Adjust opacity (0.02-0.05 is subtle)
                    BlendMode.srcATop, // Blend the color filter over the image
                  ),
                ),
                 */
              ),
            ),
          ),
          // Layer 2: Original Content Column
          Column(
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
                      _buildGreeting(context, colorScheme, textTheme, userName)
                          // Add entrance animation to greeting row
                          .animate()
                          .fadeIn(duration: 400.ms)
                          .slideY(begin: -0.2, duration: 300.ms, curve: Curves.easeOut),
                      const SizedBox(height: 12), // CONST
                      _buildSubscriptionStatus(context, colorScheme, textTheme, subscriptionPlan, subscriptionDetails)
                          // Add entrance animation to subscription row
                          .animate()
                          .fadeIn(delay: 100.ms, duration: 400.ms)
                          .slideY(begin: -0.2, duration: 300.ms, curve: Curves.easeOut),
                    ],
                  )
                  // No overall fade needed here if children animate
                  // .animate()
                  // .fadeIn(delay: 50.ms),
                ),
              ),
              // Add Divider for separation
              const Divider(height: 1, thickness: 1),
              // Scrollable Content Section
              Expanded(
                child: RepaintBoundary(
                  child: CustomScrollView(
                    physics: const ClampingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    cacheExtent: 500,
                    slivers: [
                      // --- Remove Search Bar ---
                      // SliverToBoxAdapter(
                      //   child: Padding(
                      //     padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0), 
                      //     child: _buildSearchBar(context, colorScheme, textTheme),
                      //   ),
                      // ),
                      
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
                            )
                            // Animate the title fade-in
                            .animate()
                            .fadeIn(delay: 200.ms, duration: 400.ms)
                            .slideY(begin: 0.2, duration: 300.ms, curve: Curves.easeOut),
                          ),
                        ),
                        // List with Staggered Animations
                        AnimationLimiter(
                          child: SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final rideData = upcomingRides[index];
                                  // Wrap the actual content widget for animation
                                  Widget content = RepaintBoundary(
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

                                  // Apply flutter_animate effects 
                                  content = content
                                      .animate()
                                      .fadeIn(duration: 400.ms, curve: Curves.easeOut)
                                      .slideY(begin: 0.3, duration: 400.ms, curve: Curves.easeOut)
                                      .scaleXY(begin: 0.95, duration: 300.ms, curve: Curves.easeOut);

                                  // Apply flutter_staggered_animations wrappers
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375), // CONST
                                    child: SlideAnimation(
                                      verticalOffset: 50.0, // Initial offset for stagger
                                      // FadeInAnimation is handled by flutter_animate now
                                      child: content, // Pass the animated content
                                    ),
                                  );
                                },
                                childCount: upcomingRides.length,
                              ),
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
                                  const SizedBox(height: 16), // CONST
                                  Text(
                                    'No upcoming rides scheduled.',
                                    style: textTheme.titleMedium?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 24), // CONST
                                  FilledButton.icon(
                                    icon: const Icon(Icons.add),
                                    label: const Text('Book a Ride'),
                                    onPressed: () {
                                      // TODO: Implement ride booking navigation
                                      print('Book ride from empty state pressed');
                                    },
                                  )
                                ],
                              )
                              // Animate the entire empty state column
                              .animate()
                              .fadeIn(delay: 200.ms, duration: 500.ms)
                              .slideY(begin: 0.2, duration: 400.ms, curve: Curves.easeOut),
                            ),
                          ),
                        ),
                      ],
                      // --- End Conditional Content ---

                      // Re-add padding at the end of the scroll view for NavBar
                      SliverToBoxAdapter(
                        child: SizedBox(height: MediaQuery.of(context).padding.bottom + 90.0), // Increased padding slightly
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting(BuildContext context, ColorScheme colorScheme, TextTheme textTheme, String userName) {
    // Placeholder points data
    const pointsValue = 2000;

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
              const SizedBox(height: 4), // CONST
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
        GestureDetector(
          onTapDown: _handlePointsTapDown,
          onTapUp: _handlePointsTapUp,
          onTapCancel: _handlePointsTapCancel,
          child: ScaleTransition(
            scale: _pointsScaleAnimation,
            child: ActionChip(
              onPressed: () {}, // Keep dummy onPressed or remove if not needed by ActionChip
              avatar: CircleAvatar(
                backgroundColor: Colors.amber.shade700,
                child: const Icon(Icons.star, size: 16, color: Colors.white),
              ),
              // Update label to show points value
              label: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$pointsValue ', // Add space after number
                      style: textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface, // White/Black for number
                      ),
                    ),
                    TextSpan(
                      text: 'Points',
                      style: textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant, // Greyish for text
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: colorScheme.surfaceVariant.withOpacity(0.5),
              side: BorderSide.none,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // CONST
            ),
          ),
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
      crossAxisAlignment: CrossAxisAlignment.center, // Align items vertically
      children: [
        // Remove Expanded wrapper
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.workspace_premium_outlined, // Or another relevant icon
              color: colorScheme.primary,
              size: 18,
            ),
            const SizedBox(width: 8), // CONST
            // Wrap the Column containing text with Flexible
            Flexible(
              child: Column(
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
            ),
          ],
        ),
        const Spacer(), // Pushes the button to the right
        // Change to ElevatedButton for more prominence
        GestureDetector(
          onTapDown: _handleBookRideTapDown,
          onTapUp: _handleBookRideTapUp,
          onTapCancel: _handleBookRideTapCancel,
          child: ScaleTransition(
            scale: _bookRideScaleAnimation,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary, // Ensure primary color background
                foregroundColor: colorScheme.onPrimary, // Ensure good text contrast
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), // CONST
                textStyle: textTheme.labelLarge, // Reverted back to larger text style
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Standard rounded corners
                ),
              ),
              icon: const Icon(Icons.directions_car_filled, size: 18), // CONST
              label: const Text('Book Ride'), // CONST
              onPressed: () {}, // Keep dummy onPressed or remove if not needed
            ),
          ),
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
    // Create a unique tag for the Hero animation
    final String heroTag = 'rideCard_${rideData['date'] ?? 'nodate'}_${rideData['pickupTime'] ?? 'notime'}';
    // Check if the card is for 'Today'
    final bool isToday = rideData['date'] == 'Today';

    return Hero(
      tag: heroTag, // Use the unique tag
      child: Material( // Hero child needs to be Material or similar
        type: MaterialType.transparency, // Avoid double background
        child: InkWell(
          onTap: () {
            // Strong haptic for card expansion
            HapticFeedback.heavyImpact(); 
            Navigator.push(
              context,
              // Use MaterialPageRoute for standard transition
              // TODO: Consider PageRouteBuilder for custom transitions later if needed
              MaterialPageRoute(
                builder: (context) => RideDetailScreen(
                  rideData: rideData,
                  heroTag: heroTag, // Pass the same tag
                ),
              ),
            );
          },
          // Child is now a Column containing Card and Action Bar
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // The main Card with original shape
              Card(
                // Increase elevation difference more
                elevation: isToday ? 8.0 : 1.0, 
                margin: EdgeInsets.zero,
                // Conditionally set background 
                color: isToday 
                    ? colorScheme.surfaceVariant.withOpacity(0.3) 
                    : colorScheme.surfaceVariant, // Solid color for non-today cards
                // Ensure clipping for internal stack/gradients
                clipBehavior: Clip.antiAlias, 
                // Remove conditional border
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Standard radius
                  // side: isToday 
                  //     ? BorderSide(color: colorScheme.primary.withOpacity(0.4), width: 1.5) 
                  //     : BorderSide.none, // No border for other cards
                ),
                child: Stack( 
                  children: [
                    // Conditionally add gradient layers only for 'Today'
                    if (isToday)
                      Positioned.fill(
                        child: Container(
                          // Container holds the Stack for multiple gradients
                          child: Stack(
                            children: [
                              // Gradient 1 (Top-Right, Minimal Intensity)
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      colorScheme.primary.withOpacity(0.004), // Extremely faint
                                      colorScheme.surfaceVariant.withOpacity(0.3), // Card base color
                                    ],
                                    stops: [
                                      0.0, 
                                      0.7, 
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  ),
                                ),
                              ),
                              // Gradient 2 (Bottom-Left, Minimal Intensity)
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      colorScheme.primary.withOpacity(0.002), // Extremely faint
                                      colorScheme.surfaceVariant.withOpacity(0.3), // Card base color
                                    ],
                                    stops: [
                                      0.0, 
                                      0.7, 
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    // Replace Padding with Column containing Padding + Action Bar
                    Column(
                      mainAxisSize: MainAxisSize.min, // Fit content
                      children: [
                        // Original Content Padding
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Main content row (Title, Locations | Time, OTP)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start, // Align tops
                                children: [
                                  // Left side: Title and Locations (Takes available space)
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          isToday ? 'Today' : rideData['date'] ?? 'Upcoming',
                                          style: textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0), // CONST
                                        // Location Column
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            _buildLocationRow('Pickup', rideData['pickupLocation'] ?? 'Pickup: N/A'),
                                            const SizedBox(height: 4.0), // CONST
                                            _buildLocationRow('Drop', rideData['dropLocation'] ?? 'Drop: N/A'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // REDUCE spacing between left and right columns FURTHER
                                  const SizedBox(width: 8.0), // CONST spacing between left and right
                                  // Right side: Time ONLY now
                                  // IntrinsicWidth might not be needed now, but keep for time alignment
                                  IntrinsicWidth(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${rideData['pickupTime'] ?? '--:--'} - ${rideData['dropTime'] ?? '--:--'}',
                                          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                                        ),
                                        const SizedBox(height: 8.0), // Space between time and OTP
                                        // --- RE-INSERTED OTP RichText (No Container/Chip) ---
                                        RichText(
                                          text: TextSpan(
                                            // Smaller grey prefix
                                            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                                            children: [
                                              const TextSpan(text: 'OTP '),
                                              // Large green number
                                              TextSpan(
                                                text: rideData['otp']?.toString().replaceFirst("OTP ", "") ?? "????",
                                                style: textTheme.headlineSmall?.copyWith( // Keep large size
                                                  color: Colors.green.shade400, // Keep green color
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // --- END OTP RichText ---
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              
                              const Divider(height: 16.0, thickness: 1, indent: 55, endIndent: 16), // Add subtle divider

                              // --- Driver Details Row ---
                              Row(
                                children: [
                                  // Avatar
                                  CircleAvatar(
                                    radius: 20,
                                    // Use pure black/white based on theme brightness as fallback background
                                    backgroundColor: Theme.of(context).brightness == Brightness.dark 
                                                       ? Colors.black 
                                                       : Colors.white,
                                    // Conditionally set background image 
                                    backgroundImage: rideData['driverName'] == 'Onkar Yaglewad' 
                                        ? const AssetImage('assets/driver_profiles/onkar.jpg') 
                                        : null, 
                                    // Set child (initial) ONLY if backgroundImage is null
                                    child: rideData['driverName'] != 'Onkar Yaglewad' 
                                        ? Text(
                                            rideData['driverName'].toString().isNotEmpty 
                                                ? rideData['driverName'].toString()[0] 
                                                : '?', // Fallback if name is empty
                                            style: textTheme.titleMedium, 
                                          )
                                        : null, // No child if background image should be present
                                  ),
                                  const SizedBox(width: 12), // CONST
                                  // Name and Vehicle details (takes remaining space before rating)
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          rideData['driverName'] as String,
                                          style: textTheme.bodyLarge?.copyWith( // Use bodyLarge for name
                                            fontWeight: FontWeight.w500, // Slightly bolder
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2), // Minimal space
                                        // Replace single Text with a Row for Model (grey) and Number (white)
                                        Row(
                                          children: [
                                            // Vehicle Model (Grey)
                                            Flexible( // Allow model to shrink if needed
                                              child: Text(
                                                '${rideData['vehicleModel']} - ', // Include the separator
                                                style: textTheme.bodyMedium?.copyWith(
                                                  color: colorScheme.onSurfaceVariant, // Keep grey
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            // Vehicle Number (Default/White)
                                            Flexible( // Allow number to shrink
                                              child: Text(
                                                rideData['vehicleNumber'] as String? ?? '', // Handle null
                                                style: textTheme.bodyMedium?.copyWith( 
                                                  // No color override = default white
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis, 
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Add Spacer before Rating
                                  const SizedBox(width: 8), 
                                  // --- Rating Row ---
                                  Row(
                                    mainAxisSize: MainAxisSize.min, // Don't take extra space
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber.shade600, // Star color
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        (rideData['driverRating'] as double?)?.toStringAsFixed(1) ?? '-', // Format rating
                                        style: textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: colorScheme.onSurface, // Use default text color for rating number
                                        ),
                                      ),
                                    ],
                                  ),
                                  // --- End Rating Row ---
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Re-add conditional Action Bar Container BELOW the Card
              if (isToday)
                Container(
                  width: double.infinity, // Takes width from parent Column padding
                  // Increase horizontal margin to make it narrower
                  margin: const EdgeInsets.symmetric(horizontal: 16.0), 
                  padding: const EdgeInsets.symmetric(vertical: 3.0), // Further reduced padding
                  decoration: BoxDecoration(
                    // Use solid, darker primary color
                    color: Color.alphaBlend(Colors.black.withOpacity(0.25), colorScheme.primary),
                    // Round only bottom corners 
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(12.0), 
                    ),
                  ),
                  // Use a Row for text and arrow
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center content
                    mainAxisSize: MainAxisSize.min, // Don't stretch row
                    children: [
                      Text(
                        'View More Ride Details', // Updated text
                        style: textTheme.labelSmall?.copyWith( // Reduced text size
                          color: colorScheme.onPrimary, // Use onPrimary for contrast
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4), // CONST
                      Icon(
                        Icons.arrow_forward_ios, // Simple arrow icon
                        size: 12, // Small icon size
                        color: colorScheme.onPrimary, // Use onPrimary for contrast
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationRow(String label, String location) {
    // Remove the prefix like 'Pickup: ' or 'Drop: '
    final locationText = location.replaceFirst(RegExp(r'^\w+: '), '');
    return RichText(
      text: TextSpan(
        // Default style from theme
        style: Theme.of(context).textTheme.bodyMedium, 
        children: [
          TextSpan(
            text: '$label: ', // Label with space
            // Make label bold
            style: const TextStyle(fontWeight: FontWeight.bold), 
          ),
          TextSpan(
            text: locationText, // Location text without prefix
            // Greyish color for location
            style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant), 
          ),
        ],
      ),
    );
  }
}