import 'package:flutter/material.dart';
import 'package:union_shop/widgets/product_image_area.dart';
import 'package:union_shop/widgets/product_info_area.dart';

class ProductCardImpl extends StatelessWidget {
  final String title;
  final String price;
  final String? originalPrice;
  final String imageUrl;
  final String? id;

  const ProductCardImpl(
      {super.key,
      required this.title,
      required this.price,
      this.originalPrice,
      required this.imageUrl,
      this.id});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: InkWell(
        onTap: () {
          if (id == null) return;
          Navigator.pushNamed(context, '/product/$id');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageArea(imageUrl: imageUrl),
            ProductInfoArea(
                title: title, price: price, originalPrice: originalPrice),
          ],
        ),
      ),
    );
  }
}
