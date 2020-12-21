import 'dart:core';

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
