import 'dart:convert';

import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/service/web_client.dart';
import 'package:dio/dio.dart';

const String _requestPath = '/transactions';

class TransactionWebClient {
  Future<List<ModelTransaction>> findAll() async {
    final Response response = await httpGet(_requestPath);
    return _toTransactions(response);
  }

  Future<ModelTransaction> save(ModelTransaction transaction) async {
    Map<String, dynamic> transactionMap = _toMap(transaction);
    final String transactionJson = jsonEncode(transactionMap);
    final Response response = await httpPost(_requestPath, transactionJson);

    return _toTransaction(response);
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
}
