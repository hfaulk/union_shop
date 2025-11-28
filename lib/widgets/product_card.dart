import 'package:flutter/material.dart';
import 'package:union_shop/widgets/product_card_impl.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String? originalPrice;
  final String imageUrl;

  const ProductCard(
      {super.key,
      required this.title,
      required this.price,
      this.originalPrice,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ProductCardImpl(
      title: title,
      price: price,
      originalPrice: originalPrice,
      imageUrl: imageUrl,
    );
  }
}
