import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';

void main() {
  test('Product JSON parsing and toJson for discounted product', () {
    final jsonStr = File('assets/data/products.json').readAsStringSync();
    final list = json.decode(jsonStr) as List<dynamic>;
    final map = list[1] as Map<String, dynamic>; // second product has discount

    final product = Product.fromJson(map);

    expect(product, isA<Product>());
    expect(product.id, equals(map['id']));
    expect(product.title, equals(map['title']));
    expect(product.price, equals(map['price']));
    expect(product.discount, equals(true));
    expect(product.discountedPrice, equals(map['discountedPrice']));

    // toJson should include discount fields when present
    final jsonOut = product.toJson();
    expect(jsonOut['id'], equals(map['id']));
    expect(jsonOut['discount'], equals(true));
    expect(jsonOut['discountedPrice'], equals(map['discountedPrice']));
  });
}
