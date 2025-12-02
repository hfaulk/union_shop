import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:union_shop/views/cart_page.dart';
import 'package:union_shop/view_models/cart_view_model.dart';

void main() {
  testWidgets('CartPage non-empty flow: increment and checkout',
      (tester) async {
    // Seed SharedPreferences with a single cart item
    final item = {
      'productId': 'p1',
      'name': 'Test Product',
      'price': 10.0,
      'image': '',
      'options': {},
      'quantity': 1,
      'id': 'item1'
    };
    SharedPreferences.setMockInitialValues({
      'cart_items_v1': jsonEncode([item])
    });

    final vm = CartViewModel();
    await vm.loadCart();
    appCartViewModel = vm;

    await tester.pumpWidget(const MaterialApp(home: CartPage()));
    await tester.pumpAndSettle();

    // Item should be visible
    expect(find.text('Test Product'), findsOneWidget);

    // Checkout button should be enabled
    final checkoutFinder = find.byType(ElevatedButton);
    expect(checkoutFinder, findsOneWidget);
    var checkoutButton = tester.widget<ElevatedButton>(checkoutFinder);
    expect(checkoutButton.onPressed, isNotNull);

    // Tap the add button to increment quantity
    await tester.tap(find.byIcon(Icons.add_circle_outline).first);
    await tester.pumpAndSettle();

    // Expect SnackBar for quantity updated
    expect(find.text('Quantity updated'), findsOneWidget);

    // Now start checkout flow
    await tester.tap(checkoutFinder);
    await tester.pumpAndSettle();

    // Dialog should appear; confirm
    expect(find.text('Confirm order'), findsOneWidget);
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    // After placing order, the view model items should be cleared
    expect(vm.items, isEmpty);

    // Subtotal should be £0.00 and checkout disabled
    expect(find.text('£0.00'), findsOneWidget);
    checkoutButton = tester.widget<ElevatedButton>(checkoutFinder);
    expect(checkoutButton.onPressed, isNull);
  });
}
