import 'package:bytebank/bytebank.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    BytebankApp(
      contactDao: ContactDao(),
      webClient: TransactionWebClient(),
    ),
  );
}

class BytebankApp extends StatelessWidget {
  final ContactDao contactDao;
  final TransactionWebClient webClient;

  const BytebankApp({
    Key key,
    @required this.contactDao,
    @required this.webClient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contactDao: contactDao,
      webClient: webClient,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: Dashboard(),
      ),
    );
  }
}
