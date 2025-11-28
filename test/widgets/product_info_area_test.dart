import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/product_info_area.dart';

void main() {
  testWidgets('shows original and discounted price when originalPrice set',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: ProductInfoArea(
          title: 'Item',
          price: '£5.00',
          originalPrice: '£10.00',
        ),
      ),
    ));

    expect(find.text('£10.00'), findsOneWidget);
    expect(find.text('£5.00'), findsOneWidget);
  });
}
