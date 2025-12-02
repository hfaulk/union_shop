import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/search_overlay.dart';

void main() {
  testWidgets('SearchOverlay close button calls onClose', (tester) async {
    var closed = false;
    await tester.pumpWidget(
        MaterialApp(home: SearchOverlay(onClose: () => closed = true)));

    expect(find.byIcon(Icons.close), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();

    expect(closed, isTrue);
  });

  testWidgets('SearchOverlay shows results when typing query', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SearchOverlay()));

    // Type a query expected to match bundled products (e.g. 'classic')
    await tester.enterText(find.byType(TextField), 'classic');
    await tester.pumpAndSettle();

    // Expect known product titles from assets to appear
    expect(find.text('Classic Sweatshirts'), findsOneWidget);
    expect(find.text('Classic Hoodies'), findsOneWidget);
  });
}
