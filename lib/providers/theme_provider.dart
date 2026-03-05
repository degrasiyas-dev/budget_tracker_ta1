import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    loadTheme();
  }

  void toggleTheme(bool isDark) async {

    final prefs = await SharedPreferences.getInstance();

    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

    prefs.setBool("darkMode", isDark);

    notifyListeners();
  }

  void loadTheme() async {

    final prefs = await SharedPreferences.getInstance();

    bool dark = prefs.getBool("darkMode") ?? false;

    _themeMode = dark ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();
  }
}