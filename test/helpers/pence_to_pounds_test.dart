import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  test('penceToPounds formats pence correctly', () {
    expect(penceToPounds(1499), '£14.99');
    expect(penceToPounds(0), '£0.00');
    expect(penceToPounds(5), '£0.05');
    expect(penceToPounds(250000), '£2500.00');
  });
}
