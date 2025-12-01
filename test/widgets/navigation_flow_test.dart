import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:union_shop/main.dart';

void main() {
  testWidgets(
      'Home → Collections → CollectionPage → ProductPage navigation flow',
      (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    // Home always shows a product card area (placeholder or loaded)
    expect(find.byType(ProductCard), findsWidgets);

    // Use a descendant context (Scaffold) to navigate by name
    final appContext = tester.element(find.byType(Scaffold));

    // Push Collections
    Navigator.pushNamed(appContext, '/collections');
    await tester.pumpAndSettle();

    expect(find.text('Collections'), findsWidgets);

    // Push a specific collection using onGenerateRoute pattern
    Navigator.pushNamed(appContext, '/collections/autumn');
    await tester.pumpAndSettle();

    // The CollectionPage shows a human-friendly title for the collection
    expect(find.text('Autumn'), findsOneWidget);

    // Push Product page with explicit arguments via deep-link path
    Navigator.pushNamed(appContext, '/product/integration-test', arguments: {
      'title': 'Integration Test Product',
      'price': 1599,
    });
    await tester.pumpAndSettle();

    expect(find.text('Integration Test Product'), findsOneWidget);
    expect(find.text('£15.99'), findsOneWidget);
  });
}
