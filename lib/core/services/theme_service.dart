import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class ThemeService extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode {
    return _themeMode == ThemeMode.dark;
  }

  bool get isLightMode {
    return _themeMode == ThemeMode.light;
  }

  bool get isSystemMode {
    return _themeMode == ThemeMode.system;
  }

  void setTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
    // TODO: Save to local storage
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      setTheme(ThemeMode.dark);
    } else {
      setTheme(ThemeMode.light);
    }
  }

  void setSystemTheme() {
    setTheme(ThemeMode.system);
  }

  // Load theme from storage (implement with SharedPreferences)
  Future<void> loadTheme() async {
    // TODO: Load from SharedPreferences
    // final prefs = await SharedPreferences.getInstance();
    // final themeIndex = prefs.getInt('theme_mode') ?? 0;
    // _themeMode = ThemeMode.values[themeIndex];
    // notifyListeners();
  }

  // Save theme to storage (implement with SharedPreferences)
  Future<void> saveTheme() async {
    // TODO: Save to SharedPreferences
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setInt('theme_mode', _themeMode.index);
  }
}
