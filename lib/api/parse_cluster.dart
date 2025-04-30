import 'dart:convert';

import 'package:crux/api/cluster.dart';

List<Cluster> parseCluster(String jsonString) {
  // final Map<String, dynamic> jsonData = json.decode(jsonString);
  // return Cluster.fromJson(jsonData);
  List<dynamic> jsonData = json.decode(jsonString);
  return jsonData.map((data) => Cluster.fromJson(data)).toList();
}
