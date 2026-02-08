import 'package:flutter/material.dart';
import 'package:aura1/models/user_model.dart';
import 'package:aura1/services/api_service.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final result = await _apiService.login(email, password);

    _isLoading = false;
    if (result['success']) {
      _user = User.fromJson(result['data']['user']);
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

  Future<String?> register(String name, String email, String password,
      String confirmPassword) async {
    _isLoading = true;
    notifyListeners();

    final result =
        await _apiService.register(name, email, password, confirmPassword);

    if (result['success']) {
      // Registration successful, now auto-login
      final loginSuccess = await login(email, password);
      if (loginSuccess) {
        return null; // Success (no error message)
      } else {
        _isLoading = false;
        notifyListeners();
        return "Registration successful, but login failed. Please sign in manually.";
      }
    } else {
      _isLoading = false;
      notifyListeners();
      return result['message'] ?? "Registration failed";
    }
  }

  Future<void> logout() async {
    await _apiService.removeToken();
    _user = null;
    notifyListeners();
  }
}
