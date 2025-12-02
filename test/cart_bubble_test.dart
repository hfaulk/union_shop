import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/cart_bubble.dart';

void main() {
  testWidgets('shows bubble for count 1 with correct semantics and text',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CartBubble(count: 1)));

    // AnimatedSwitcher should be present when count > 0
    expect(find.byType(AnimatedSwitcher), findsOneWidget);

    // Text shows '1'
    expect(find.text('1'), findsOneWidget);

    // Container is keyed with the textual value, ensure the keyed widget exists
    expect(find.byKey(const ValueKey('1')), findsOneWidget);
  });

  testWidgets('clamps display to maxDisplay and shows plus sign',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CartBubble(count: 150, maxDisplay: 99),
    ));

    // Should show '99+' text
    expect(find.text('99+'), findsOneWidget);

    // Container is keyed with the textual value, ensure the keyed widget exists
    expect(find.byKey(const ValueKey('99+')), findsOneWidget);
  });

  testWidgets('hides bubble when count is zero', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CartBubble(count: 0)));

    // No AnimatedSwitcher means the widget returned SizedBox.shrink()
    expect(find.byType(AnimatedSwitcher), findsNothing);

    // Should not display numeric text
    expect(find.byType(Text), findsNothing);
  });
}
