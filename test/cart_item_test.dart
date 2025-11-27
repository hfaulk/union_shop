import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart_item.dart';

void main() {
  test('CartItem JSON roundtrip', () {
    final item = CartItem(
      productId: '1',
      name: 'Test Product',
      price: 9.99,
      image: 'img.png',
      options: {'size': 'M', 'color': 'Red'},
      quantity: 2,
      id: 'abc123',
    );

    final json = item.toJson();
    final parsed = CartItem.fromJson(json);

    expect(parsed.productId, item.productId);
    expect(parsed.name, item.name);
    expect(parsed.price, item.price);
    expect(parsed.quantity, item.quantity);
    expect(parsed.options, item.options);
    expect(parsed.id, item.id);
  });
}
