import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('en');
  String _lang = 'en';

  Locale get locale => _locale;
  String get lang => _lang;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void toggleLanguage(String mode) {
    switch (mode) {
      case 'vi':
        _locale = Locale(mode);
        _lang = mode;
        break;
      default:
        _locale = const Locale('en');
        _lang = 'en';
        break;
    }
    notifyListeners();
  }
}
