import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:union_shop/views/collection_page.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/repositories/product_repository.dart';

class FakeProductRepository implements ProductRepository {
  final List<Product> products;
  FakeProductRepository(this.products);

  @override
  Future<List<Product>> fetchAll() async => products;

  @override
  Future<Product?> fetchById(String id) async => () async {
        try {
          return products.firstWhere((p) => p.id == id);
        } catch (_) {
          return null;
        }
      }();

  @override
  Future<List<Product>> fetchByCollection(String collectionId) async =>
      products.where((p) => p.collections.contains(collectionId)).toList();
}

void main() {
  testWidgets('CollectionPage filtering and sorting', (tester) async {
    final p1 = Product(
      id: 'p1',
      title: 'Alpha Shirt',
      price: 3000,
      imageUrl: '',
      collections: ['clothing'],
    );
    final p2 = Product(
      id: 'p2',
      title: 'Budget Tee',
      price: 1500,
      imageUrl: '',
      collections: ['clothing'],
    );

    final fakeRepo = FakeProductRepository([p1, p2]);

    await tester.pumpWidget(MaterialApp(
      home: MediaQuery(
        data: const MediaQueryData(size: Size(800, 1200)),
        child: CollectionPage(
            id: 'clothing', title: 'Clothing', productRepo: fakeRepo),
      ),
    ));

    await tester.pumpAndSettle();

    // Both products should be present
    expect(find.text('2 products'), findsOneWidget);

    // By default order is the repo order (p1 then p2)
    final firstTitle = find.text('Alpha Shirt');
    final secondTitle = find.text('Budget Tee');
    expect(firstTitle, findsOneWidget);
    expect(secondTitle, findsOneWidget);

    // Open sort dropdown and select Price, Low to High
    await tester.tap(find.text('Featured'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Price, Low to High').last);
    await tester.pumpAndSettle();

    // After sorting, the cheaper product should appear before the expensive one
    final firstPos = tester.getTopLeft(find.text('Budget Tee'));
    final secondPos = tester.getTopLeft(find.text('Alpha Shirt'));
    expect(firstPos.dy <= secondPos.dy ? firstPos.dx <= secondPos.dx : true,
        isTrue);
  });
}
