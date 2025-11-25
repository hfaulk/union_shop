import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/product_page.dart';

void main() {
  testWidgets(
      'ProductPage shows discounted and original prices when discount present',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      routes: {
        '/product': (context) => const ProductPage(),
      },
      home: Builder(builder: (context) {
        return ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/product', arguments: {
              'title': 'Sale Item',
              'price': 2500,
              'discount': true,
              'discountedPrice': 899,
              'imageUrl': ''
            });
          },
          child: const Text('go'),
        );
      }),
    ));

    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();

    // Original price (line-through) and discounted price should both appear
    expect(find.text('£25.00'), findsOneWidget);
    expect(find.text('£8.99'), findsOneWidget);

    // Title passed through
    expect(find.text('Sale Item'), findsOneWidget);
  });
}
