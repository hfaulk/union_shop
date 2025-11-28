import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../models/cart_item.dart';

class CartRepository {
  static const _key = 'cart_items_v1';
  // Optional provider for tests to inject a documents directory.
  final Future<Directory> Function()? documentsDirProvider;

  CartRepository({this.documentsDirProvider});

  Future<List<CartItem>> loadCart() async {
    // Try file-based cart first for cross-run persistence.
    try {
      final file = await _localFile();
      if (await file.exists()) {
        final s = await file.readAsString();
        if (s.trim().isNotEmpty) {
          debugPrint('CartRepository: loading cart from file ${file.path}');
          final data = jsonDecode(s) as List;
          return data
              .map((e) => CartItem.fromJson(Map<String, dynamic>.from(e)))
              .toList();
        }
      }
    } catch (e) {
      debugPrint('CartRepository: file load failed: ${e.toString()}');
    }
    // Fallback to SharedPreferences
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
    // Prefer writing to a local file (atomic), then also back up to SharedPreferences.
    try {
      final file = await _localFile();
      final tmp = File('${file.path}.tmp');
      await tmp.writeAsString(s, flush: true);
      try {
        await tmp.rename(file.path);
      } catch (e) {
        debugPrint(
            'CartRepository: rename failed (${e.toString()}), falling back');
        if (await file.exists()) await file.delete();
        await file.writeAsString(s, flush: true);
      }
      debugPrint('CartRepository: saved cart to file ${file.path}');
    } catch (e) {
      debugPrint('CartRepository: file save failed: ${e.toString()}');
    }
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

  // Persistence helpers for asset -> local file
  static const assetPath = 'assets/data/cart.json';

  Future<String> _getLocalPath() async {
    if (documentsDirProvider != null) {
      final d = await documentsDirProvider!.call();
      return d.path;
    }
    try {
      final dir = await getApplicationDocumentsDirectory();
      return dir.path;
    } catch (e) {
      debugPrint(
          'CartRepository: getApplicationDocumentsDirectory failed: ${e.toString()}');
      // Try to use a user-home-based fallback when possible, but Platform.environment
      // may not be available in some runtimes (it can throw). Guard it.
      try {
        final env = Platform.environment;
        final home = env['HOME'] ?? env['USERPROFILE'];
        if (home != null && home.isNotEmpty) {
          final fallback = Directory(p.join(home, '.union_shop'));
          if (!await fallback.exists()) await fallback.create(recursive: true);
          return fallback.path;
        }
      } catch (e2) {
        debugPrint(
            'CartRepository: Platform.environment unavailable: ${e2.toString()}');
      }
      // Last resort: use current working directory.
      final cur = Directory.current;
      return cur.path;
    }
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
