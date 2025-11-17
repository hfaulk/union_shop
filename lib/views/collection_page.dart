import 'package:flutter/material.dart';
import 'package:union_shop/widgets/shared_layout.dart';

class CollectionPage extends StatelessWidget {
  final String title;

  const CollectionPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SharedLayout(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // No content yet — placeholder for collection products
          ],
        ),
      ),
    );
  }
}
