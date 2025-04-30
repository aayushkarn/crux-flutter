import 'package:crux/api/article.dart';

class Cluster {
  final String clusterId;
  final String summary;
  final List<Article> source;

  Cluster({
    required this.clusterId,
    required this.summary,
    required this.source,
  });

  factory Cluster.fromJson(Map<String, dynamic> json) {
    var list = json['source'] as List;
    List<Article> articles = list.map((i) => Article.fromJson(i)).toList();

    return Cluster(
      clusterId: json['cluster_id'],
      summary: json['summary'],
      source: articles,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cluster_id': clusterId,
      'summary': summary,
      'source': source.map((e) => e.toJson()).toList(),
    };
  }
}
