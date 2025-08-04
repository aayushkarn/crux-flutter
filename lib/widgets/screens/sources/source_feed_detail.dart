import 'package:crux/api/cluster.dart';
import 'package:crux/api/config.dart';
import 'package:crux/api/sentiment_score.dart';
import 'package:crux/widgets/screens/sentiment_badge.dart';
import 'package:crux/widgets/screens/sources/source_nav.dart';
import 'package:flutter/material.dart';

class SourceFeedDetail extends StatelessWidget {
  final Cluster article;
  final String language;
  const SourceFeedDetail({
    super.key,
    required this.article,
    this.language = 'ENGLISH',
  });

  String get font => language == "NEPALI" ? 'NotoSans' : 'PublicSans';

  @override
  Widget build(BuildContext context) {
    precacheImage(NetworkImage(getImage(article.source[0].image)), context);
    SentimentScore? sentiment = article.sentiments;
    print(sentiment);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container
            Stack(
              children: [
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "${getImage(article.source[0].image)}",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (sentiment != null)
                  Positioned(
                    child: SentimentBadge(score: sentiment),
                    top: 50,
                    right: 20,
                  ),
              ],
            ),

            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "${article.source[0].title}",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: font,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 4,
              ),
            ),
            SizedBox(height: 10),

            // Expanded(
            // child: Container(
            //   constraints: BoxConstraints(
            //     maxHeight: MediaQuery.of(context).size.height * 0.45,
            //   ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Text(
                    "${article.summary}",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
              ),
            ),
            // ),
            // ),
            SizedBox(height: 20),
            // Spacer(),
            Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SourceNav(
                    articles: article.source,
                    clusterId: article.clusterId,
                    tempCluster: article,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
