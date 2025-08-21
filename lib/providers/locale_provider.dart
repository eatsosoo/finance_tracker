import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('vi');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void toggleLanguage(String mode) {
    switch (mode) {
      case '0':
        _locale = const Locale('vi');
        break;
      default:
        _locale = const Locale('en');
        break;
    }
    notifyListeners();
  }
}
