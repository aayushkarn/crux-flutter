import 'package:crux/global_key.dart';
import 'package:crux/services/auth_service.dart';
import 'package:crux/services/token_storage.dart';
import 'package:crux/widgets/home_page.dart';
import 'package:crux/widgets/screens/auth/login.dart';
import 'package:crux/widgets/utils/jwt_handler.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _accessToken;
  String? _refreshToken;
  bool _isAuthenticated = false;
  bool _isInitialized = false;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  bool get isAuthenticated => _isAuthenticated;
  bool get isInitialized => _isInitialized;

  Future<void> initializeAuth() async {
    await Future.delayed(Duration(seconds: 2));
    _accessToken = await getAccessToken();
    _refreshToken = await getRefreshToken();
    _isAuthenticated = _accessToken != null;
    _isInitialized = true;
    print("Auth Initialized: $_isAuthenticated");
    notifyListeners();
  }

  // Check if access token is expired and refresh it
  Future<void> ensureValidToken() async {
    if (_accessToken != null && isTokenExpired(_accessToken)) {
      // token expired
      print("EXPIRED TOKEN");
      await refreshAccessToken();
    }
  }

  Future<void> refreshAccessToken() async {
    try {
      final newTokens = await AuthService().refreshToken();
      if (newTokens) {
        _accessToken = await getAccessToken();
        _refreshToken = await getRefreshToken();
        notifyListeners();
      } else {
        await logout();
      }
    } catch (e) {
      await logout();
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final success = await AuthService().login(email, password);
      if (success) {
        _accessToken = await getAccessToken();
        _refreshToken = await getRefreshToken();
        _isAuthenticated = true;
        notifyListeners();
        navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(builder: (_) => HomePage()),
        );
        return true;
      }
      return false;
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      final success = await AuthService().register(name, email, password);
      print("REGISTER ${success}");
      if (success) {
        _accessToken = await getAccessToken();
        _refreshToken = await getRefreshToken();
        _isAuthenticated = true;
        notifyListeners();
        navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(builder: (_) => HomePage()),
        );
        return true;
      }
      return false;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await AuthService().logout();
    _accessToken = null;
    _refreshToken = null;
    _isAuthenticated = false;
    _isInitialized = true;
    print("Logged out, isAuthenticated: $_isAuthenticated");

    try {
      notifyListeners();
      navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (_) => Login()),
      );
      print("NotifyListeners called");
      await initializeAuth();
    } catch (e) {
      print("error is ${e}");
    }
  }
}
