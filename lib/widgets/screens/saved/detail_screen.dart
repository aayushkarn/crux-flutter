import 'package:crux/api/cluster.dart';
import 'package:crux/widgets/screens/sources/source_feed_detail.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Cluster article;
  const DetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    print(article.source[0].title);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close_rounded, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        title: Text(
          article.source[0].title,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SourceFeedDetail(article: article),
    );
  }
}
