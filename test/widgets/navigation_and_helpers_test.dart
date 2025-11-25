import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/views/collection_page.dart';

void main() {
  test('penceToPounds helper formats properly', () {
    expect(penceToPounds(1499), equals('£14.99'));
    expect(penceToPounds(0), equals('£0.00'));
  });

  testWidgets(
      'onGenerateRoute handles /collections/:slug and shows CollectionPage title',
      (WidgetTester tester) async {
    // Build a small app with the same onGenerateRoute logic
    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (context) {
        return ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/collections/autumn-favourites');
          },
          child: const Text('nav'),
        );
      }),
      onGenerateRoute: (settings) {
        final name = settings.name ?? '';
        final uri = Uri.parse(name);
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments[0] == 'collections') {
          final slug = uri.pathSegments[1];
          final title = Uri.decodeComponent(slug.replaceAll('-', ' '));
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => CollectionPage(id: slug, title: title),
          );
        }
        return null;
      },
    ));

    await tester.pumpAndSettle();
    // Tap the button to navigate
    await tester.tap(find.text('nav'));
    await tester.pumpAndSettle();

    // The CollectionPage shows the title we passed (slug replaced hyphens with spaces)
    expect(find.text('autumn favourites'), findsOneWidget);
  });
}
