import 'package:bytebank/bytebank.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

void main() {
  group('When Dashboard is opened', () {
    testWidgets('Should display banner', (WidgetTester tester) async {
      await getDashboard(tester);
      final bannerImage = find.byType(Image);
      expect(bannerImage, findsOneWidget);
    });

    testWidgets('Should display the transfer feature', (tester) async {
      await getDashboard(tester);
      final transferFeatureItem = find.byWidgetPredicate((widget) {
        return featureItemMatcher(
            widget, 'Transfer', Icons.monetization_on_outlined);
      });
      expect(transferFeatureItem, findsOneWidget);
    });

    /// OU (pode testar dessa maneira)
    // testWidgets('Should display the transfer feature',
    //         (tester) async {
    //       await getDashboard(tester);
    //       final transferIcon =
    //       find.widgetWithIcon(FeatureItem, Icons.monetization_on_outlined);
    //       expect(transferIcon, findsOneWidget);
    //       final transferText = find.widgetWithText(FeatureItem, 'Transfer');
    //       expect(transferText, findsOneWidget);
    //     });

    testWidgets('Should display the transaction feed feature', (tester) async {
      await getDashboard(tester);
      final transferFeatureItem = find.byWidgetPredicate((widget) {
        return featureItemMatcher(
            widget, 'Transaction Feed', Icons.description);
      });
      expect(transferFeatureItem, findsOneWidget);
    });

    /// OU (pode testar dessa maneira)
    // testWidgets(
    //     'Should display the transaction feed feature',
    //         (tester) async {
    //       await getDashboard(tester);
    //       final transactionFeedIcon =
    //       find.widgetWithIcon(FeatureItem, Icons.description);
    //       expect(transactionFeedIcon, findsOneWidget);
    //       final transactionFeedText =
    //       find.widgetWithText(FeatureItem, 'Transaction Feed');
    //       expect(transactionFeedText, findsOneWidget);
    //     });
  });
}

getDashboard(WidgetTester tester) async {
  return await tester.pumpWidget(
    MaterialApp(
      home: Dashboard(),
    ),
  );
}
