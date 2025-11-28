import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/cart_item.dart';

class CartRepository {
  static const _key = 'cart_items_v1';
  // Optional provider for tests to inject a documents directory.
  final Future<Directory> Function()? documentsDirProvider;

  CartRepository({this.documentsDirProvider});

  Future<List<CartItem>> loadCart() async {
    // Use SharedPreferences as the single source of truth for persistence.
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_key);
    if (s == null || s.isEmpty) {
      debugPrint(
          'CartRepository: no saved cart found in SharedPreferences (fallback)');
      return [];
    }
    debugPrint('CartRepository: found saved cart in prefs (${s.length} bytes)');
    try {
      final data = jsonDecode(s) as List;
      final items = data
          .map((e) => CartItem.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      debugPrint('CartRepository: parsed ${items.length} items from prefs');
      return items;
    } catch (e) {
      debugPrint(
          'CartRepository: failed to parse saved cart from prefs: ${e.toString()}');
      return [];
    }
  }

  Future<void> saveCart(List<CartItem> items) async {
    final s = jsonEncode(items.map((e) => e.toJson()).toList());
    // Persist to SharedPreferences only (simpler and avoids platform file issues).
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, s);
    debugPrint(
        'CartRepository: saved cart to SharedPreferences (${s.length} bytes)');
  }

  // Convenience helpers - simple wrappers that load, modify, and save.
  Future<void> clearCart() async => saveCart([]);

  Future<void> saveLastOrder(List<CartItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final s = jsonEncode(items.map((e) => e.toJson()).toList());
    await prefs.setString('last_order_v1', s);
  }

  // Persistence helpers (seed asset -> SharedPreferences)
  static const assetPath = 'assets/data/cart.json';

  Future<void> copySeedIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_key);
    if (s != null && s.isNotEmpty) return;
    try {
      final data = await rootBundle.loadString(assetPath);
      await prefs.setString(_key, data);
      debugPrint('CartRepository: copied seed asset to SharedPreferences');
    } catch (e) {
      await prefs.setString(_key, '[]');
      debugPrint(
          'CartRepository: seed asset missing, created empty cart in prefs');
    }
  }
}
