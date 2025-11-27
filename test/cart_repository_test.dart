import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:union_shop/repositories/cart_repository.dart';
import 'package:union_shop/models/cart_item.dart';

void main() {
  test('CartRepository save/load roundtrip', () async {
    SharedPreferences.setMockInitialValues({});
    final repo = CartRepository();
    final item = CartItem(
      productId: 'p1',
      name: 'Repo Product',
      price: 3.5,
      image: 'i.png',
      options: {'size': 'L'},
      quantity: 1,
      id: 'id1',
    );

    await repo.saveCart([item]);
    final loaded = await repo.loadCart();
    expect(loaded.length, 1);
    final l = loaded.first;
    expect(l.productId, item.productId);
    expect(l.name, item.name);
    expect(l.price, item.price);
    expect(l.quantity, item.quantity);
  });
}
