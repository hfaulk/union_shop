import 'package:flutter_test/flutter_test.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:union_shop/view_models/cart_view_model.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/repositories/cart_repository.dart';

void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
  });

  test('view model loads from injected repository', () async {
    final tmpDir = await Directory.systemTemp.createTemp('vm_integ_');
    final repo = CartRepository(documentsDirProvider: () async => tmpDir);
    final item = CartItem(
      productId: 'vmtest',
      name: 'VM Test',
      price: 3.0,
      image: '',
      options: {},
      quantity: 1,
      id: 'vmid1',
    );
    await repo.saveCart([item]);
    final vm = CartViewModel(repo);
    await vm.loadCart();
    expect(vm.items.length, 1);
    await tmpDir.delete(recursive: true);
  });

  test('addItem and duplicate increments quantity', () async {
    final tmpDir = await Directory.systemTemp.createTemp('vm_test_');
    final repo = CartRepository(documentsDirProvider: () async => tmpDir);
    final vm = CartViewModel(repo);
    await vm.loadCart();
    final item = CartItem(
      productId: 'p1',
      name: 'Test',
      price: 1.0,
      image: '',
      options: {'size': 'M'},
      quantity: 1,
      id: 'i1',
    );
    await vm.addItem(item);
    expect(vm.items.length, 1);
    await vm.addItem(CartItem(
      productId: 'p1',
      name: 'Test',
      price: 1.0,
      image: '',
      options: {'size': 'M'},
      quantity: 2,
      id: 'i2',
    ));
    expect(vm.items.length, 1);
    expect(vm.items.first.quantity, 3);
    await tmpDir.delete(recursive: true);
  });

  test('updateQuantity and removeItemById', () async {
    final tmpDir = await Directory.systemTemp.createTemp('vm_test_');
    final repo = CartRepository(documentsDirProvider: () async => tmpDir);
    final vm = CartViewModel(repo);
    await vm.loadCart();
    final item = CartItem(
      productId: 'p2',
      name: 'RemTest',
      price: 2.0,
      image: '',
      options: {},
      quantity: 1,
      id: 'r1',
    );
    await vm.addItem(item);
    expect(vm.items.first.quantity, 1);
    await vm.updateQuantity('r1', 4);
    expect(vm.items.first.quantity, 4);
    await vm.removeItemById('r1');
    expect(vm.items.where((e) => e.id == 'r1').isEmpty, true);
    await tmpDir.delete(recursive: true);
  });

  test('placeOrder clears cart and saves last order', () async {
    final tmpDir = await Directory.systemTemp.createTemp('vm_test_');
    final repo = CartRepository(documentsDirProvider: () async => tmpDir);
    final vm = CartViewModel(repo);
    await vm.loadCart();
    final item = CartItem(
      productId: 'p3',
      name: 'OrderTest',
      price: 5.0,
      image: '',
      options: {},
      quantity: 1,
      id: 'o1',
    );
    await vm.addItem(item);
    expect(vm.items.isNotEmpty, true);
    await vm.placeOrder();
    expect(vm.items.isEmpty, true);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('last_order_v1'), isNotNull);
    await tmpDir.delete(recursive: true);
  });
}
