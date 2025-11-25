import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/collections.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/repositories/collection_repository.dart';

class FakeCollectionRepo implements CollectionRepository {
  final List<Collection> items;
  FakeCollectionRepo(this.items);
  @override
  Future<List<Collection>> fetchAll() async => items;
  @override
  Future<Collection?> fetchById(String id) async =>
      items.firstWhere((c) => c.id == id, orElse: () => null);
}

void main() {
  testWidgets('CollectionsPage shows collections from injected repo',
      (WidgetTester tester) async {
    final sample = [
      const Collection(id: 'autumn', title: 'Autumn Favourites'),
      const Collection(id: 'clothing', title: 'Clothing'),
    ];

    await tester.pumpWidget(MaterialApp(
      home: CollectionsPage(repo: FakeCollectionRepo(sample)),
    ));

    await tester.pumpAndSettle();

    expect(find.text('Collections'), findsOneWidget);
    expect(find.text('Autumn Favourites'), findsOneWidget);
    expect(find.text('Clothing'), findsOneWidget);
  });
}
