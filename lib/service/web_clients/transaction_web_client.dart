import 'dart:async';
import 'dart:convert';

import 'package:bytebank/bytebank.dart';
import 'package:dio/dio.dart';

const String _requestPath = '/transactions';

class TransactionWebClient {
  Future<List<ModelTransaction>> findAll() async {
    final Response response = await httpGet(_requestPath);
    return _toTransactions(response);
  }

  Future<ModelTransaction> save(
      ModelTransaction transaction, String password) async {
    Map<String, dynamic> transactionMap = _toMap(transaction);
    final String transactionJson = jsonEncode(transactionMap);
    Response response;
    await Future.delayed(Duration(seconds: 2));
    try {
      response = await httpPost(_requestPath, transactionJson, password);
    } on DioError catch (e) {
      _throwHttpError(e);
    }

    return _toTransaction(response);
  }

  void _throwHttpError(DioError e) {
    switch (e.type) {
      case DioErrorType.CONNECT_TIMEOUT:
      case DioErrorType.SEND_TIMEOUT:
      case DioErrorType.RECEIVE_TIMEOUT:
        throw TimeoutException('Timeout submitting the transaction');
        break;
      case DioErrorType.RESPONSE:
        throw HttpException(_getMessage(e.response.statusCode));
        break;
      case DioErrorType.CANCEL:
        throw HttpException('Submitting transaction canceled');
        break;
      case DioErrorType.DEFAULT:
        throw HttpException('Unknown error');
        break;
    }
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode))
      return _statusCodeResponses[statusCode];
    return 'Unknown error';
  }

  ModelTransaction _toTransaction(Response response) {
    Map<String, dynamic> json = jsonDecode(jsonEncode(response.data));
    return ModelTransaction.fromJson(json);
  }

  List<ModelTransaction> _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(jsonEncode(response.data));
    final List<ModelTransaction> transactions = decodedJson
        .map((dynamic json) => ModelTransaction.fromJson(json))
        .toList();

    return transactions;
  }

  Map<String, dynamic> _toMap(ModelTransaction transaction) {
    return transaction.toJson();
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'There was an error submitting transaction',
    401: 'Authentication failed',
    409: 'Conflicted submitting transaction. Transaction already exists',
    500: 'Internal server error'
  };
}
