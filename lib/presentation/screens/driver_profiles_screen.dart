import 'package:flutter/material.dart';

class DriverProfilesScreen extends StatelessWidget {
  const DriverProfilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Profiles'),
      ),
      body: const Center(
        child: Text('Driver Profiles Screen'),
      ),
    );
  }
} 