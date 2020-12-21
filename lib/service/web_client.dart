import 'package:dio/dio.dart';

import 'interceptors/logging_interceptors.dart';

Future<Response> httpGet(path) async {
  Dio dio = createDio();
  return await dio.get(path);
}

Future<Response> httpPost(path, data, password) async {
  Dio dio = createDio();
  return await dio.post(path, options: getHeader(password), data: data);
}

Dio createDio() {
  return addInterceptors(Dio(addOptions()));
}

Dio addInterceptors(Dio dio) {
  return dio..interceptors.add(LoggingInterceptors());
}

BaseOptions addOptions() {
  return BaseOptions(
    baseUrl: baseUrl,
    receiveTimeout: 15000,
    connectTimeout: 15000,
    sendTimeout: 15000,
  );
}

getHeader(password) {
  return Options(
      headers: {'Content-type': 'application/json', 'password': password});
}

const String baseUrl = 'http://localhost:8080';
