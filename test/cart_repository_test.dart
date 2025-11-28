import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:union_shop/repositories/cart_repository.dart';
import 'package:union_shop/models/cart_item.dart';

void main() {
  test('CartRepository save/load roundtrip', () async {
    SharedPreferences.setMockInitialValues({});
    final tmpDir = await Directory.systemTemp.createTemp('cart_repo_test_');
    final repo = CartRepository(documentsDirProvider: () async => tmpDir);
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
    await tmpDir.delete(recursive: true);
  });

  test('loadCart returns empty on invalid JSON', () async {
    SharedPreferences.setMockInitialValues({});
    final tmpDir = await Directory.systemTemp.createTemp('cart_repo_test_');
    final file = File('${tmpDir.path}/cart.json');
    await file.writeAsString('not a json');
    final repo = CartRepository(documentsDirProvider: () async => tmpDir);
    final loaded = await repo.loadCart();
    expect(loaded, isEmpty);
    await tmpDir.delete(recursive: true);
  });

  test('copySeedIfNeeded creates empty file when asset missing', () async {
    SharedPreferences.setMockInitialValues({});
    final tmpDir = await Directory.systemTemp.createTemp('cart_repo_test_');
    final repo = CartRepository(documentsDirProvider: () async => tmpDir);
    final file = File('${tmpDir.path}/cart.json');
    if (await file.exists()) await file.delete();
    await repo.copySeedIfNeeded();
    final contents = await file.readAsString();
    expect(contents.trim(), '[]');
    await tmpDir.delete(recursive: true);
  });
}
