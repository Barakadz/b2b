class ArticleMedia {
  final int? id;
  final String? url;
  final String? type;

  ArticleMedia({this.id, this.url, this.type});

  factory ArticleMedia.fromJson(Map<String, dynamic> json) {
    return ArticleMedia(id: json['id'], url: json['url'], type: json['type']);
  }
}
