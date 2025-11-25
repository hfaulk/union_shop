import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/repositories/product_repository.dart';

void main() {
  group('AssetProductRepository', () {
    final repo = AssetProductRepository();

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
