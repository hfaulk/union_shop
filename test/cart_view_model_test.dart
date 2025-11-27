import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:union_shop/view_models/cart_view_model.dart';
import 'package:union_shop/models/cart_item.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  test('addItem and duplicate increments quantity', () async {
    final vm = CartViewModel();
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
  });

  test('updateQuantity and removeItemById', () async {
    final vm = CartViewModel();
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
  });

  test('placeOrder clears cart and saves last order', () async {
    final vm = CartViewModel();
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
  });
}
