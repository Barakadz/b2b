class NewsCategory {
  int? id;
  String? category;

  NewsCategory({this.id, this.category});

  factory NewsCategory.fromJson(Map<String, dynamic> json) {
    return NewsCategory(id: json['id'] ?? 0, category: json['category'] ?? '');
  }
}
