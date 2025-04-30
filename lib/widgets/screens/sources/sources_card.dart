import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class sourcesCard extends StatelessWidget {
  final String image;
  final String title;
  final String published;
  final String sourceLogo;
  final String sourceName;

  const sourcesCard({
    super.key,
    required this.image,
    required this.title,
    required this.published,
    required this.sourceLogo,
    required this.sourceName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 80,
                height: 80,
                child: Image.network("$image", fit: BoxFit.cover),
              ),
            ),
            title: GestureDetector(
              onLongPress: () {
                Fluttertoast.showToast(msg: "$title");
              },
              child: Text(
                '$title', // Title of the card
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ),
            subtitle: Text(
              'Published on: $published', // Publish date
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontFamily: 'Kanit',
              ),
            ),
            trailing: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: GestureDetector(
                onLongPress: () {
                  Fluttertoast.showToast(msg: "$sourceName");
                },
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.network("$sourceLogo", fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(height: 1, color: Colors.grey.withAlpha(30)),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
