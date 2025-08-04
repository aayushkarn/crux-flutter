import 'package:crux/api/article.dart';
import 'package:crux/api/config.dart';
import 'package:crux/widgets/screens/sources/sources_card.dart';
import 'package:crux/widgets/utils/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AvatarDetailSheet extends StatelessWidget {
  // final List<Map<String, String>> articles;
  final List<Article> articles;
  const AvatarDetailSheet({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Text(
                  "Sources",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Kanit',
                  ),
                ),
                SizedBox(height: 8),
                Container(height: 1, color: Colors.grey.withAlpha(30)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final item = articles[index];
                // DateTime published = DateTime.fromMillisecondsSinceEpoch(
                //   int.parse(item['publish_timestamp']!) *
                //       1000, // Parse the string to an int
                // );

                // return Text("data");
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WebviewHandler(link: item.link),
                      ),
                    );
                  },
                  child: sourcesCard(
                    image: "${getImage(item.image)}",
                    title: item.title,
                    published: "${item.publishTimestamp}",
                    sourceLogo: "${getImage(item.sourceLogo)}",
                    sourceName: item.sourceName,
                    contentSentiment: item.sentiments?["content"],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
