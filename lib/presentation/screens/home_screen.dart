import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui'; // Import for ImageFilter
import 'dart:math'; // Import for math functions (cos, sin)
import 'package:via_commuter/presentation/widgets/bottom_navbar.dart';
import 'package:via_commuter/presentation/screens/ride_detail_screen.dart'; // Import detail screen
// Add animation imports
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:via_commuter/app/theme/colors.dart'; // <-- ADD IMPORT for kPrimaryGreen

// Import walkthrough packages
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --- Custom Painter for the Arrow ---
class DottedCurveArrowPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  DottedCurveArrowPainter({
    this.color = Colors.white,
    this.strokeWidth = 2.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Define the curve control points relative to the canvas size
    // Start near bottom center, curve up towards top center
    final startPoint = Offset(size.width * 0.5, size.height * 0.9);
    // Adjust control point for a more pronounced curve
    final controlPoint = Offset(size.width * 0.05, size.height * 0.05); 
    final endPoint = Offset(size.width * 0.5, size.height * 0.1);

    final path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    // Draw the dotted line effect
    const double dashWidth = 5.0;
    const double dashSpace = 4.0;
    double distance = 0.0;

    // Use a single metric computation
    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) return; // Should not happen for a valid path
    final metric = metrics.first;

    while (distance < metric.length) {
      canvas.drawPath(
        metric.extractPath(distance, distance + dashWidth),
        paint,
      );
      distance += dashWidth + dashSpace;
    }

    // Draw arrowhead at the end
    final arrowSize = 10.0;
    final angle = 3.14159 / 6; // 30 degrees

    // Calculate the angle of the last segment of the curve
    // We need the tangent at the end point
    final tangent = metric.getTangentForOffset(metric.length);
    if (tangent == null) return; // Should not happen

    final arrowAngle = tangent.angle;

    // Arrow line 1
    final arrowPath1 = Path();
    arrowPath1.moveTo(endPoint.dx, endPoint.dy);
    arrowPath1.lineTo(
      endPoint.dx - arrowSize * cos(arrowAngle - angle),
      endPoint.dy - arrowSize * sin(arrowAngle - angle),
    );

    // Arrow line 2
    final arrowPath2 = Path();
    arrowPath2.moveTo(endPoint.dx, endPoint.dy);
    arrowPath2.lineTo(
      endPoint.dx - arrowSize * cos(arrowAngle + angle),
      endPoint.dy - arrowSize * sin(arrowAngle + angle),
    );

    // Draw the arrowhead lines (using the same paint for simplicity)
    canvas.drawPath(arrowPath1, paint);
    canvas.drawPath(arrowPath2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint unless properties change
  }
}
// --- End Custom Painter ---

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

  // --- Walkthrough State ---
  final GlobalKey _bookRideKey = GlobalKey(); // Key for the Book Ride button
  final GlobalKey _todayOtpKey = GlobalKey(); // Key for Today's OTP
  final GlobalKey _todayViewMoreKey = GlobalKey(); // Key for Today's View More
  TutorialCoachMark? _confirmationTutorialCoachMark;
  TutorialCoachMark? _mainTutorialCoachMark;
  // --- End Walkthrough State ---

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

    // Check and Show Tutorial after build
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkAndShowTutorial());
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

  // --- Walkthrough Methods ---
  Future<void> _checkAndShowTutorial() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance(); // DEBUG: Commented out
    // bool hasSeenTutorial = prefs.getBool('hasSeenBookRideTutorial') ?? false; // DEBUG: Commented out

    // if (!hasSeenTutorial) { // DEBUG: Commented out condition
      // Show confirmation overlay first
      // bool? userWantsTutorial = await showDialog<bool>( ... ); // REMOVED DIALOG
      
      // If user declined or dismissed, mark as seen and exit
      // if (userWantsTutorial != true) { ... } // REMOVED DIALOG CHECK

      // If user agreed, proceed with showing the tutorial
      // _createTutorial(); // Call the new confirmation tutorial instead
      _showConfirmationTutorial();
    // }
  }

  // Shows the initial Yes/No overlay
  void _showConfirmationTutorial() {
    _confirmationTutorialCoachMark?.finish(); // Dismiss previous instance if any

    List<TargetFocus> targets = [];
    // Get screen size for positioning
    final Size screenSize = MediaQuery.of(context).size;

    targets.add(
      TargetFocus(
        identify: "Confirmation",
        // Provide a targetPosition (e.g., screen center) since no keyTarget
        targetPosition: TargetPosition(
          Size.zero,      // Correct first argument: Target size is zero (invisible focus)
          Offset(screenSize.width * 0.5, screenSize.height * 0.5), // Correct second argument: Offset position
        ),
        // alignSkip: Alignment.bottomRight, // Keep skip alignment if needed (though button is custom now)
        shape: ShapeLightFocus.Circle, 
        radius: 0, // Make focus invisible
        contents: [
          TargetContent(
            align: ContentAlign.custom,
            customPosition: CustomTargetContentPosition(
              top: screenSize.height * 0.4, // Keep custom content positioning
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Quick Tour?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Would you like a brief tour?",
                  style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16.0),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(foregroundColor: Colors.white70),
                      onPressed: () {
                         _confirmationTutorialCoachMark?.skip(); // Trigger skip logic
                      },
                      child: const Text("Skip Tour", style: TextStyle(fontSize: 16)),
                    ),
                    SizedBox(width: 20),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12)
                      ),
                      onPressed: () {
                        _confirmationTutorialCoachMark?.finish(); // Close this overlay
                        _showMainTutorial(); // Start the main tutorial
                      },
                      child: const Text("Yes, Please!", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      )
    );


    _confirmationTutorialCoachMark = TutorialCoachMark(
        targets: targets,
        colorShadow: Colors.black.withOpacity(0.85),
        skipWidget: Container(), // Hide default skip button
        paddingFocus: 0,
        opacityShadow: 0.85,
        imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        useSafeArea: true, // Important for positioning
        onFinish: () {
          print("Confirmation Tutorial Finished.");
        },
        onSkip: () {
          // Mark as seen if user skips confirmation
          // _markTutorialSkipped(); // DEBUG: Commented out
           print("User skipped confirmation tutorial.");
          return true; // Allow skip
        },
    )..show(context: context);
  }


  // Shows the main feature walkthrough
  void _showMainTutorial() {
     _mainTutorialCoachMark?.finish(); // Dismiss previous just in case

    _mainTutorialCoachMark = TutorialCoachMark(
      targets: _createMainTutorialTargets(), // Use the main targets
      colorShadow: Colors.black.withOpacity(0.85), // Keep base color dark
      skipWidget: Container(), // Hide the default button entirely
      paddingFocus: 10,
      opacityShadow: 0.7, // REDUCED OPACITY
      imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Slightly less blur
      onFinish: () {
        // Mark as seen when the *main* tutorial finishes (or is skipped)
        // SharedPreferences prefs = await SharedPreferences.getInstance(); // DEBUG: Commented out
        // await prefs.setBool('hasSeenBookRideTutorial', true); // DEBUG: Commented out
        print("Main Tutorial finished."); // DEBUG: Simplified message
      },
      onClickTarget: (target) {
        print('target clicked: ${target.identify}');
        // Handle specific interactions like navigating on the last step
        if (target.identify == "ViewMoreButton") {
           _triggerViewMoreNavigation(target.keyTarget);
        }
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        print("target ${target.identify} tapped at: ${tapDetails.globalPosition}");
      },
      onSkip: () {
        // Mark as seen if user skips main tutorial at any step
        _markTutorialSkipped(); // This handles the async prefs saving
        print("Main tutorial skip initiated.");
        return true; // Return true synchronously to dismiss
      },
    )..show(context: context);
  }


  // Helper to trigger navigation for the 'View More' step
  void _triggerViewMoreNavigation(GlobalKey? key) {
     // Find the 'Today' ride data again (assuming it's the first if available)
     if (hasUpcomingRides) {
        final rideData = upcomingRides.firstWhere((ride) => ride['date'] == 'Today', orElse: () => upcomingRides.first);
        final String heroTag = 'rideCard_${rideData['date'] ?? 'nodate'}_${rideData['pickupTime'] ?? 'notime'}';

        // Simulate the tap action
        HapticFeedback.heavyImpact();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RideDetailScreen(
              rideData: rideData,
              heroTag: heroTag,
            ),
          ),
        );
     }
  }

  // Helper function to handle async SharedPreferences update on skip
  Future<void> _markTutorialSkipped() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance(); // DEBUG: Commented out
    // await prefs.setBool('hasSeenBookRideTutorial', true); // DEBUG: Commented out
    print("Tutorial skipped and marked as seen in SharedPreferences.");
  }

  // Creates the targets for the MAIN walkthrough
  List<TargetFocus> _createMainTutorialTargets() {
    List<TargetFocus> targets = [];
    int currentStep = 0;

    // --- Determine Total Steps --- 
    int totalSteps = 1; // Start with Book Ride button
    if (hasUpcomingRides && _todayOtpKey.currentContext != null) totalSteps++;
    if (hasUpcomingRides && _todayViewMoreKey.currentContext != null) totalSteps++;
    
    // --- Target 1: Book Ride Button (Header) ---
    currentStep++;
    targets.add(
      TargetFocus(
        identify: "BookRideButton",
        keyTarget: _bookRideKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom, 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Progress Indicator
                _buildTutorialProgressRow(currentStep, totalSteps),
                const SizedBox(height: 15),
                // Arrow and Text
                Center(child: SizedBox(width: 60, height: 50, child: CustomPaint(painter: DottedCurveArrowPainter()))),
                Text("Book Your Ride", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0)),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 20.0), 
                  child: Text("Tap here to start booking a new ride.", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16.0)),
                ),
                // Action Button
                _buildTutorialActionButton(currentStep: currentStep, totalSteps: totalSteps),
              ],
            ),
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 12,
      ),
    );

    // --- Target 2: OTP on Today Card (if available) ---
    if (hasUpcomingRides && _todayOtpKey.currentContext != null) {
        currentStep++;
        targets.add(
          TargetFocus(
            identify: "OtpToday",
            keyTarget: _todayOtpKey, 
            contents: [
              TargetContent(
                align: ContentAlign.bottom, // CHANGED: Content below the OTP
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Progress Indicator (First)
                    _buildTutorialProgressRow(currentStep, totalSteps),
                    const SizedBox(height: 15),
                    // Arrow (Upward)
                    Center(child: SizedBox(width: 60, height: 50, child: CustomPaint(painter: DottedCurveArrowPainter()))), // REMOVED Transform.rotate
                    // Text
                    Text("Ride OTP", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0)),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 20.0), // Add bottom padding
                      child: Text("This is the One-Time Password to share with your driver.", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16.0)),
                    ),
                    // Action Button (Last)
                    _buildTutorialActionButton(currentStep: currentStep, totalSteps: totalSteps), 
                  ],
                ),
              )
            ],
            shape: ShapeLightFocus.RRect,
            radius: 8,
          ),
        );
    }

    // --- Target 3: View More Button (if available) ---
    // Content position remains top, layout adjusted
     if (hasUpcomingRides && _todayViewMoreKey.currentContext != null) {
        currentStep++;
        targets.add(
          TargetFocus(
            identify: "ViewMoreButton",
            keyTarget: _todayViewMoreKey, 
            enableOverlayTab: true, 
            enableTargetTab: true, 
            contents: [
              TargetContent(
                align: ContentAlign.bottom, // CHANGED: Content below the button
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Progress Indicator (First)
                     _buildTutorialProgressRow(currentStep, totalSteps),
                     const SizedBox(height: 15),
                    // Arrow (Upward)
                    Center(child: SizedBox(width: 60, height: 50, child: CustomPaint(painter: DottedCurveArrowPainter()))), // REMOVED Transform.rotate
                    // Text
                    Text("Ride Details", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0)),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 20.0), // Add bottom padding
                      child: Text("Tap here or on the card to see full details for your upcoming ride.", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16.0)),
                    ),
                    // Action Button (Last)
                    _buildTutorialActionButton(currentStep: currentStep, totalSteps: totalSteps),
                  ],
                ),
              )
            ],
            shape: ShapeLightFocus.RRect,
            radius: 12,
          ),
        );
     }

    // --- REMOVED Update the LAST target logic --- 
    /*
    if (targets.isNotEmpty) {
      ...
    }
    */

    return targets;
  }

  // Helper widget to build the action button (NEXT or DONE)
  Widget _buildTutorialActionButton({required int currentStep, required int totalSteps}) {
    bool isLast = currentStep == totalSteps;
    return Center(
      child: isLast
        ? FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () => _mainTutorialCoachMark?.finish(),
            child: const Text("DONE"),
          )
        : TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: () => _mainTutorialCoachMark?.next(), // Use next() to go forward
            child: const Text("NEXT"), // Changed from SKIP
          ),
    );
  }

  // Helper widget for the progress indicator row
  Widget _buildTutorialProgressRow(int currentStep, int totalSteps) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text Indicator
        Text(
          '$currentStep/$totalSteps',
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
        ),
        const SizedBox(width: 15),
        // Visual Indicator
        _buildStepProgressIndicator(currentStep, totalSteps),
      ],
    );
  }

  // Helper widget to build the visual step progress indicator (dots)
  Widget _buildStepProgressIndicator(int currentStep, int totalSteps) {
    List<Widget> indicators = [];
    for (int i = 1; i <= totalSteps; i++) {
      indicators.add(
        Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 3.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i <= currentStep 
                     ? Colors.white 
                     : Colors.white.withOpacity(0.4), // Filled for current/past, faint for future
          ),
        ),
      );
    }
    return Row(mainAxisSize: MainAxisSize.min, children: indicators);
  }
  // --- End Walkthrough Methods ---

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
          key: _bookRideKey, // <<< ASSIGN THE KEY HERE
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
                                      // Use original BRIGHTER green for gradient highlight
                                      kPrimaryGreen.withOpacity(0.004), // Extremely faint
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
                                      // Use original BRIGHTER green for gradient highlight
                                      kPrimaryGreen.withOpacity(0.002), // Extremely faint
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
                                          key: isToday ? _todayOtpKey : null, // Assign key only if Today
                                          text: TextSpan(
                                            // Smaller grey prefix
                                            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                                            children: [
                                              const TextSpan(text: 'OTP '),
                                              // Large green number
                                              TextSpan(
                                                text: rideData['otp']?.toString().replaceFirst("OTP ", "") ?? "????",
                                                style: textTheme.headlineSmall?.copyWith( // Keep large size
                                                  // Use HARDCODED muted green (0xFF66BB6A) for OTP number
                                                  color: const Color(0xFF66BB6A), 
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
                // Wrap the 'View More' action bar with GestureDetector and assign key
                GestureDetector(
                   key: _todayViewMoreKey, // Assign key only if Today
                   onTap: () {
                        // Allow tutorial overlay/target tap to handle navigation
                        // Or duplicate navigation logic here if direct tap needed outside tutorial
                        print("View More Tapped Directly");
                        _triggerViewMoreNavigation(null); // Pass null or the key if needed
                   },
                   // The actual visible container
                   child: Container(
                      width: double.infinity, // Takes width from parent Column padding
                      margin: const EdgeInsets.symmetric(horizontal: 16.0), 
                      padding: const EdgeInsets.symmetric(vertical: 3.0), // Further reduced padding
                      decoration: BoxDecoration(
                        color: Color.alphaBlend(Colors.black.withOpacity(0.25), colorScheme.primary),
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12.0)), 
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('View More Ride Details', style: textTheme.labelSmall?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 4),
                          Icon(Icons.arrow_forward_ios, size: 12, color: colorScheme.onPrimary),
                        ],
                      ),
                   ),
                )
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