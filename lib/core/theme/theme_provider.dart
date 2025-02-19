import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  ThemeProvider() {
    _loadThemePreference();
  }

  // Load saved theme preference
  Future<void> _loadThemePreference() async {
    Brightness brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    bool isSystemThemeDark = brightness == Brightness.dark;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool('darkTheme') ?? isSystemThemeDark;
    notifyListeners();
  }

  // Toggle theme and save preference
  Future<void> toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkTheme', _isDarkTheme);
    notifyListeners();
  }
}
