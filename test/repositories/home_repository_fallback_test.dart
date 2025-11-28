import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/repositories/home_repository.dart';
import 'package:union_shop/repositories/collection_repository.dart';
import 'package:union_shop/repositories/product_repository.dart';

class _FakeCollectionRepo implements CollectionRepository {
  @override
  Future<List<Collection>> fetchAll() async =>
      [const Collection(id: 'c1', title: 'C1')];
  @override
  Future<Collection?> fetchById(String id) async =>
      id == 'c1' ? const Collection(id: 'c1', title: 'C1') : null;
}

class _FakeProductRepo implements ProductRepository {
  @override
  Future<List<Product>> fetchAll() async => [];
  @override
  Future<Product?> fetchById(String id) async => null;
  @override
  Future<List<Product>> fetchByCollection(String collectionId) async =>
      [const Product(id: 'p1', title: 'P1', price: 100, imageUrl: '')];
}

void main() {
  test('HomeRepository.load fallback uses repos when asset missing', () async {
    final repo = HomeRepository(
      assetPath: 'nonexistent.json',
      collectionRepo: _FakeCollectionRepo(),
      productRepo: _FakeProductRepo(),
    );
    final data = await repo.load();
    expect(data, isNotNull);
    expect(data!.heroCollection!.id, 'c1');
    expect(data.featured.keys.first.id, 'c1');
  });
}
