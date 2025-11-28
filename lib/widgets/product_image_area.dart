import 'package:flutter/material.dart';

class ProductImageArea extends StatelessWidget {
  final String imageUrl;

  const ProductImageArea({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: imageUrl.startsWith('assets/')
          ? Image.asset(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            )
          : Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                );
              },
            ),
    );
  }
}
