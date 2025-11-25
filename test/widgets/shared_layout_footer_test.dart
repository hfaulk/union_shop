import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/shared_layout.dart';

void main() {
  testWidgets('SharedLayout footer shows Opening Hours and subscribe button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SharedLayout(body: const SizedBox.shrink()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Opening Hours'), findsOneWidget);
    expect(find.text('SUBSCRIBE'), findsOneWidget);
  });
}
