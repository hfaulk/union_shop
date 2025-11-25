import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/repositories/collection_repository.dart';

void main() {
  group('AssetCollectionRepository', () {
    final repo = AssetCollectionRepository();

    test('fetchAll returns non-empty list', () async {
      final all = await repo.fetchAll();
      expect(all, isNotEmpty);
    });

    test('fetchById returns known collection', () async {
      final c = await repo.fetchById('autumn');
      expect(c, isNotNull);
      expect(c!.id, equals('autumn'));
      expect(c.title, contains('Autumn'));
    });
  });
}
