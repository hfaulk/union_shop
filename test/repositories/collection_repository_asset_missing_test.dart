import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/repositories/collection_repository.dart';

void main() {
  test('AssetCollectionRepository returns empty when asset missing', () async {
    final repo = AssetCollectionRepository(assetPath: 'nonexistent_asset.json');
    final list = await repo.fetchAll();
    expect(list, isEmpty);
  });
}
