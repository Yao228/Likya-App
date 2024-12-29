import 'package:dio/dio.dart';

class DioProvider {
  static Dio createDioWithoutHeader() {
    Dio dio = Dio(BaseOptions(
      baseUrl: "https://test.likya.pro",
      //connectTimeout: const Duration(seconds: 5),
      //receiveTimeout: const Duration(seconds: 3),
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (e, handler) {
        handler.next(e);
      },
    ));

    return dio;
  }

  static Dio createDioWithHeader(Map<String, dynamic> headers) {
    Dio dio = Dio(BaseOptions(
      baseUrl: "https://test.likya.pro",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: headers,
    ));
    return dio;
  }
}
