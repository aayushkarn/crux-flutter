import 'package:crux/api/cluster.dart';
import 'package:crux/api/config.dart';
import 'package:crux/api/sentiment_score.dart';
import 'package:crux/widgets/screens/sentiment_badge.dart';
import 'package:crux/widgets/screens/sources/source_nav.dart';
import 'package:flutter/material.dart';

class SourceFeedDefault extends StatelessWidget {
  // final List<Map<String, String>> articles;
  // final List<Article> article;
  final Cluster article;
  final String language;

  const SourceFeedDefault({
    super.key,
    required this.article,
    this.language = "ENGLISH",
  });

  String get font => language == "NEPALI" ? 'NotoSans' : 'PublicSans';

  @override
  Widget build(BuildContext context) {
    // remove this if unecessary
    precacheImage(NetworkImage(getImage(article.source[0].image)), context);
    SentimentScore? sentiment = article.sentiments;

    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("${getImage(article.source[0].image)}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(child: Container(color: Colors.black.withAlpha(150))),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.black.withAlpha(200),
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          if (sentiment != null)
            Positioned(
              child: SentimentBadge(score: sentiment),
              top: 50,
              right: 20,
            ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "${article.source[0].title}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: font,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 4,
                ),
              ),
              SizedBox(height: 20),
              // Container(height: 50, child: Text("Hello")),
              // SizedBox(height: 20),
              Flexible(
                // height: 20,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SourceNav(
                    articles: article.source,
                    clusterId: article.clusterId,
                    tempCluster: article,
                  ),

                  // child: SourcesNav(
                  // avatars: ['BBC', 'NDTV', 'CNN'],
                  // articles: articles,
                  // ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
