import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/collection_page.dart';

void main() {
  testWidgets('CollectionPage shows title and product count (fallback)',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CollectionPage(id: 'clothing', title: 'Clothing')),
      ),
    );

    await tester.pumpAndSettle();

    // Title should be present
    expect(find.text('Clothing'), findsOneWidget);

    // Because AssetProductRepository may return empty in tests, ensure count text appears
    expect(find.textContaining('products'), findsOneWidget);

    // Filter and sort dropdowns should be present
    expect(find.text('FILTER BY'), findsOneWidget);
    expect(find.text('SORT BY'), findsOneWidget);
  });
}
