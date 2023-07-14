class Article {
  final String title;
  final List tags;
  final DateTime createdAt;
  final String author;
  final String itemId;
  Article({
    required this.title,
    required this.tags,
    required this.createdAt,
    required this.author,
    required this.itemId,
  });

  factory Article.fromJson(Map json) {
    return Article(
      title: json["title"],
      tags: json["tags"],
      createdAt: DateTime.parse(json["created_at"]),
      author: json["user"]["name"],
      itemId: json["id"],
    );
  }
}

class ArticleDetail extends Article {
  final body;
  final String url;

  ArticleDetail(
      {required String title,
      required List tags,
      required DateTime createdAt,
      required String author,
      required String itemId,
      required this.body,
      required this.url})
      : super(
            title: title,
            tags: tags,
            createdAt: createdAt,
            author: author,
            itemId: itemId);

  factory ArticleDetail.fromJson(Map json) {
    return ArticleDetail(
        title: json["title"],
        tags: json["tags"],
        createdAt: DateTime.parse(json["created_at"]),
        author: json["user"]["name"],
        itemId: json["id"],
        body: json["body"],
        url: json["url"]);
  }
}
