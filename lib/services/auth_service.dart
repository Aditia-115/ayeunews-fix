import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _baseUrl = 'http://45.149.187.204:3000';

  static Future<http.Response> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/api/auth/login');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static Future<String?> getToken() async {
    return _getToken();
  }

  static Future<bool> isLoggedIn() async {
    final token = await _getToken();
    return token != null && token.isNotEmpty;
  }

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}