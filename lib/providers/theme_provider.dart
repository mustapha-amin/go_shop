import 'package:flutter/material.dart';
import '/services/theme_prefs.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = ThemeSettings.getTheme();
  bool get themeStatus => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    ThemeSettings.setTheme(_isDark);
    notifyListeners();
  }
}
