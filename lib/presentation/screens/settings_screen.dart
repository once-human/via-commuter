import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:via_commuter/app/theme/theme_provider.dart'; // Import the provider

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the ThemeNotifier
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'Appearance',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          // Theme Mode Selection
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.brightness_6_outlined, color: colorScheme.onSurfaceVariant),
            title: const Text('Theme Mode'),
            trailing: DropdownButton<ThemeMode>(
              value: themeNotifier.themeMode,
              underline: Container(), // Remove underline
              icon: Icon(Icons.expand_more, color: colorScheme.onSurfaceVariant),
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Default'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark'),
                ),
              ],
              onChanged: (ThemeMode? mode) {
                if (mode != null) {
                  themeNotifier.setThemeMode(mode);
                }
              },
            ),
          ),
          const Divider(),
          // Dynamic Color (Material You) Toggle
          DynamicColorBuilder(
            builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
              // Only show toggle if dynamic colors are available
              final bool supportsDynamic = lightDynamic != null && darkDynamic != null;
              return SwitchListTile(
                contentPadding: EdgeInsets.zero,
                secondary: Icon(Icons.color_lens_outlined, color: colorScheme.onSurfaceVariant),
                title: const Text('Use Material You Colors'),
                subtitle: Text(
                  supportsDynamic
                      ? 'Use colors from your wallpaper (Android 12+)'
                      : 'Requires Android 12 or higher',
                ),
                value: supportsDynamic && themeNotifier.isDynamicColorEnabled,
                onChanged: supportsDynamic
                    ? (bool enabled) {
                        themeNotifier.setDynamicColor(enabled);
                      }
                    : null, // Disable toggle if not supported
              );
            },
          ),
          const SizedBox(height: 24),
          // You can add other settings sections below
        ],
      ),
    );
  }
} 