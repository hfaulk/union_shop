import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/search_screen.dart';

void main() {
  testWidgets('SearchScreen shows header and TextField', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SearchScreen()));

    expect(find.text('SEARCH OUR SITE'), findsOneWidget);
    final searchField = find.byWidgetPredicate((w) =>
        w is TextField &&
        w.decoration != null &&
        w.decoration!.hintText == 'Search');
    expect(searchField, findsOneWidget);
  });

  testWidgets('SearchScreen shows results when typing', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SearchScreen()));

    final searchField = find.byWidgetPredicate((w) =>
        w is TextField &&
        w.decoration != null &&
        w.decoration!.hintText == 'Search');
    await tester.enterText(searchField, 'classic');
    await tester.pumpAndSettle();

    expect(find.text('Classic Sweatshirts'), findsOneWidget);
    expect(find.text('Classic Hoodies'), findsOneWidget);
  });
}
