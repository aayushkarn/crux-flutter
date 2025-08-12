
# Crux Client in Flutter

[Crux client implementation in flutter](https://github.com/aayushkarn/crux)

Setup config.dart file inside ```lib/api/```

```bash
final String _baseUrl = "http://localhost:800";

final String _shareUrl = "http://localhost:5000";

final String baseUrl = "${_baseUrl}/api";
final String nepaliURL = "${_baseUrl}/api_nepali";

String shareUrl(clusterId) {
  return "${_shareUrl}/summary/${clusterId}";
}

String getImage(imageURL) {
  return Uri.decodeFull("${_baseUrl}/${imageURL}");
}


```
