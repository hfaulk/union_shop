import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';

void main() {
  test('Product fromJson -> toJson roundtrip with discount', () {
    final json = {
      'id': 'p1',
      'title': 'Widget',
      'price': 2500,
      'imageUrl': 'img.png',
      'collections': ['autumn'],
      'discount': true,
      'discountedPrice': 899,
    };

    final p = Product.fromJson(json);
    expect(p.id, 'p1');
    expect(p.title, 'Widget');
    expect(p.price, 2500);
    expect(p.imageUrl, 'img.png');
    expect(p.collections, contains('autumn'));
    expect(p.discount, isTrue);
    expect(p.discountedPrice, 899);

    final out = p.toJson();
    expect(out['id'], 'p1');
    expect(out['discount'], true);
    expect(out['discountedPrice'], 899);
  });

  test('Product fromJson without discount', () {
    final json = {
      'id': 'p2',
      'title': 'NoDisc',
      'price': 1200,
      'imageUrl': 'i2.png',
    };

    final p = Product.fromJson(json);
    expect(p.discount, isFalse);
    expect(p.discountedPrice, isNull);

    final out = p.toJson();
    expect(out.containsKey('discount'), isFalse);
    expect(out.containsKey('discountedPrice'), isFalse);
  });
}
