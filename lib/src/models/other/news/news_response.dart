import 'package:business/src/models/other/news/article.dart';

class NewsResponse {
  int? currentPage;
  int? lastPage;
  List<Article>? articles;
  int? total;

  NewsResponse({this.currentPage, this.lastPage, this.total, this.articles});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
        currentPage: json['current_page'] ?? 0,
        lastPage: json['last_page'] ?? 0,
        total: json['total'] ?? 0,
        articles: ((json['articles'] ?? []) as List)
            .map((e) => Article.fromJson(e))
            .toList());
  }
}
