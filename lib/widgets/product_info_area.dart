import 'package:flutter/material.dart';

class ProductInfoArea extends StatelessWidget {
  final String title;
  final String price;
  final String? originalPrice;

  const ProductInfoArea(
      {super.key,
      required this.title,
      required this.price,
      this.originalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2E2E2E)),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          if (originalPrice != null) ...[
            Row(
              children: [
                Text(
                  originalPrice!,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF9E9E9E),
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  price,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF4d2963),
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ] else ...[
            Text(
              price,
              style: const TextStyle(fontSize: 15, color: Color(0xFF7A7A7A)),
            ),
          ],
        ],
      ),
    );
  }
}
