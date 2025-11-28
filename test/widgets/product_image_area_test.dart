import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/product_image_area.dart';

void main() {
  testWidgets('ProductImageArea shows fallback for missing/remote images',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: ProductImageArea(imageUrl: '')),
    ));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
  });
}
