import 'package:flutter/material.dart';
import 'package:union_shop/widgets/shared_layout.dart';
import 'package:union_shop/repositories/product_repository.dart';
import 'package:union_shop/models/product.dart';

class CollectionPage extends StatelessWidget {
  final String id;
  final String title;
  final String? description;

  const CollectionPage(
      {super.key, required this.id, required this.title, this.description});

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
            if (description != null && description!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  description!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF7A7A7A),
                    height: 1.5,
                  ),
                ),
              ),
            const SizedBox(height: 20),

            // Filter / Sort bar (visual only for now)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'FILTER BY',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF9E9E9E),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'All products',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'SORT BY',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF9E9E9E),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Best selling',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1, thickness: 1),
                  const SizedBox(height: 12),

                  // Load and show products for this collection
                  FutureBuilder<List<Product>>(
                    future: AssetProductRepository().fetchByCollection(id),
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const SizedBox(height: 18);
                      }

                      final products = snap.data ?? [];
                      final count = products.length;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            '$count products',
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Color(0xFF9E9E9E),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Step 2: GridView of product titles (small, simple cards)
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  MediaQuery.of(context).size.width > 600
                                      ? 3
                                      : 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, i) {
                              final p = products[i];
                              return Card(
                                clipBehavior: Clip.hardEdge,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      p.title,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
