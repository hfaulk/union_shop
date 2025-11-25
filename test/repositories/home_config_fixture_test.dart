import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('home_config.json fixture has featuredCollections mapping', () {
    final raw = File('assets/data/home_config.json').readAsStringSync();
    final list = json.decode(raw) as List<dynamic>;
    final map = (list.isNotEmpty ? list.first as Map<String, dynamic> : {});

    expect(map.containsKey('featuredCollections') || map.keys.isNotEmpty, isTrue);
    final featured = (map['featuredCollections'] as Map<String, dynamic>?);
    expect(featured, isNotNull);
    expect(featured!.isNotEmpty, isTrue);
  });
}
