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
      color: const Color(0xFFF7EEF6),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
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
                    fontSize: 14,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  price,
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ] else ...[
            Text(
              price,
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ],
      ),
    );
  }
}
