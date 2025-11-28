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
            // If parent provides a bounded height (e.g. grid cell), let the image
            // expand to fill available space. Otherwise fall back to a fixed
            // height so the card can size itself (prevents unbounded flex errors).
            LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxHeight.isFinite) {
                return Expanded(child: ProductImageArea(imageUrl: imageUrl));
              }
              return SizedBox(
                  height: 95, child: ProductImageArea(imageUrl: imageUrl));
            }),
            ProductInfoArea(
                title: title, price: price, originalPrice: originalPrice),
          ],
        ),
      ),
    );
  }
}
