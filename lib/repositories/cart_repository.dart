import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_item.dart';

class CartRepository {
  static const _key = 'cart_items_v1';

  Future<List<CartItem>> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_key);
    if (s == null) return [];
    final data = jsonDecode(s) as List;
    return data
        .map((e) => CartItem.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> saveCart(List<CartItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final s = jsonEncode(items.map((e) => e.toJson()).toList());
    await prefs.setString(_key, s);
  }

  // Convenience helpers - simple wrappers that load, modify, and save.
  Future<void> clearCart() async => saveCart([]);

  Future<void> saveLastOrder(List<CartItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final s = jsonEncode(items.map((e) => e.toJson()).toList());
    await prefs.setString('last_order_v1', s);
  }
}
