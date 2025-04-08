import 'package:flutter/material.dart';
import 'package:via_commuter/presentation/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Via Commuter'),
      ),
      body: const Center(
        child: Text('Welcome to Via Commuter'),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
} 