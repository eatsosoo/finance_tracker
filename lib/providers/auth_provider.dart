import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final _authService = AuthService();

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<bool> login(String email, String password) async {
    final result = await _authService.login(email, password);
    _isLoggedIn = result;
    notifyListeners();
    return result;
  }

  Future<bool> register(String email, String password, String tel) async {
    final result = await _authService.register(email, password, tel);
    _isLoggedIn = result;
    notifyListeners();
    return result;
  }
}