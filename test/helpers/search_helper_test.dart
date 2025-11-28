import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/helpers/search_helper.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/repositories/product_repository.dart';

class _FakeRepo implements ProductRepository {
  final List<Product> _items;
  _FakeRepo(this._items);
  @override
  Future<List<Product>> fetchAll() async => _items;
  @override
  Future<Product?> fetchById(String id) async {
    try {
      return _items.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Product>> fetchByCollection(String collectionId) async =>
      _items.where((p) => p.collections.contains(collectionId)).toList();
}

void main() {
  test('SearchHelper.search matches title and id and handles empty query',
      () async {
    final items = [
      Product(id: 'p1', title: 'Apple Pie', price: 100, imageUrl: ''),
      Product(id: 'p2', title: 'Banana', price: 50, imageUrl: ''),
    ];
    final helper = SearchHelper(repository: _FakeRepo(items));
    expect(await helper.search('apple'), [items[0]]);
    expect(await helper.search('P2'), [items[1]]);
    expect(await helper.search('   '), []);
  });
}
