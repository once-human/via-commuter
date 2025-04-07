import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:via_commuter/presentation/screens/splash_screen.dart';

class AppRouter {
  // Define the routes using GoRouter
  static final List<RouteBase> routes = [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const SplashScreen(),
    ),
    // Add other routes here
    // Example:
    // GoRoute(
    //   path: '/home',
    //   builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
    // ),
  ];

  // The old generateRoute method is no longer needed with go_router
  /*
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    // Add more routes here as you build
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }
  */
}
