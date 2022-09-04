import '../Source/news_api.dart';

class ArticlesRepository {
  Future<List> getArticles(
      {required String endPoint,
      required Map<String, dynamic> queryParameters}) {
    return DieoHeleper.getData(path: endPoint, queryParameters: queryParameters)
        .then((response) => response.data['articles']);
  }
}
