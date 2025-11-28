import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/search_screen.dart';

void main() {
  testWidgets('SearchScreen shows header and TextField', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SearchScreen()));
    expect(find.text('SEARCH OUR SITE'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}
