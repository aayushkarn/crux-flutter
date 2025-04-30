import 'package:crux/api/article.dart';
import 'package:crux/api/cluster.dart';
import 'package:crux/api/config.dart';
import 'package:crux/widgets/screens/sources/source_avatar.dart';
import 'package:crux/services/bookmark.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class SourceNav extends StatefulWidget {
  // final List<Map<String, String>> articles;
  final String clusterId;
  final List<Article> articles;
  final Cluster tempCluster; //TODO: remove later

  const SourceNav({
    super.key,
    required this.articles,
    required this.clusterId,
    required this.tempCluster,
  });

  @override
  State<SourceNav> createState() => _SourceNavState();
}

class _SourceNavState extends State<SourceNav> {
  final int maxAvatarsToShow = 2;
  // late Future<bool> isBookmarked;
  // Bookmark bookmark = Bookmark();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final bookmark = Provider.of<Bookmark>(context, listen: false);
    // isBookmarked = bookmark.isArticleBookmarked(widget.clusterId);
    // print(isBookmarked);
  }

  @override
  Widget build(BuildContext context) {
    // bool isValidUrl(String str) {
    //   final regex = RegExp(
    //     r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$',
    //     caseSensitive: false,
    //   );
    //   return regex.hasMatch(str);
    // }

    ;
    final bookmark = Provider.of<Bookmark>(context);
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                bottomModelViewer(context, widget.articles);
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  for (
                    int i = 0;
                    i <
                        (widget.articles.length > maxAvatarsToShow
                            ? maxAvatarsToShow
                            : widget.articles.length);
                    i++
                  )
                    Positioned(
                      left: i * 20,
                      top: 0,
                      child: CircleAvatar(
                        radius: 23,
                        backgroundImage: NetworkImage(
                          "${getImage(widget.articles[i].sourceLogo)}",
                        ),
                      ),
                    ),
                  if (maxAvatarsToShow < widget.articles.length)
                    Positioned(
                      left: maxAvatarsToShow * 20,
                      top: 0,
                      child: CircleAvatar(
                        radius: 23,
                        backgroundColor: Colors.blueGrey,
                        child: Text(
                          "+${widget.articles.length - maxAvatarsToShow}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  Positioned(
                    left:
                        (widget.articles.length > maxAvatarsToShow)
                            ? (maxAvatarsToShow + 1) * 28
                            : (widget.articles.length + 1) * 28,
                    top: 0,
                    child: Container(
                      height: 46,
                      alignment: Alignment.center,
                      child: Text(
                        (widget.articles.length < maxAvatarsToShow &&
                                widget.articles.length == 1)
                            ? "SOURCE"
                            : "SOURCES",
                        style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Kanit',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(width: 10),
          // Expanded(
          //   flex: 2,
          //   child: Text(
          //     "SOURCES",
          //     style: TextStyle(
          //       fontSize: 15,
          //       fontStyle: FontStyle.italic,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.white,
          //       fontFamily: 'Kanit',
          //     ),
          //   ),
          // ),
          Spacer(),

          Consumer<Bookmark>(
            builder: (context, value, child) {
              return FutureBuilder<bool>(
                future: bookmark.isArticleBookmarked(widget.clusterId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return IconButton(
                      onPressed: () {},
                      icon: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasData) {
                    bool isBookmarked = snapshot.data!;
                    return IconButton(
                      onPressed: () {
                        setState(() {
                          if (isBookmarked) {
                            bookmark.removeBookmark(widget.clusterId);
                          } else {
                            bookmark.saveBookmark(widget.tempCluster);
                          }
                        });
                      },
                      icon: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                        color: Colors.white,
                        size: 29,
                      ),
                    );
                  }
                  return IconButton(
                    onPressed: () {
                      print("Error clicked");
                    },
                    icon: Icon(Icons.error, color: Colors.white),
                  );
                },
              );
            },
          ),
          // FutureBuilder<bool>(
          //   future: isBookmarked,
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return IconButton(
          //         onPressed: () {},
          //         icon: CircularProgressIndicator(),
          //       );
          //     }

          //     if (snapshot.hasData) {
          //       bool isBookmarked = snapshot.data!;
          //       return IconButton(
          //         onPressed: () {
          //           setState(() {
          //             if (isBookmarked) {
          //               bookmark.removeBookmark(widget.clusterId);
          //             } else {
          //               bookmark.saveBookmark(widget.tempCluster);
          //             }
          //             this.isBookmarked = bookmark.isArticleBookmarked(
          //               widget.clusterId,
          //             );
          //           });
          //         },
          //         icon: Icon(
          //           isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
          //           color: Colors.white,
          //           size: 29,
          //         ),
          //       );
          //     }
          //     return IconButton(
          //       onPressed: () {
          //         print("Error clicked");
          //       },
          //       icon: Icon(Icons.error, color: Colors.white),
          //     );
          //   },
          // ),
          IconButton(
            onPressed: () {
              final url = shareUrl(widget.clusterId);
              // Share.shareUri(Uri.parse(shareUrl(widget.clusterId)));
              // print(isValidUrl(url));
              Share.share(
                "${widget.articles[0].title}-Crux\n$url",
                subject: "${widget.articles[0].title}",
              );
            },
            icon: Icon(Icons.share, color: Colors.white, size: 29),
          ),
        ],
      ),
    );
  }

  void bottomModelViewer(
    BuildContext context,
    // List<Map<String, String>> articles,
    List<Article> articles,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      builder: (context) {
        return AvatarDetailSheet(articles: articles);
      },
    );
  }
}

// class SourcesNav extends StatelessWidget {
//   final List<String> avatars;
//   final List<Map<String, String>> articles;
//   const SourcesNav({super.key, required this.avatars, required this.articles});

//   @override
//   Widget build(BuildContext context) {
//     int maxAvatarsToShow = 2;
//     return SizedBox(
//       height: 50,
//       width: MediaQuery.of(context).size.width,
//       child: Row(
//         children: [
//           Expanded(
//             child: Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 for (
//                   int i = 0;
//                   i <
//                       (avatars.length > maxAvatarsToShow
//                           ? maxAvatarsToShow
//                           : avatars.length);
//                   i++
//                 )
//                   Positioned(
//                     left: i * 20,
//                     top: 0,
//                     child: GestureDetector(
//                       onTap: () {
//                         bottomModelViewer(context, i);
//                       },
//                       child: CircleAvatar(
//                         radius: 25,
//                         backgroundColor: i.isEven ? Colors.green : Colors.grey,
//                         // backgroundImage: NetworkImage(
//                         //   "https://ichef.bbci.co.uk/images/ic/1920x1080/p09xtmrp.jpg",
//                         // ),
//                       ),
//                     ),
//                   ),
//                 if (maxAvatarsToShow < avatars.length)
//                   Positioned(
//                     left: maxAvatarsToShow * 20,
//                     top: 0,
//                     child: CircleAvatar(
//                       radius: 25,
//                       backgroundColor: Colors.blueGrey,
//                       child: Text(
//                         "+${avatars.length - maxAvatarsToShow}",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           SizedBox(width: 20),
//           Expanded(
//             flex: 2,
//             child: Text(
//               "SOURCES",
//               style: TextStyle(
//                 fontSize: 25,
//                 fontStyle: FontStyle.italic,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 fontFamily: 'Kanit',
//               ),
//             ),
//           ),
//           Spacer(),
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.share, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }

//   void bottomModelViewer(BuildContext context, int i) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       enableDrag: true,
//       builder: (context) {
//         return AvatarDetailSheet(avatar: avatars[i], articles: articles);
//       },
//     );
//   }
// }
