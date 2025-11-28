import 'package:flutter/material.dart';
import 'package:union_shop/widgets/shared_layout.dart';
import 'package:union_shop/widgets/hero_carousel.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/repositories/collection_repository.dart';
import 'package:union_shop/repositories/home_repository.dart';
import 'package:union_shop/repositories/product_repository.dart';

String _humanizeId(String s) => s
    .split('-')
    .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
    .join(' ');

// Helper to render a featured product tile (keeps same visuals as previous implementation)
Widget _productTile(dynamic product, double height) {
  if (product == null) return const SizedBox.shrink();
  return Container(
    height: height,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
    child: Stack(
      fit: StackFit.expand,
      children: [
        product.imageUrl.startsWith('assets/')
            ? Image.asset(product.imageUrl, fit: BoxFit.cover)
            : Image.network(product.imageUrl, fit: BoxFit.cover),
        Container(color: Colors.black26),
        if (product.discount && product.discountedPrice != null)
          Positioned(
            left: 12,
            top: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${(((product.price - product.discountedPrice!) / product.price) * 100).round()}% OFF',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        Positioned(
          left: 12,
          right: 12,
          bottom: 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              if (product.discount && product.discountedPrice != null)
                Row(children: [
                  Text('£${(product.price / 100).toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: Colors.white70,
                          decoration: TextDecoration.lineThrough)),
                  const SizedBox(width: 8),
                  Text(
                      '£${(product.discountedPrice! / 100).toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ])
              else
                Text('£${(product.price / 100).toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ],
    ),
  );
}

// Small helper to compute the grid tile height used by the Our Range grid
double gridTileHeightFor(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final isWide = width > 900;
  final containerWidth = isWide ? 1200.0 : (width - 80.0);
  final columns = isWide ? 4 : 2;
  final spacing = 16.0 * (columns - 1);
  final itemWidth = (containerWidth - spacing) / columns;
  final childAspect = isWide ? 0.9 : 1.0;
  return itemWidth / childAspect;
}

class HomeFeaturedPlaceholder extends StatelessWidget {
  const HomeFeaturedPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          height: 190,
          color: Colors.grey[200],
          child: const Center(child: Text('Featured Collection 1'))),
      const SizedBox(height: 20),
      Container(
          height: 190,
          color: Colors.grey[300],
          child: const Center(child: Text('Featured Collection 2'))),
    ]);
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SharedLayout(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: 400, width: double.infinity, child: HeroCarousel()),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: FutureBuilder<HomeData?>(
                future: HomeRepository(
                        collectionRepo: AssetCollectionRepository(),
                        productRepo: AssetProductRepository())
                    .load(),
                builder: (context, snapshot) {
                  final home = snapshot.data;
                  if (home == null || home.featured.isEmpty) {
                    return const HomeFeaturedPlaceholder();
                  }

                  // use file-level helper `_humanizeId` for slug->title fallback

                  final entries = home.featured.entries.toList();
                  final first = entries.isNotEmpty ? entries[0] : null;
                  final second = entries.length > 1 ? entries[1] : null;

                  Widget buildFeaturedEntry(
                      MapEntry<Collection, List<dynamic>>? entry) {
                    final collection = entry?.key;
                    final products = entry?.value ?? [];

                    final gridTileHeight = gridTileHeightFor(context);

                    return GestureDetector(
                      onTap: collection != null
                          ? () => Navigator.pushNamed(
                              context, '/collections/${collection.id}')
                          : null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            collection != null &&
                                    collection.title.trim().isNotEmpty
                                ? collection.title
                                : _humanizeId(collection?.id ?? 'Featured'),
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          Row(children: [
                            Expanded(
                              child: SizedBox(
                                height: gridTileHeight,
                                child: products.isNotEmpty
                                    ? GestureDetector(
                                        onTap: () => Navigator.pushNamed(
                                                // navigate to product page with arguments
                                                context,
                                                '/product',
                                                arguments: {
                                                  'id': products[0].id,
                                                  'title': products[0].title,
                                                  'imageUrl':
                                                      products[0].imageUrl,
                                                  'price': products[0].price,
                                                  'discount':
                                                      products[0].discount,
                                                  'discountedPrice': products[0]
                                                      .discountedPrice,
                                                }),
                                        child: _productTile(
                                            products[0], gridTileHeight))
                                    : const SizedBox.shrink(),
                              ),
                            ),
                            const SizedBox(width: 32),
                            Expanded(
                              child: SizedBox(
                                height: gridTileHeight,
                                child: products.length > 1
                                    ? GestureDetector(
                                        onTap: () =>
                                            Navigator.pushNamed(context,
                                                '/product', arguments: {
                                              'id': products[1].id,
                                              'title': products[1].title,
                                              'imageUrl': products[1].imageUrl,
                                              'price': products[1].price,
                                              'discount': products[1].discount,
                                              'discountedPrice':
                                                  products[1].discountedPrice,
                                            }),
                                        child: _productTile(
                                            products[1], gridTileHeight))
                                    : const SizedBox.shrink(),
                              ),
                            ),
                          ])
                        ],
                      ),
                    );
                  }

                  // center and constrain the featured area to match the Our Range margins
                  final _widthTop = MediaQuery.of(context).size.width;
                  final _isWideTop = _widthTop > 900;
                  return Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: _isWideTop ? 1200 : double.infinity),
                      child: Column(children: [
                        buildFeaturedEntry(first),
                        const SizedBox(height: 20),
                        buildFeaturedEntry(second)
                      ]),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),
            // Our Range heading
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Center(
                child: Text('OUR RANGE',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5)),
              ),
            ),
            const SizedBox(height: 16),
            // 2x2 collections grid (first 4 collections)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: FutureBuilder<List<Collection>>(
                future: AssetCollectionRepository().fetchAll(),
                builder: (context, snapshot) {
                  final cols = snapshot.data ?? <Collection>[];
                  final width = MediaQuery.of(context).size.width;
                  final isWide = width > 900;
                  // On wide screens show 4 compact columns and center the grid
                  return Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: isWide ? 1200 : double.infinity),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: isWide ? 4 : 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: isWide ? 0.9 : 1,
                        children: List.generate(4, (i) {
                          final c = i < cols.length ? cols[i] : null;
                          return GestureDetector(
                            onTap: c != null
                                ? () => Navigator.pushNamed(
                                    context, '/collections/${c.id}')
                                : null,
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.grey[350],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  if (c?.imageUrl != null)
                                    (c!.imageUrl!.startsWith('assets/')
                                        ? Image.asset(c.imageUrl!,
                                            fit: BoxFit.cover)
                                        : Image.network(c.imageUrl!,
                                            fit: BoxFit.cover))
                                  else
                                    Container(color: Colors.grey[400]),
                                  Container(color: Colors.black26),
                                  Center(
                                    child: Text(
                                      (c != null && c.title.trim().isNotEmpty)
                                          ? c.title
                                          : _humanizeId(
                                              c?.id ?? 'Collection ${i + 1}'),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
