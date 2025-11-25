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

  testWidgets('navigates to next slide when right arrow tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HeroCarousel(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Tap the right arrow button
    await tester.tap(find.byIcon(Icons.chevron_right));
    await tester.pumpAndSettle();

    expect(find.text('New Arrivals'), findsOneWidget);
  });

  testWidgets('navigates when indicator dot tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HeroCarousel(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Tap the second indicator (index 1)
    await tester.tap(find.byType(GestureDetector).at(1));
    await tester.pumpAndSettle();

    expect(find.text('New Arrivals'), findsOneWidget);
  });

  testWidgets('navigates to previous slide when left arrow tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HeroCarousel(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Tap the left arrow button (should wrap to last slide)
    await tester.tap(find.byIcon(Icons.chevron_left));
    await tester.pumpAndSettle();

    expect(find.text('New Arrivals'), findsOneWidget);
  });

  testWidgets('navigates to named route when CTA tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/collections': (context) => const Scaffold(
                body: Center(child: Text('COLLECTIONS PAGE')),
              ),
        },
        home: Scaffold(
          body: HeroCarousel(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Tap the CTA button on first slide
    await tester.tap(find.text('BROWSE COLLECTION'));
    await tester.pumpAndSettle();

    expect(find.text('COLLECTIONS PAGE'), findsOneWidget);
  });

  testWidgets('wraps from last to first when advancing past last slide',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HeroCarousel(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Advance twice: first -> second, then wrap to first
    await tester.tap(find.byIcon(Icons.chevron_right));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.chevron_right));
    await tester.pumpAndSettle();

    expect(find.text('Essential Range - Over 20% OFF!'), findsOneWidget);
  });
}
