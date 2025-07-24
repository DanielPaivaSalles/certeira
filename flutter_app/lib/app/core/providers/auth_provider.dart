import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../app/modules/auth/models/login_model.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _token;
  Map<String, dynamic>? _userData;

  bool get isLoggedIn => _isLoggedIn;
  String? get token => _token;
  Map<String, dynamic>? get userData => _userData;

  Future<void> saveSession(LoginResponse loginResponse) async {
    final prefs = await SharedPreferences.getInstance();

    _isLoggedIn = true;
    _token = loginResponse.token;
    _userData = loginResponse.usuario;

    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('token', loginResponse.token ?? '');
    await prefs.setString('userData', jsonEncode(loginResponse.usuario));

    notifyListeners();
  }

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();

    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _token = prefs.getString('token');

    final userDataString = prefs.getString('userData');
    if (userDataString != null) {
      _userData = jsonDecode(userDataString);
    }

    notifyListeners();
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();

    _isLoggedIn = false;
    _token = null;
    _userData = null;

    await prefs.clear();

    notifyListeners();
  }

  Map<String, String> getAuthHeaders() {
    return {
      'Content-Type': 'application/json',
      if (_token != null) 'Authorization': 'Bearer $_token',
    };
  }
}
