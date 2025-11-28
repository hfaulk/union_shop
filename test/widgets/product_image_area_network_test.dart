import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/product_image_area.dart';

void main() {
  testWidgets('ProductImageArea shows fallback icon for network images',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: ProductImageArea(imageUrl: 'https://nope')),
    ));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
  });
}
