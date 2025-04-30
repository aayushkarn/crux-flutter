import 'dart:convert';

import 'package:crux/api/cluster.dart';
import 'package:crux/api/config.dart';
import 'package:crux/api/profile_model.dart';
import 'package:crux/services/auth_provider.dart';
import 'package:crux/services/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';

final storage = FlutterSecureStorage();
// final AuthProvider _authProvider = AuthProvider();

Future<List<Cluster>> getArticles(BuildContext context) async {
  final _authProvider = Provider.of<AuthProvider>(context, listen: false);

  try {
    await _authProvider.ensureValidToken();
  } catch (e) {
    print("Error validating token: $e");
    await _authProvider.logout();
    return [];
  }

  final token = await getAccessToken();
  print("API HANDLER ${token}");
  if (token == null) {
    print("No token found, user not logged in");
    await _authProvider.logout();

    return [];
  }
  try {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<Cluster> list = [];

      for (int i = 0; i < data.length; i++) {
        final entry = data[i];
        list.add(Cluster.fromJson(entry));
      }
      return list;
    } else {
      throw Exception("Http failed!");
    }
  } catch (e) {
    throw Exception("Error fetching articles ${e}");
  }
}

Future<UserProfile> getProfile(BuildContext context) async {
  final _authProvider = Provider.of<AuthProvider>(context, listen: false);

  try {
    await _authProvider.ensureValidToken();
  } catch (e) {
    print("Error validating token: $e");
    await _authProvider.logout();
    throw Exception("Token validation failed: ${e.toString()}");
  }

  final token = await getAccessToken();
  print("API HANDLER ${token}");
  if (token == null) {
    print("No token found, user not logged in");
    await _authProvider.logout();

    throw Exception("User not logged in");
  }
  try {
    final response = await http.get(
      Uri.parse("${baseUrl}/me"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserProfile.fromJson(data);
    } else {
      throw Exception("Http failed!");
    }
  } catch (e) {
    throw Exception("Error fetching profile ${e}");
  }
}
