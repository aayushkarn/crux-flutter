class SentimentScore {
  final double negative;
  final double neutral;
  final double positive;
  final String predicted;

  SentimentScore({
    required this.negative,
    required this.neutral,
    required this.positive,
    required this.predicted,
  });

  factory SentimentScore.fromJson(Map<String, dynamic> json) {
    return SentimentScore(
      negative: (json['negative'] as num).toDouble(),
      neutral: (json['neutral'] as num).toDouble(),
      positive: (json['positive'] as num).toDouble(),
      predicted: json['predicted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'negative': negative,
      'neutral': neutral,
      'positive': positive,
      'predicted': predicted,
    };
  }
}
