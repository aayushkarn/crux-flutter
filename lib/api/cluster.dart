import 'package:crux/api/article.dart';
import 'package:crux/api/sentiment_score.dart';

class Cluster {
  final String clusterId;
  final String summary;
  final List<Article> source;
  final SentimentScore? sentiments;

  Cluster({
    required this.clusterId,
    required this.summary,
    required this.source,
    this.sentiments,
  });

  factory Cluster.fromJson(Map<String, dynamic> json) {
    var list = json['source'] as List;
    List<Article> articles = list.map((i) => Article.fromJson(i)).toList();

    SentimentScore? sentiments;
    if (json['sentiments'] != null) {
      sentiments = SentimentScore.fromJson(json['sentiments']);
    }

    return Cluster(
      clusterId: json['cluster_id'],
      summary: json['summary'],
      source: articles,
      sentiments: sentiments,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cluster_id': clusterId,
      'summary': summary,
      'source': source.map((e) => e.toJson()).toList(),
      'sentiments': sentiments?.toJson(),
    };
  }
}
