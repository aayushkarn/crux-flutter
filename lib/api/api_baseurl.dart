class ApiBaseurl {
  final String apiUrl;

  ApiBaseurl({required this.apiUrl});

  factory ApiBaseurl.fromJson(Map<String, dynamic> json) {
    return ApiBaseurl(apiUrl: json['api']);
  }
}
