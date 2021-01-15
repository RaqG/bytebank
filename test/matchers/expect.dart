import 'package:flutter_test/flutter_test.dart';

expectOneWidget(Finder expectation) {
  expect(expectation, findsOneWidget);
}

expectNothing(Finder expectation) {
  expect(expectation, findsNothing);
}

expectWidgets(Finder expectation) {
  expect(expectation, findsWidgets);
}

expectMoreThanOneWidgets(Finder expectation, int length) {
  expect(expectation, findsNWidgets(length));
}
