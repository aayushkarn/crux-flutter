import 'package:crux/api/sentiment_score.dart';
import 'package:flutter/material.dart';

class SentimentBar extends StatelessWidget {
  final SentimentScore score;
  final double height;
  final double width;

  const SentimentBar({
    Key? key,
    required this.score,
    this.height = 16.0,
    this.width = 105.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = score.negative + score.neutral + score.positive;

    final negWidth = (score.negative / total) * width;
    final neuWidth = (score.neutral / total) * width;
    final posWidth = (score.positive / total) * width;

    return Row(
      children: [
        Container(width: negWidth, height: height, color: Colors.red),
        Container(width: neuWidth, height: height, color: Colors.blue),
        Container(width: posWidth, height: height, color: Colors.green),
      ],
    );
  }
}
