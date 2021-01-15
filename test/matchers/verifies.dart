import 'package:bytebank/bytebank.dart';
import 'package:mockito/mockito.dart';

verifyFindAllContacts(mock, int timesCalled) {
  verify(mock.findAll()).called(timesCalled);
}

verifySaveContact(mock, ModelContact contact) {
  verify(mock.save(contact));
}
