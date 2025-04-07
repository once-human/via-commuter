import 'package:flutter/material.dart';
import 'package:via_commuter/app/router.dart';
import 'package:via_commuter/app/theme/theme.dart';

class ViaApp extends StatelessWidget {
  const ViaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Via Commuter',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
