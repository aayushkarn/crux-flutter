import 'package:crux/api/cluster.dart';
import 'package:crux/api/config.dart';
import 'package:crux/widgets/screens/saved/detail_screen.dart';
import 'package:crux/services/bookmark.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  late Future<List<Cluster>> bookmarks;

  @override
  void initState() {
    super.initState();
    Provider.of<Bookmark>(context, listen: false).loadBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkManager = Provider.of<Bookmark>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: () async {
            await bookmarkManager.loadBookmarks();
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "My Bookmarks",
                      style: TextStyle(
                        fontFamily: 'public_sans',
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                        color: Colors.black,
                        // decoration: TextDecoration.underline,
                        // decorationColor: Colors.green.shade400,
                        decorationThickness: 2.0,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(height: 1, color: Colors.grey.withAlpha(30)),
              SizedBox(height: 10),
              Consumer<Bookmark>(
                builder: (context, bookmarkProvider, _) {
                  final data = bookmarkProvider.bookmarks;
                  if (data.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          DetailScreen(article: data[index]),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Dismissible(
                                  key: Key(data[index].clusterId),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    print("deleted");
                                    bookmarkManager.removeBookmark(
                                      data[index].clusterId,
                                    );
                                  },
                                  background: Container(
                                    color: Colors.red,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          child: SizedBox(
                                            width: 80,
                                            height: 80,
                                            child: Image.network(
                                              "${getImage(data[index].source[0].image)}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        title: GestureDetector(
                                          onLongPress: () {
                                            Fluttertoast.showToast(
                                              msg:
                                                  "${data[index].source[0].title}",
                                            );
                                          },
                                          child: Text(
                                            "${data[index].source[0].title}", // Title of the card
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
                                          'Published on: ${data[index].source[0].publishTimestamp}', // Publish date
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontFamily: 'Kanit',
                                          ),
                                        ),
                                        trailing: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            40,
                                          ),
                                          child: GestureDetector(
                                            onLongPress: () {
                                              Fluttertoast.showToast(
                                                msg:
                                                    "${data[index].source[0].sourceName}",
                                              );
                                            },
                                            child: SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: Image.network(
                                                "${getImage(data[index].source[0].sourceLogo)}",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        height: 1,
                                        color: Colors.grey.withAlpha(30),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Column(
                        children: [
                          // Icon(
                          //   Icons.highlight_alt_rounded,
                          //   size: 40,
                          //   color: Colors.grey,
                          // ),
                          Text(
                            "Bookmark is empty!",
                            style: TextStyle(
                              fontFamily: 'public_sans',
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Add articles to bookmark to show here!"),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
