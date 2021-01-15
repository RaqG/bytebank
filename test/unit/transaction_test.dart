import 'package:bytebank/bytebank.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should return the value when create a transaction', () {
    final transaction = ModelTransaction(id: null, value: 200, contact: null);
    expect(transaction.value, 200);
  });

  test('Should display error when create transaction with value less than zero',
      () {
    expect(() => ModelTransaction(id: null, value: -1, contact: null),
        throwsAssertionError);
  });
}
