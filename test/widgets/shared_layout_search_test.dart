import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/shared_layout.dart';

void main() {
  testWidgets('SharedLayout banner and search dialog open', (tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: SharedLayout(body: Text('X'))));
    expect(find.textContaining('BIG SALE!'), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
    expect(find.text('Search'), findsWidgets);
  });
}
