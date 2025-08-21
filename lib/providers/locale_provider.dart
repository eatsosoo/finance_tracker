import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('vi');
  String _lang = 'vi';

  Locale get locale => _locale;
  String get lang => _lang;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void toggleLanguage(String mode) {
    switch (mode) {
      case '0':
        _locale = const Locale('vi');
        _lang = 'vi';
        break;
      default:
        _locale = const Locale('en');
        _lang = 'en';
        break;
    }
    notifyListeners();
  }
}
