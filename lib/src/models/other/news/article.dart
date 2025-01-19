import 'package:business/src/models/other/news/article_media.dart';

class Article {
  final int? id;
  final String? title;
  final String? description;
  final List<ArticleMedia>? medias;
  const Article({this.id, this.title, this.description, this.medias});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        medias: ((json['medias'] ?? []) as List)
            .map((e) => ArticleMedia.fromJson(e))
            .toList());
  }
}
