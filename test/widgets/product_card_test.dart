import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  testWidgets('ProductCard shows title, prices and navigates on tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      routes: {
        '/product/test-product': (context) =>
            const Scaffold(body: Center(child: Text('PRODUCT PAGE'))),
      },
      home: Scaffold(
        body: Card(
          child: ProductCard(
            title: 'Test Product',
            price: '£12.34',
            originalPrice: '£15.00',
            imageUrl: '',
            id: 'test-product',
          ),
        ),
      ),
    ));

    await tester.pumpAndSettle();

    // Check title and prices
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('£12.34'), findsOneWidget);
    expect(find.text('£15.00'), findsOneWidget);

    // Tap the title text (inside the card) to trigger the GestureDetector
    await tester.tap(find.text('Test Product'));
    await tester.pumpAndSettle();

    expect(find.text('PRODUCT PAGE'), findsOneWidget);
  });
}
