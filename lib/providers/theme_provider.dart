import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  String _themeText = 'light';

  ThemeMode get themeMode => _themeMode;
  String get themeText => _themeText;


  void toggleTheme(String mode) {
    switch (mode) {
      case 'light':
        _themeMode = ThemeMode.light;
        _themeText = mode;
        break;
      case 'dark':
        _themeMode = ThemeMode.dark;
        _themeText = mode;
        break;
      default:
        _themeMode = ThemeMode.system;
        _themeText = 'system';
        break;
    }
    notifyListeners();
  }
}
