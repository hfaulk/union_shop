import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import '../models/cart_item.dart';

class CartRepository {
  static const _key = 'cart_items_v1';
  // Optional provider for tests to inject a documents directory.
  final Future<Directory> Function()? documentsDirProvider;

  CartRepository({this.documentsDirProvider});

  Future<List<CartItem>> loadCart() async {
    // On web, file system APIs and path_provider are not available.
    // Use SharedPreferences as the primary persistence mechanism instead.
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      final s = prefs.getString(_key);
      if (s == null) return [];
      final data = jsonDecode(s) as List;
      return data
          .map((e) => CartItem.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }

    await copySeedIfNeeded();
    final file = await _localFile();
    if (await file.exists()) {
      try {
        final s = await file.readAsString();
        debugPrint(
            'CartRepository: loading cart from ${file.path} (${s.length} bytes)');
        final data = jsonDecode(s) as List;
        return data
            .map((e) => CartItem.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } catch (_) {}
    }
    debugPrint(
        'CartRepository: local cart file not usable, falling back to SharedPreferences');
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_key);
    if (s == null) return [];
    final data = jsonDecode(s) as List;
    return data
        .map((e) => CartItem.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> saveCart(List<CartItem> items) async {
    final s = jsonEncode(items.map((e) => e.toJson()).toList());
    // On web, prefer SharedPreferences (localStorage) instead of file I/O.
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, s);
      return;
    }

    // write atomically to local file
    final file = await _localFile();
    final tmp = File('${file.path}.tmp');
    await tmp.writeAsString(s, flush: true);
    await tmp.rename(file.path);
    debugPrint(
        'CartRepository: saved cart to ${file.path} (${s.length} bytes)');
    // also save to prefs for backward compatibility
    final prefs = await SharedPreferences.getInstance();
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
    if (documentsDirProvider != null) {
      final d = await documentsDirProvider!.call();
      return d.path;
    }
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
      debugPrint('CartRepository: copied seed asset to ${file.path}');
    } catch (e) {
      await file.writeAsString('[]', flush: true);
      debugPrint(
          'CartRepository: seed asset missing, created empty cart at ${file.path}');
    }
  }
}
