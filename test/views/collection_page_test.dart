import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/collection_page.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/repositories/product_repository.dart';

class _FakeProductRepo implements ProductRepository {
  @override
  Future<List<Product>> fetchAll() async => [];
  @override
  Future<Product?> fetchById(String id) async => null;
  @override
  Future<List<Product>> fetchByCollection(String collectionId) async => [];
}

void main() {
  testWidgets('CollectionPage displays provided title', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CollectionPage(
          id: 'c1', title: 'My Collection', productRepo: _FakeProductRepo()),
    ));
    expect(find.text('My Collection'), findsOneWidget);
  });
}
