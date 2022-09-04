import 'package:dio/dio.dart';

class DieoHeleper {
  static Dio? dio;
  static void createDio() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://newsapi.org/', receiveDataWhenStatusError: true));
  }

  static Future<Response> getData(
      {String? path, Map<String, dynamic>? queryParameters}) async {
    return await dio!.get(path!, queryParameters: queryParameters);
  }
}
