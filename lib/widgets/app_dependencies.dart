import 'package:bytebank/bytebank.dart';
import 'package:flutter/material.dart';

class AppDependencies extends InheritedWidget {
  final ContactDao contactDao;
  final TransactionWebClient webClient;

  const AppDependencies({
    Key key,
    @required this.contactDao,
    @required this.webClient,
    @required Widget child,
  }) : super(key: key, child: child);

  static AppDependencies of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDependencies>();

  @override
  bool updateShouldNotify(covariant AppDependencies oldWidget) =>
      contactDao != oldWidget.contactDao || webClient != oldWidget.webClient;
}
