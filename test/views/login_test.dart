import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/login.dart';

void main() {
  testWidgets('Continue button enables when valid email entered',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    final continueFinder = find.widgetWithText(ElevatedButton, 'Continue');
    expect(continueFinder, findsOneWidget);
    var btn = tester.widget<ElevatedButton>(continueFinder);
    expect(btn.onPressed, isNull);

    await tester.enterText(find.byType(TextField), 'user@example.com');
    await tester.pumpAndSettle();

    btn = tester.widget<ElevatedButton>(continueFinder);
    expect(btn.onPressed, isNotNull);
  });
}
