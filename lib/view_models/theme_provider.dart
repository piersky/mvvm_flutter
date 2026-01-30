import 'package:flutter/material.dart';
import 'package:mvv_managements/constants/theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeMode = AppThemeData.lightTheme;
  ThemeData get themeMode => _themeMode;
  final String isDarkModeKey = 'isDarkMode';

  ThemeProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(isDarkModeKey) ?? false;
    _themeMode = isDarkMode ? AppThemeData.darkTheme : AppThemeData.lightTheme;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = _themeMode == AppThemeData.lightTheme
        ? AppThemeData.darkTheme
        : AppThemeData.lightTheme;
    await prefs.setBool(isDarkModeKey, _themeMode == AppThemeData.darkTheme);
    notifyListeners();
  }
}
