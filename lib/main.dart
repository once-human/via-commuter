import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/router.dart';
import 'app/theme/colors.dart';
import 'app/theme/theme.dart';
import 'app/theme/theme_provider.dart';

// Instantiate the router
final GoRouter _router = GoRouter(
  routes: AppRouter.routes,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(prefs),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ThemeData lightScheme = AppTheme.light(themeNotifier.isDynamicColorEnabled ? lightDynamic : null);
        ThemeData darkScheme = AppTheme.dark(themeNotifier.isDynamicColorEnabled ? darkDynamic : null);
        
        return MaterialApp.router(
          title: 'Via Commuter',
          debugShowCheckedModeBanner: false,
          theme: lightScheme,
          darkTheme: darkScheme,
          themeMode: themeNotifier.themeMode,
          routerConfig: _router,
        );
      },
    );
  }
}
