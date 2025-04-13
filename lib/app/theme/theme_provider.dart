import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  final SharedPreferences _prefs;

  static const String _themeModeKey = 'theme_mode';
  static const String _dynamicColorKey = 'dynamic_color_enabled';

  ThemeMode _themeMode = ThemeMode.system; // Default to system
  bool _isDynamicColorEnabled = true; // Default to enabled

  ThemeNotifier(this._prefs) {
    _loadPreferences();
  }

  ThemeMode get themeMode => _themeMode;
  bool get isDynamicColorEnabled => _isDynamicColorEnabled;

  // Load saved preferences
  void _loadPreferences() {
    final savedThemeMode = _prefs.getString(_themeModeKey);
    if (savedThemeMode != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (e) => e.toString() == savedThemeMode,
        orElse: () => ThemeMode.system,
      );
    }

    _isDynamicColorEnabled = _prefs.getBool(_dynamicColorKey) ?? true;

    // Notify listeners after loading initial prefs, though usually done in main
    // notifyListeners(); 
  }

  // Update ThemeMode and save preference
  Future<void> setThemeMode(ThemeMode mode) async {
    if (mode == _themeMode) return;
    _themeMode = mode;
    await _prefs.setString(_themeModeKey, mode.toString());
    notifyListeners();
  }

  // Toggle Dynamic Color and save preference
  Future<void> setDynamicColor(bool enabled) async {
    if (enabled == _isDynamicColorEnabled) return;
    _isDynamicColorEnabled = enabled;
    await _prefs.setBool(_dynamicColorKey, enabled);
    notifyListeners();
  }
} 