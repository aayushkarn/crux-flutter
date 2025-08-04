import 'package:crux/api/api_handler.dart';
import 'package:crux/api/cluster.dart';
import 'package:crux/api/config.dart';
import 'package:crux/widgets/utils/message_template.dart';
import 'package:crux/widgets/screens/sources/source_feed_default.dart';
import 'package:crux/widgets/screens/sources/source_feed_detail.dart';
import 'package:crux/widgets/utils/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NepaliPage extends StatefulWidget {
  const NepaliPage({super.key});

  @override
  State<NepaliPage> createState() => _NepaliPageState();
}

class _NepaliPageState extends State<NepaliPage> {
  bool _isImageAtTop = false;
  late Future<List<Cluster>> articles;
  late ValueNotifier<bool> isImageAtTopNotifier;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    articles = getArticles(context, nepaliURL);
    isImageAtTopNotifier = ValueNotifier<bool>(_isImageAtTop);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    isImageAtTopNotifier.dispose();
    super.dispose();
  }

  Future<void> refreshArticles() async {
    setState(() {
      articles = getArticles(context, nepaliURL);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cluster>>(
      key: UniqueKey(),
      future: articles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MessageTemplate(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          List<Cluster> cluster = snapshot.data!;

          if (cluster.isEmpty) {
            return Scaffold(
              body: MessageTemplate(message: 'No data available'),
            );
          }

          return RefreshIndicator(
            onRefresh: refreshArticles,
            child: PageView.builder(
              itemCount: cluster.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   _isImageAtTop = !_isImageAtTop;
                    // });
                    // print("TAPPED");
                    isImageAtTopNotifier.value = !isImageAtTopNotifier.value;
                    // print("isImageAtTop: ${isImageAtTopNotifier.value}");
                  },
                  onHorizontalDragUpdate: (details) {
                    if (details.primaryDelta! > 0) {
                      // print("Swiped right");
                      HapticFeedback.mediumImpact();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => WebviewHandler(
                                link: cluster[index].source[0].link,
                              ),
                        ),
                      );
                    }
                  },
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 200),
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                    ) {
                      // return FadeTransition(opacity: animation, child: child);
                      return FadeTransition(
                        opacity: CurvedAnimation(
                          parent: animation,
                          curve: Curves.ease,
                        ),
                        child: child,
                      );
                    },
                    child: ValueListenableBuilder<bool>(
                      valueListenable: isImageAtTopNotifier,
                      builder: (context, value, child) {
                        return isImageAtTopNotifier.value
                            ? SourceFeedDetail(
                              article: cluster[index],
                              language: "ENGLISH",
                            )
                            : SourceFeedDefault(
                              article: cluster[index],
                              language: "NEPALI",
                            );
                      },
                    ),
                  ),
                );
              },
              scrollDirection: Axis.vertical,
            ),
          );
        } else if (snapshot.hasError) {
          return MessageTemplate(
            message: "Unable to fetch articles\n${snapshot.error}",
            child: Column(
              children: [
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: refreshArticles,
                    child: Text(
                      "Refresh",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return MessageTemplate(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
