import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/hero_carousel.dart';

void main() {
  testWidgets('shows first slide title', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HeroCarousel(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Essential Range - Over 20% OFF!'), findsOneWidget);
  });
}
