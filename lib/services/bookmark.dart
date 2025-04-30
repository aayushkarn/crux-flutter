import 'dart:convert';

import 'package:crux/api/cluster.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bookmark extends ChangeNotifier {
  List<Cluster> bookmarks = [];

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarkJson = prefs.getStringList("bookmarks") ?? [];
    bookmarks =
        bookmarkJson.map((e) => Cluster.fromJson(jsonDecode((e)))).toList();
    notifyListeners();
  }

  Future<void> saveBookmark(Cluster article) async {
    final pref = await SharedPreferences.getInstance();
    String articleJson = jsonEncode(article.toJson());

    List<String> bookmarks = pref.getStringList("bookmarks") ?? [];
    bookmarks.add(articleJson);
    await pref.setStringList('bookmarks', bookmarks);
    await loadBookmarks();
  }

  // Future<List<Cluster>> getBookmarks() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   List<String> bookmarksJson = prefs.getStringList("bookmarks") ?? [];

  //   List<Cluster> bookmarks =
  //       bookmarksJson.map((bookmark) {
  //         return Cluster.fromJson(jsonDecode(bookmark));
  //       }).toList();

  //   notifyListeners();
  //   return bookmarks;
  // }

  Future<void> removeBookmark(String clusterId) async {
    final pref = await SharedPreferences.getInstance();
    List<String> bookmarksJson = pref.getStringList("bookmarks") ?? [];

    bookmarksJson.removeWhere((articleJson) {
      var article = Cluster.fromJson(jsonDecode(articleJson));
      return article.clusterId == clusterId;
    });

    await pref.setStringList("bookmarks", bookmarksJson);
    await loadBookmarks();
  }

  Future<bool> isArticleBookmarked(String clusterId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarksJson = prefs.getStringList("bookmarks") ?? [];

    return bookmarksJson.any((articleJson) {
      var article = Cluster.fromJson(jsonDecode(articleJson));
      return article.clusterId == clusterId;
    });
  }
}
