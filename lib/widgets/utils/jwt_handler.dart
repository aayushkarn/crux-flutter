import 'package:jose/jose.dart';

bool isTokenExpired(String? token) {
  if (token == null) {
    return true;
  }
  try {
    final jwt = JsonWebToken.unverified(token);
    final claims = jwt.claims;
    final exp = claims['exp'];

    if (exp == null) {
      return false;
    }

    final expirationTime = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    final now = DateTime.now();

    return now.isAfter(expirationTime);
  } catch (e) {
    print("Error checking expiration ${e}");
    return true;
  }
}
