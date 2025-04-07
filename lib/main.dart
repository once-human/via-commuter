import 'package:flutter/material.dart';

void main() {
  runApp(const ViaCommuterApp());
}

class ViaCommuterApp extends StatelessWidget {
  const ViaCommuterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Via Commuter',
      debugShowCheckedModeBanner: false,
      home: const Placeholder(),
    );
  }
}
