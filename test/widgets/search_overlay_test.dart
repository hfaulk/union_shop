import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/search_overlay.dart';

void main() {
  testWidgets('SearchOverlay shows TextField and close button calls onClose',
      (tester) async {
    var closed = false;
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: SearchOverlay(onClose: () => closed = true))));
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    expect(closed, isTrue);
  });
}
