import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/product_card_impl.dart';

void main() {
  testWidgets('ProductCardImpl shows title and price', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: ProductCardImpl(
          title: 'Test Item',
          price: '£1.00',
          imageUrl: 'assets/img.png',
        ),
      ),
    ));

    expect(find.text('Test Item'), findsOneWidget);
    expect(find.text('£1.00'), findsOneWidget);
  });
}
