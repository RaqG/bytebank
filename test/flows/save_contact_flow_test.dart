import 'package:bytebank/bytebank.dart';
import 'package:bytebank/main.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/expect.dart';
import '../matchers/verifies.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  MockContactDao mockContactDao;
  TransactionWebClient mockWebClient;

  setUp(() async {
    mockContactDao = MockContactDao();
    mockWebClient = TransactionWebClient();
  });

  testWidgets('Should save a contact', (tester) async {
    await tester.pumpWidget(
      BytebankApp(
        contactDao: mockContactDao,
        webClient: mockWebClient,
      ),
    );
    final dashboard = find.byType(Dashboard);
    expectOneWidget(dashboard);

    await clickOnTransferFeatureItem(tester);
    await tester.pumpAndSettle();

    final contactList = find.byType(ContactsList);
    expectOneWidget(contactList);

    verifyFindAllContacts(mockContactDao, 1);

    await clickOnTheFabNew(tester);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expectOneWidget(contactForm);

    await fillTextFieldWithTextLabel(tester,
        text: 'Alan', labelText: 'Ex.: Raquel');

    await fillTextFieldWithTextLabel(tester,
        text: '56674', labelText: 'Ex.: 083274');

    await clickOnTheRaisedButtonWithText(tester, 'Create');
    await tester.pumpAndSettle();

    verifySaveContact(mockContactDao,
        ModelContact(id: 0, name: 'Alan', accountNumber: 56674));

    final responseContactList = find.byType(ContactsList);
    expectOneWidget(responseContactList);

    verifyFindAllContacts(mockContactDao, 1);
  });
}
