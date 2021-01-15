import 'package:bytebank/components/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

Future clickOnTransferFeatureItem(WidgetTester tester) async {
  final transferFeatureItem = find.byWidgetPredicate((widget) =>
      featureItemMatcher(widget, 'Transfer', Icons.monetization_on_outlined));
  expect(transferFeatureItem, findsOneWidget);
  await tester.tap(transferFeatureItem);
}

Future clickOnTheFabNew(WidgetTester tester) async {
  final fabAdd = find.widgetWithIcon(FloatingActionButton, Icons.add);
  expect(fabAdd, findsOneWidget);
  await tester.tap(fabAdd);
}

Future clickOnTheRaisedButtonWithText(WidgetTester tester, String text) async {
  final createButton = find.widgetWithText(RaisedButton, text);
  expect(createButton, findsOneWidget);
  await tester.tap(createButton);
}

Future clickOnContactItemWithText(
    WidgetTester tester, String name, int accountNumber) async {
  final contactItem = find.byWidgetPredicate(
      (widget) => contactItemMatcher(widget, name, accountNumber));
  expect(contactItem, findsOneWidget);
  await tester.tap(contactItem);
}

Future clickOnTheCreateTransactionOption(WidgetTester tester) async {
  final transactionOption = find.byWidgetPredicate((widget) =>
      simpleDialogItemMatcher(
          widget, Icons.monetization_on_outlined, createTransaction));
  expect(transactionOption, findsOneWidget);
  await tester.tap(transactionOption);
}

Future fillTextFieldWithTextLabel(WidgetTester tester,
    {String text, String labelText}) async {
  final nameTextField = find.byWidgetPredicate(
      (widget) => textFieldByLabelMatcher(widget, labelText));
  expect(nameTextField, findsOneWidget);
  await tester.enterText(nameTextField, text);
}
