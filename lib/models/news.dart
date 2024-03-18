import 'dart:convert';

List<News> newsFromJson(String str) =>
    List<News>.from(json.decode(str).map((x) => News.fromJson(x)));

String newsToJson(List<News> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class News {
  int newsId;
  String title;
  String body;
  String image;
  DateTime date;

  News({
    required this.newsId,
    required this.title,
    required this.body,
    required this.image,
    required this.date,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
        newsId: json["news_id"],
        title: json["title"],
        body: json["body"],
        image: json["image"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "news_id": newsId,
        "title": title,
        "body": body,
        "image": image,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
