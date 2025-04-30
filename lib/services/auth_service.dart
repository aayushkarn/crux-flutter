import 'dart:convert';

import 'package:crux/api/config.dart';
import 'package:crux/services/token_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final _baseurl = baseUrl;

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$_baseurl/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await saveTokens(data['access_token'], data['refresh_token']);
        return true;
      } else {
        final body = jsonDecode(response.body);
        throw Exception(body['detail'] ?? 'Invalid credentials');
      }
    } catch (e) {
      print(e.toString());
      throw Exception("Login failed: ${e.toString()}");
    }
  }

  Future<bool> register(String name, String email, String password) async {
    final url = Uri.parse('$_baseurl/signup');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"name": name, "email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await saveTokens(data['access_token'], data['refresh_token']);
        return true;
      } else {
        final body = jsonDecode(response.body);
        print(body['detail'] ?? 'Error registering');
        throw Exception(body['detail'] ?? 'Error registering');
      }
    } catch (e) {
      print("Register failed: ${e.toString()}");
      throw Exception("Register failed: ${e.toString()}");
    }
  }

  Future<bool> refreshToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null)
      throw Exception("No refresh token found"); //have autologout

    final url = Uri.parse('$_baseurl/refresh');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await saveTokens(data['access_token'], data['refresh_token']);
        return true;
      } else if (response.statusCode == 401) {
        // autologout
        return false;
      } else {
        final body = jsonDecode(response.body);
        throw Exception(body['detail'] ?? 'Failed to refresh token');
      }
    } catch (e) {
      await clearTokens();
      // autologout
      throw Exception("Token refresh error: ${e.toString()}");
    }
  }

  Future<void> logout() async {
    await clearTokens();
  }

  Future<bool> validateToken(String token) async {
    final url = Uri.parse('$_baseurl/verify');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['valid'];
      } else if (response.statusCode == 401) {
        throw Exception("Access token is invalid");
      } else {
        final body = jsonDecode(response.body);
        throw Exception(body['detail'] ?? 'Failed to refresh token');
      }
    } catch (e) {
      await clearTokens();
      throw Exception("Token refresh error: ${e.toString()}");
    }
  }

  Future<bool> validateAndRefresh() async {
    final accessToken = await getAccessToken();

    if (accessToken != null) {
      bool isValid = await validateToken(accessToken);
      if (isValid) {
        return true;
      } else {
        try {
          return await refreshToken();
        } catch (_) {
          rethrow;
        }
      }
    }

    return false;
  }
}
