import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final _storage = FlutterSecureStorage();

Future<void> saveTokens(String accessToken, String refreshToken) async {
  await _storage.write(key: 'access_token', value: accessToken);
  await _storage.write(key: 'refresh_token', value: refreshToken);
}

Future<String?> getAccessToken() => _storage.read(key: 'access_token');
Future<String?> getRefreshToken() => _storage.read(key: 'refresh_token');

Future<void> clearTokens() async {
  await _storage.deleteAll();
}
