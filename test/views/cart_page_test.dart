import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/cart_page.dart';
import 'package:union_shop/view_models/cart_view_model.dart';
import 'package:union_shop/models/cart_item.dart';

void main() {
  testWidgets('CartPage shows item and subtotal', (tester) async {
    final vm = CartViewModel();
    vm.items = [
      CartItem(
        productId: 'p1',
        name: 'Test Item',
        price: 2.5,
        image: '',
        options: {},
        quantity: 2,
        id: 'i1',
      )
    ];
    appCartViewModel = vm;

    await tester.pumpWidget(const MaterialApp(home: CartPage()));
    expect(find.text('Your Cart'), findsOneWidget);
    expect(find.text('Test Item'), findsOneWidget);
    expect(find.text('£5.00'), findsOneWidget); // subtotal = 2.5 * 2
  });
}
