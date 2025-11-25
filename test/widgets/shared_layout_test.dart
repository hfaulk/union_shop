import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/shared_layout.dart';

void main() {
  testWidgets('SharedLayout shows banner and header icons', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SharedLayout(body: const SizedBox.shrink()),
      ),
    );

    await tester.pumpAndSettle();

    // Banner text
    expect(find.textContaining('BIG SALE'), findsOneWidget);

    // Header icons
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);
  });
}
