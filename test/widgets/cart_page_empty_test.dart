import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:union_shop/views/cart_page.dart';
import 'package:union_shop/view_models/cart_view_model.dart';
import 'package:union_shop/repositories/cart_repository.dart';

void main() {
  testWidgets('CartPage shows empty totals and disabled checkout',
      (tester) async {
    // Ensure SharedPreferences uses an in-memory mock
    SharedPreferences.setMockInitialValues({});

    final vm = CartViewModel(CartRepository());
    await vm.loadCart();
    appCartViewModel = vm;

    await tester.pumpWidget(const MaterialApp(home: CartPage()));
    await tester.pumpAndSettle();

    // AppBar title
    expect(find.text('Your Cart'), findsOneWidget);

    // Subtotal should show £0.00 for empty cart
    expect(find.text('£0.00'), findsOneWidget);

    // Checkout button should be disabled (onPressed == null)
    final finder = find.byType(ElevatedButton);
    expect(finder, findsOneWidget);
    final button = tester.widget<ElevatedButton>(finder);
    expect(button.onPressed, isNull);
  });
}
