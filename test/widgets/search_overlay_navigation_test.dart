import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/search_overlay.dart';

void main() {
  testWidgets('SearchOverlay result tap navigates to product page',
      (tester) async {
    // App that shows the overlay via showDialog and reports pushed route name
    await tester.pumpWidget(MaterialApp(
      onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (_) => Scaffold(body: Text(settings.name ?? ''))),
      home: Builder(builder: (context) {
        return Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => showDialog(
                  context: context, builder: (_) => const SearchOverlay()),
              child: const Text('open'),
            ),
          ),
        );
      }),
    ));

    // Open the overlay
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    // Enter search query
    final searchField = find.byWidgetPredicate((w) =>
        w is TextField &&
        w.decoration != null &&
        w.decoration!.hintText == 'Search');
    expect(searchField, findsOneWidget);
    await tester.enterText(searchField, 'classic');
    await tester.pumpAndSettle();

    // Tap a result item
    expect(find.text('Classic Sweatshirts'), findsOneWidget);
    await tester.tap(find.text('Classic Sweatshirts'));
    await tester.pumpAndSettle();

    // After tapping, the app should navigate to the product route name
    expect(find.text('/product/classic-sweatshirts'), findsOneWidget);
  });
}
