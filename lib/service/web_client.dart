import 'package:dio/dio.dart';

import 'interceptors/logging_interceptors.dart';

Future<Response> httpGet(path) async {
  Dio dio = createDio();
  return await dio.get(path);
}

Future<Response> httpPost(path, data) async {
  Dio dio = createDio();
  return await dio.post(path, options: getHeader(), data: data);
}

Dio createDio() {
  return addInterceptors(Dio(addOptions()));
}

Dio addInterceptors(Dio dio) {
  return dio..interceptors.add(LoggingInterceptors());
}

BaseOptions addOptions() {
  return BaseOptions(
    baseUrl: 'http://localhost:8080',
    receiveTimeout: 15000,
    connectTimeout: 15000,
  );
}

getHeader() {
  return Options(
      headers: {'Content-type': 'application/json', 'password': '1000'});
}
