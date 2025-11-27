import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../repositories/cart_repository.dart';

class CartViewModel extends ChangeNotifier {
  final CartRepository _repo;
  List<CartItem> items = [];
  CartViewModel([CartRepository? repo]) : _repo = repo ?? CartRepository();
  Future<void> loadCart() async {
    items = await _repo.loadCart();
    notifyListeners();
  }

  Future<void> addItem(CartItem item) async {
    final idx = items.indexWhere((e) =>
        e.productId == item.productId && mapEquals(e.options, item.options));
    if (idx != -1)
      items[idx].quantity += item.quantity;
    else
      items.add(item);
    await _repo.saveCart(items);
    notifyListeners();
  }

  Future<void> removeItemById(String id) async {
    items.removeWhere((e) => e.id == id);
    await _repo.saveCart(items);
    notifyListeners();
  }

  Future<void> updateQuantity(String id, int qty) async {
    final i = items.indexWhere((e) => e.id == id);
    if (i != -1) {
      items[i].quantity = qty < 1 ? 1 : qty;
      await _repo.saveCart(items);
      notifyListeners();
    }
  }

  Future<void> placeOrder() async {
    items = [];
    await _repo.clearCart();
    notifyListeners();
  }
}
