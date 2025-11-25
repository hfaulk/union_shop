import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/collection.dart';

void main() {
  test('Collection equality and hashCode', () {
    final a = Collection(
        id: 'autumn', title: 'Autumn', description: 'desc', imageUrl: 'img');
    final b = Collection(
        id: 'autumn', title: 'Autumn', description: 'desc', imageUrl: 'img');
    final c = a.copyWith(title: 'Different');

    expect(a, equals(b));
    expect(a.hashCode, equals(b.hashCode));
    expect(a == c, isFalse);
    expect(c.title, equals('Different'));
  });
}
