import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/about.dart';

void main() {
  testWidgets('AboutPage shows heading and contact email',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AboutPage()));
    await tester.pumpAndSettle();

    expect(find.text('About us'), findsOneWidget);
    expect(find.textContaining('Welcome to the Union Shop!'), findsOneWidget);
    expect(find.textContaining('hello@upsu.net'), findsOneWidget);
  });
}
