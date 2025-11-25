import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/repositories/home_repository.dart';
import 'package:union_shop/repositories/collection_repository.dart';
import 'package:union_shop/repositories/product_repository.dart';

void main() {
  group('HomeRepository', () {
    final collectionRepo = AssetCollectionRepository();
    final productRepo = AssetProductRepository();
    final repo = HomeRepository(collectionRepo: collectionRepo, productRepo: productRepo);

    test('load returns HomeData with featured collections', () async {
      final hd = await repo.load();
      expect(hd, isNotNull);
      expect(hd!.featured, isNotEmpty);
      // check that each featured entry has up to two products
      for (final entry in hd.featured.entries) {
        expect(entry.value.length, lessThanOrEqualTo(2));
      }
    });
  });
}
