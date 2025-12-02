import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:union_shop/main.dart';

void main() {
  testWidgets('onGenerateRoute handles /collections/:slug and shows title',
      (tester) async {
    await tester.pumpWidget(const UnionShopApp());

    // Obtain the NavigatorState from the widget tree and push the route
    final navigatorState = tester.state<NavigatorState>(find.byType(Navigator));
    navigatorState.pushNamed('/collections/clothing');
    await tester.pumpAndSettle();

    // The CollectionPage should show a centered title with capitalized text
    expect(find.text('Clothing'), findsOneWidget);
  });
}
