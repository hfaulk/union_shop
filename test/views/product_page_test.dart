import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/product_page.dart';

void main() {
  testWidgets('ProductPage shows passed title/price and shows cart-not-ready',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (context) {
        return ElevatedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    settings: RouteSettings(
                        arguments: {'title': 'TProd', 'price': '£9.99'}),
                    builder: (_) => const ProductPage())),
            child: const Text('go'));
      }),
    ));

    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
    expect(find.text('TProd'), findsOneWidget);
    expect(find.text('£9.99'), findsOneWidget);

    await tester.ensureVisible(find.text('ADD TO CART'));
    await tester.tap(find.text('ADD TO CART'));
    await tester.pumpAndSettle();
    expect(find.text('Cart not ready'), findsOneWidget);
  });
}
