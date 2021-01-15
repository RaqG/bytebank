import 'package:bytebank/bytebank.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/screens/contacts/contacts_list.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/expect.dart';
import '../matchers/matchers.dart';
import '../matchers/verifies.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  MockContactDao mockContactDao;
  MockTransactionWebClient mockWebClient;

  setUp(() async {
    mockContactDao = MockContactDao();
    mockWebClient = MockTransactionWebClient();
  });

  testWidgets('Transfer to a contact', (tester) async {
    await tester.pumpWidget(
      BytebankApp(
        contactDao: mockContactDao,
        webClient: mockWebClient,
      ),
    );

    final dashboard = find.byType(Dashboard);
    expectOneWidget(dashboard);

    final raquel = ModelContact(id: 0, name: 'Raquel', accountNumber: 123456);

    when(mockContactDao.findAll()).thenAnswer((_) async => [raquel]);

    await clickOnTransferFeatureItem(tester);
    await tester.pumpAndSettle();

    final contactsList = find.byType(ContactsList);
    expectOneWidget(contactsList);

    verifyFindAllContacts(mockContactDao, 1);

    await clickOnContactItemWithText(tester, 'Raquel', 123456);
    await tester.pumpAndSettle();

    await clickOnTheCreateTransactionOption(tester);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expectOneWidget(transactionForm);

    final contactName = find.text('Raquel - 123456');
    expectOneWidget(contactName);

    final textFieldValue = find.byWidgetPredicate(
        (widget) => textFieldMatcher(widget, valueLabelText, valueHintText));
    expectOneWidget(textFieldValue);
    await tester.enterText(textFieldValue, '508.5');

    final transferButton =
        find.widgetWithText(RaisedButton, buttonTransferText);
    expectOneWidget(transferButton);
    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    final transferAuthDialog = find.byType(AuthDialog);
    expectOneWidget(transferAuthDialog);

    final textFieldAuth = find.byKey(authTextFieldKey);
    expectOneWidget(textFieldAuth);
    await tester.enterText(textFieldValue, '1000');

    final cancelButton = find.widgetWithText(DialogButton, alertCancel);
    expectOneWidget(cancelButton);

    final confirmButton = find.widgetWithText(DialogButton, alertConfirm);
    expectOneWidget(confirmButton);

    final transaction =
        ModelTransaction(contact: raquel, value: 508.5, id: null);
    when(mockWebClient.save(
            ModelTransaction(id: null, value: 200, contact: raquel), '1000'))
        .thenAnswer((_) async =>
            ModelTransaction(id: null, value: 200, contact: raquel));

    await tester.tap(confirmButton);
    // await tester.pumpAndSettle();
    //
    // final successDialog = find.byType(SuccessDialog);
    // expect(successDialog, findsOneWidget);
  });
}
