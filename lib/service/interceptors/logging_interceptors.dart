import 'package:dio/dio.dart';

class LoggingInterceptors extends Interceptor {
  @override
  Future onRequest(RequestOptions options) {
    print("Request url: ${options.baseUrl}");
    if (options.data != null) {
      print("Request data: ${options.data}");
    }
    if (options.headers != null) {
      print("Request headers: ${options.headers}");
    }
    return super.onRequest(options);
  }

  @override
  Future onError(DioError dioError) {
    print(
        "${dioError.message} ${(dioError.response?.request != null
            ? (dioError.response.request.baseUrl + dioError.response.request.path)
            : 'URL')}");
    return super.onError(dioError);
  }

  @override
  Future onResponse(Response response) {
    print("Response status code: ${response.statusCode}");
    print("Response status message: ${response.statusMessage}");
    print("Response data: ${response.data}");
    return super.onResponse(response);
  }
}
