import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:union_shop/models/product.dart';

// Simple file-backed product repo helper for tests
class FileProductRepo {
  final String path;
  FileProductRepo(this.path);

  Future<List<Product>> fetchAll() async {
    final raw = File(path).readAsStringSync();
    final data = json.decode(raw) as List<dynamic>;
    return data.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Product?> fetchById(String id) async {
    final all = await fetchAll();
    try {
      return all.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<List<Product>> fetchByCollection(String collectionId) async {
    final all = await fetchAll();
    return all.where((p) => p.collections.contains(collectionId)).toList();
  }
}

void main() {
  group('Home selection logic (fixture-driven)', () {
    final prodRepo = FileProductRepo('assets/data/products.json');

    test('when product ids provided, those products are selected in order', () async {
      final productIds = ['classic-hoodies', 'classic-sweatshirts'];
      final chosen = <Product>[];
      for (final pid in productIds) {
        final p = await prodRepo.fetchById(pid);
        if (p != null) chosen.add(p);
        if (chosen.length >= 2) break;
      }

      expect(chosen.length, equals(2));
      expect(chosen[0].id, equals('classic-hoodies'));
      expect(chosen[1].id, equals('classic-sweatshirts'));
    });

    test('fallback chooses lowest-priced products from collection', () async {
      final products = await prodRepo.fetchByCollection('autumn');
      expect(products, isNotEmpty);

      int effectivePrice(Product p) => (p.discount && p.discountedPrice != null)
          ? p.discountedPrice!
          : p.price;

      final sorted = List<Product>.from(products);
      sorted.sort((a, b) => effectivePrice(a).compareTo(effectivePrice(b)));
      final chosen = sorted.take(2).toList();

      // Based on fixtures: 'classic-hoodies' has discountedPrice 899, 'classic-sweatshirts' 2300
      expect(chosen[0].id, equals('classic-hoodies'));
      expect(chosen[1].id, equals('classic-sweatshirts'));
    });
  });
}
