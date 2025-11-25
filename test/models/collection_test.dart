import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/collection.dart';

void main() {
  test('Collection JSON round-trip for first collection', () {
    final jsonStr = File('assets/data/collections.json').readAsStringSync();
    final list = json.decode(jsonStr) as List<dynamic>;
    final map = list[0] as Map<String, dynamic>;

    final collection = Collection.fromJson(map);

    expect(collection, isA<Collection>());
    expect(collection.id, equals(map['id']));
    expect(collection.title, equals(map['title']));
    expect(collection.description, equals(map['description']));

    final out = collection.toJson();
    expect(out['id'], equals(map['id']));
    expect(out['title'], equals(map['title']));
    expect(out['imageUrl'], equals(map['imageUrl']));
  });
}
