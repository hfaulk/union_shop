import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/product_page.dart';

void main() {
  testWidgets('Deep link /product/:id displays product title',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      initialRoute: '/product/classic-hoodies',
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name ?? '');
        if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'product') {
          final id = uri.pathSegments[1];
          // Simulate route providing product fields for test
          return MaterialPageRoute(
              settings: RouteSettings(arguments: {
                'id': id,
                'title': 'Classic Hoodies',
                'price': 2500,
                'imageUrl': ''
              }),
              builder: (_) => const ProductPage());
        }
        return null;
      },
    ));

    await tester.pumpAndSettle();
    expect(find.text('Classic Hoodies'), findsOneWidget);
  });
}
