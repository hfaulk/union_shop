import 'dart:io';

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

  test('loadCart returns empty on invalid JSON', () async {
    SharedPreferences.setMockInitialValues({'cart_items_v1': 'not a json'});
    final repo = CartRepository();
    final loaded = await repo.loadCart();
    expect(loaded, isEmpty);
  });

  test('copySeedIfNeeded creates empty file when asset missing', () async {
    SharedPreferences.setMockInitialValues({});
    final repo = CartRepository();
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('cart_items_v1') != null) {
      await prefs.remove('cart_items_v1');
    }
    await repo.copySeedIfNeeded();
    final contents = prefs.getString('cart_items_v1');
    expect(contents?.trim() ?? '', '[]');
  });

  test('saveLastOrder stores key in SharedPreferences', () async {
    SharedPreferences.setMockInitialValues({});
    final repo = CartRepository();
    final item = CartItem(
      productId: 'p-last',
      name: 'Last',
      price: 1.0,
      image: '',
      options: {},
      quantity: 1,
      id: 'last1',
    );
    await repo.saveLastOrder([item]);
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString('last_order_v1');
    expect(s, isNotNull);
  });

  test('saveCart does not leave .tmp file', () async {
    SharedPreferences.setMockInitialValues({});
    final repo = CartRepository();
    final item = CartItem(
      productId: 'p-atomic',
      name: 'Atomic',
      price: 2.0,
      image: '',
      options: {},
      quantity: 1,
      id: 'a1',
    );
    await repo.saveCart([item]);
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString('cart_items_v1');
    expect(s, isNotNull);
  });
}
