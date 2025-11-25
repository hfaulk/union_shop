import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/home_config.dart';

void main() {
  test('HomeConfig parsing from fixture', () {
    final jsonStr = File('assets/data/home_config.json').readAsStringSync();
    final list = json.decode(jsonStr) as List<dynamic>;
    final map = (list.isNotEmpty ? list[0] : {}) as Map<String, dynamic>;

    final cfg = HomeConfig.fromJson(map);

    expect(cfg, isA<HomeConfig>());
    expect(cfg.featuredCollections.containsKey('signature-essentials'), isTrue);
    expect(cfg.featuredCollections['signature-essentials']!.contains('signature-tshirt'), isTrue);
  });
}
