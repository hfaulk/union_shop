import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:union_shop/models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchAll();
  Future<Product?> fetchById(String id);
  Future<List<Product>> fetchByCollection(String collectionId);
}

class AssetProductRepository implements ProductRepository {
  final String assetPath;

  /// Reads products from a bundled JSON asset. Default: assets/data/products.json
  AssetProductRepository({this.assetPath = 'assets/data/products.json'});

  @override
  Future<List<Product>> fetchAll() async {
    try {
      final raw = await rootBundle.loadString(assetPath);
      final data = jsonDecode(raw);
      if (data is List) {
        return data
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      // Return empty list on error — callers should handle empty state
      return [];
    }
  }

  @override
  Future<Product?> fetchById(String id) async {
    final all = await fetchAll();
    try {
      return all.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Product>> fetchByCollection(String collectionId) async {
    final all = await fetchAll();
    return all.where((p) => p.collections.contains(collectionId)).toList();
  }
}
