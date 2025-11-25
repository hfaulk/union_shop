import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/repositories/product_repository.dart';

// File-backed test repository (top-level so Dart can compile)
class FileProductRepository implements ProductRepository {
  final String path;
  FileProductRepository(this.path);

  @override
  Future<List<Product>> fetchAll() async {
    final raw = File(path).readAsStringSync();
    final data = json.decode(raw) as List<dynamic>;
    return data
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
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

void main() {
  group('File-backed ProductRepository (test)', () {
    final repo = FileProductRepository('assets/data/products.json');

    test('fetchAll returns non-empty list', () async {
      final all = await repo.fetchAll();
      expect(all, isNotEmpty);
    });

    test('fetchById returns known product', () async {
      final p = await repo.fetchById('classic-hoodies');
      expect(p, isNotNull);
      expect(p!.id, equals('classic-hoodies'));
      expect(p.discount, isTrue);
    });

    test('fetchByCollection returns products for clothing', () async {
      final list = await repo.fetchByCollection('clothing');
      expect(list, isNotEmpty);
      // every product returned should contain the collection id
      expect(list.every((p) => p.collections.contains('clothing')), isTrue);
    });
  });
}
