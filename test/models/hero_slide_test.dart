import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/hero_slide.dart';

void main() {
  test('HeroSlide JSON parsing from fixture', () {
    final jsonStr = File('assets/data/hero_slides.json').readAsStringSync();
    final list = json.decode(jsonStr) as List<dynamic>;
    final map = list[0] as Map<String, dynamic>;

    final slide = HeroSlide.fromJson(map);

    expect(slide, isA<HeroSlide>());
    expect(slide.title, equals(map['title']));
    expect(slide.description, equals(map['description']));
    expect(slide.buttonText, equals(map['buttonText']));
    expect(slide.routeOrUrl, equals(map['routeOrUrl']));
  });
}
