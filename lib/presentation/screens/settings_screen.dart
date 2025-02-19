import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_bee/core/theme/theme_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkTheme = false;
  bool _isSoundEnabled = true;
  bool _isNotificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Load saved preferences
  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkTheme = prefs.getBool('darkTheme') ?? false;
      _isSoundEnabled = prefs.getBool('soundEnabled') ?? true;
      _isNotificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    });
  }

  // Update preferences
  Future<void> _updatePreference(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(
              'Dark Theme',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text('Enable dark mode for the app'),
            value: _isDarkTheme,
            onChanged: (value) {
              setState(() {
                _isDarkTheme = value;
              });
              themeProvider.toggleTheme();
              _updatePreference('darkTheme', value);
            },
          ),
          SwitchListTile(
            title: Text(
              'Sound Effects',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text('Enable or disable sounds'),
            value: _isSoundEnabled,
            onChanged: (value) {
              setState(() {
                _isSoundEnabled = value;
              });
              _updatePreference('soundEnabled', value);
            },
          ),
          SwitchListTile(
            title: Text(
              'Notifications',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text('Enable or disable notifications'),
            value: _isNotificationsEnabled,
            onChanged: (value) {
              setState(() {
                _isNotificationsEnabled = value;
              });
              _updatePreference('notificationsEnabled', value);
            },
          ),
        ],
      ),
    );
  }
}
