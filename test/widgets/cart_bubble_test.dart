import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/shared_layout.dart';
import 'package:union_shop/view_models/cart_view_model.dart';

void main() {
  testWidgets('Cart bubble hidden when cart is empty', (tester) async {
    final vm = CartViewModel();
    vm.items = [];
    appCartViewModel = vm;

    await tester.pumpWidget(
      const MaterialApp(home: SharedLayout(body: SizedBox.shrink())),
    );
    await tester.pumpAndSettle();

    // No visible badge text for empty cart
    expect(find.bySemanticsLabel('Cart — 0 items'), findsNothing);
    expect(find.textContaining('0'), findsNothing);
  });
}
