import 'package:flutter/material.dart';
import 'package:crux/api/sentiment_score.dart';
import 'package:crux/widgets/utils/sentiment_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SentimentBadge extends StatelessWidget {
  final SentimentScore score;
  final bool small;

  const SentimentBadge({super.key, required this.score, this.small = false});

  Color _getBlendedColor(SentimentScore score) {
    final red = (score.negative * 255).clamp(0, 255).toInt();
    final green = (score.positive * 255).clamp(0, 255).toInt();
    final blue = (score.neutral * 255).clamp(0, 255).toInt(); // Optional
    return Color.fromARGB(255, red, green, blue);
  }

  void _showSentimentBar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Sentiment Breakdown",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                "Based on language tone analysis of this article",
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [SentimentBar(score: score, width: 200, height: 16)],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _legendDot(
                    context: context,
                    color: Colors.red,
                    value: score.negative,
                    tooltip: "Negative",
                  ),
                  _legendDot(
                    context: context,
                    color: Colors.blue,
                    value: score.neutral,
                    tooltip: "Neutral",
                  ),
                  _legendDot(
                    context: context,
                    color: Colors.green,
                    value: score.positive,
                    tooltip: "Positive",
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _legendDot({
    required BuildContext context,
    required Color color,
    required double value,
    required String tooltip,
  }) {
    return GestureDetector(
      onTap: () {
        print("Tapped on $tooltip: ${(value * 100).toStringAsFixed(1)}%");
        Fluttertoast.showToast(
          msg: "$tooltip: ${(value * 100).toStringAsFixed(1)}%",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: color.withValues(alpha: 800),
          textColor: Colors.white,
          fontSize: 14.0,
        );
      },
      child: Column(
        children: [
          Tooltip(
            message: tooltip,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "${(value * 100).toStringAsFixed(1)}%",
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSentimentBar(context),
      child: Container(
        decoration: BoxDecoration(
          color: _getBlendedColor(score),
          borderRadius: BorderRadius.zero,
        ),
        padding:
            small
                ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
                : const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Text(
          score.predicted.toUpperCase(),
          style: TextStyle(
            fontSize: small ? 10 : 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
