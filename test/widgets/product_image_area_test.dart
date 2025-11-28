import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/product_image_area.dart';

void main() {
  testWidgets('ProductImageArea uses AssetImage for asset paths',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: ProductImageArea(imageUrl: 'assets/img.png')),
    ));
    final img = tester.widget<Image>(find.byType(Image));
    expect(img.image.runtimeType.toString().toLowerCase(), contains('asset'));
  });
}
