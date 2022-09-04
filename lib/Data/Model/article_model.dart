// ignore_for_file: prefer_initializing_formals

class ArticleModel {
  Map<String, dynamic>? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  ArticleModel(
      {required Map<String, dynamic> source,
      required String? author,
      required String? title,
      required String? description,
      required String? url,
      required String? urlToImage,
      required String? publishedAt,
      required String? content}) {
    this.source = source;
    this.author = author;
    this.title = title;
    this.description = description;
    this.url = url;
    this.urlToImage = urlToImage;
    this.publishedAt = publishedAt;
    this.content = content;
  }
}

Map<String, dynamic> article = {
  "source": {"id": "google-news", "name": "Google News"},
  "author": null,
  "title":
      "«المتحدة» تحصل على حقوق رعاية كرة القدم في الأهلي لمدة 4 مواسم - Al Masry Al Youm - المصري اليوم",
  "description": null,
  "url":
      "https://news.google.com/__i/rss/rd/articles/CBMiMmh0dHBzOi8vd3d3LmFsbWFzcnlhbHlvdW0uY29tL25ld3MvZGV0YWlscy8yNjczMDQy0gEA?oc=5",
  "urlToImage": null,
  "publishedAt": "2022-08-23T22:33:04Z",
  "content": null
};
