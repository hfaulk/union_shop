import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

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

  // Persistence helpers for asset -> local file
  static const assetPath = 'assets/data/cart.json';

  Future<String> _getLocalPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> _localFile() async {
    final path = await _getLocalPath();
    return File('$path/cart.json');
  }

  Future<void> copySeedIfNeeded() async {
    final file = await _localFile();
    if (await file.exists()) return;
    try {
      final data = await rootBundle.loadString(assetPath);
      await file.writeAsString(data, flush: true);
    } catch (e) {
      await file.writeAsString('[]', flush: true);
    }
  }
}
