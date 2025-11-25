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

    // Tap the right arrow button (target the shared overlay arrow by key)
    await tester.tap(find.byKey(const ValueKey('hero_arrow_right')));
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

    // Tap the second indicator (index 1) — ensure visible then tap center
    final indicator = find.byType(GestureDetector).at(1);
    await tester.ensureVisible(indicator);
    await tester.tapAt(tester.getCenter(indicator));
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

    // Tap the left arrow button (should wrap to last slide); target shared arrow
    await tester.tap(find.byKey(const ValueKey('hero_arrow_left')));
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

    // Advance twice: first -> second, then wrap to first (target IconButton)
    await tester.tap(find.byKey(const ValueKey('hero_arrow_right')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('hero_arrow_right')));
    await tester.pumpAndSettle();

    expect(find.text('Essential Range - Over 20% OFF!'), findsOneWidget);
  });
}
