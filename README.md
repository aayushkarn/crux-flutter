
# Crux Client in Flutter

[Crux client implementation in flutter](https://github.com/aayushkarn/crux)

```bash
final String _baseUrl = "http://localhost:800";

final String _shareUrl = "http://localhost:5000";

final String baseUrl = "${_baseUrl}/api";

String shareUrl(clusterId) {
  return "${_shareUrl}/summary/${clusterId}";
}

String getImage(imageURL) {
  return Uri.decodeFull("${_baseUrl}/${imageURL}");
}


```