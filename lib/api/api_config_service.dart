import 'dart:convert';

import 'package:crux/api/api_baseurl.dart';
import 'package:http/http.dart' as http;

class ApiConfigService {
  Future<ApiBaseurl> fetchApiConfig() async {
    final response = await http.get(
      Uri.parse(
        'https://raw.githubusercontent.com/aayushkarn/temporary/refs/heads/main/api.json',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return ApiBaseurl.fromJson(json);
    } else {
      throw Exception("Failed to load config");
    }
  }
}
