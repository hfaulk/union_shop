import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:union_shop/view_models/cart_view_model.dart';
import 'package:union_shop/repositories/cart_repository.dart';
import 'package:union_shop/models/cart_item.dart';

void main() {
  test('updateQuantity enforces minimum of 1', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    final tmp = await Directory.systemTemp.createTemp('vm_min_');
    final repo = CartRepository(documentsDirProvider: () async => tmp);
    final vm = CartViewModel(repo);
    await vm.loadCart();
    final item = CartItem(
      productId: 'p-min',
      name: 'Min',
      price: 1.0,
      image: '',
      options: {},
      quantity: 2,
      id: 'min1',
    );
    await vm.addItem(item);
    await vm.updateQuantity('min1', 0);
    expect(vm.items.first.quantity, 1);
    await tmp.delete(recursive: true);
  });
}
