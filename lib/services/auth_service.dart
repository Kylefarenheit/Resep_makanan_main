// lib/services/auth_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _usersKey = 'users';
  static const String _currentUserKey = 'current_user';

  // Register
  Future<bool> register(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, String>> users = _getUsers(prefs);

    if (users.any((user) => user['email'] == email)) {
      return false;
    }

    users.add({
      'name': name,
      'email': email,
      'password': password,
    });

    await prefs.setString(_usersKey, jsonEncode(users));
    return true;
  }

  // Login
  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, String>> users = _getUsers(prefs);

    final user = users.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => {},
    );

    if (user.isEmpty) return false;

    await prefs.setString(_currentUserKey, jsonEncode(user));
    return true;
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  // Cek login
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_currentUserKey);
  }

  // ============ INI YANG DIPERBAIKI ============
  // Get current user - tambahkan async dan await
  Future<Map<String, String>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? json = prefs.getString(_currentUserKey);
    if (json != null) {
      return Map<String, String>.from(jsonDecode(json));
    }
    return null;
  }

  // Helper untuk ambil daftar users
  List<Map<String, String>> _getUsers(SharedPreferences prefs) {
    final String? usersJson = prefs.getString(_usersKey);
    if (usersJson == null) return [];
    List<dynamic> decoded = jsonDecode(usersJson);
    return decoded.map((e) => Map<String, String>.from(e)).toList();
  }
}