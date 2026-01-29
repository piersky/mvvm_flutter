import 'package:flutter/material.dart';
import 'package:mvv_managements/constants/theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeMode = AppThemeData.lightTheme;
  ThemeData get themeMode => _themeMode;
  final String isDarkModeKey = 'isDarkMode';

  Future<void> toggleTheme() async {
    // Implementation for toggling the theme
    final prefs = await SharedPreferences.getInstance();
    _themeMode = _themeMode == AppThemeData.lightTheme
        ? AppThemeData.darkTheme
        : AppThemeData.lightTheme;
    await prefs.setBool(isDarkModeKey, _themeMode == AppThemeData.darkTheme);
    notifyListeners();
  }
}
