class Article {
  final int id;
  final String title;
  final String link;
  final String image;
  final String categoryName;
  final String sourceName;
  final String sourceLogo;
  final DateTime publishTimestamp;

  Article({
    required this.id,
    required this.title,
    required this.link,
    required this.image,
    required this.categoryName,
    required this.sourceName,
    required this.sourceLogo,
    required this.publishTimestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "link": link,
      "image": image,
      "category_name": categoryName,
      "source_name": categoryName,
      "source_logo": sourceLogo,
      "publish_timestamp": publishTimestamp.millisecondsSinceEpoch ~/ 1000,
    };
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    // print(json['id'].runtimeType);

    return Article(
      // id:
      //     (json['id'] is double)
      //         ? (json['id'] as double).toInt()
      //         : json['id'] as int,
      // id: int.parse(json['id'].toString()),
      id: int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'],
      link: json['link'],
      image: json['image'],
      categoryName: json['category_name'],
      sourceName: json['source_name'],
      sourceLogo: json['source_logo'],
      // publishTimestamp: DateTime.fromMillisecondsSinceEpoch(
      //   json['publish_timestamp'] * 1000,
      //   isUtc: true,
      // ),
      publishTimestamp: DateTime.fromMillisecondsSinceEpoch(
        json['publish_timestamp'] is double
            ? (json['publish_timestamp'] as double).toInt() * 1000
            : json['publish_timestamp'] * 1000,
        isUtc: true,
      ),
    );
  }
}

// class Article {
//   final int id;
//   final String title;
//   final String link;
//   final String image;
//   final String categoryName;
//   final String sourceName;
//   final String sourceLogo;
//   final DateTime publishTimestamp;

//   Article({
//     required this.id,
//     required this.title,
//     required this.link,
//     required this.image,
//     required this.categoryName,
//     required this.sourceName,
//     required this.sourceLogo,
//     required this.publishTimestamp,
//   });

//   factory Article.fromJson(Map<String, dynamic> json) {
//     try {
//       return Article(
//         id:
//             (json['id'] is double)
//                 ? (json['id'] as double).toInt()
//                 : json['id'] as int,
//         title: json['title'],
//         link: json['link'],
//         image: json['image'],
//         categoryName: json['category_name'],
//         sourceName: json['source_name'],
//         sourceLogo: json['source_logo'],
//         publishTimestamp: DateTime.fromMillisecondsSinceEpoch(
//           json['publish_timestamp'] * 1000,
//           isUtc: true,
//         ),
//       );
//     } catch (e) {
//       print('Error parsing Article: $e');
//       // Handle the error or return a default value
//       return Article(
//         id: 0,
//         title: '',
//         link: '',
//         image: '',
//         categoryName: '',
//         sourceName: '',
//         sourceLogo: '',
//         publishTimestamp: DateTime.now(),
//       );
//     }
//   }
// }
