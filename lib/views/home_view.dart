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
                    return Column(children: [
                      Container(
                          height: 190,
                          color: Colors.grey[200],
                          child: const Center(
                              child: Text('Featured Collection 1'))),
                      const SizedBox(height: 20),
                      Container(
                          height: 190,
                          color: Colors.grey[300],
                          child: const Center(
                              child: Text('Featured Collection 2'))),
                    ]);
                  }

                  // use file-level helper `_humanizeId` for slug->title fallback

                  final entries = home.featured.entries.toList();
                  final first = entries.isNotEmpty ? entries[0] : null;
                  final second = entries.length > 1 ? entries[1] : null;

                  Widget buildFeaturedEntry(
                      MapEntry<Collection, List<dynamic>>? entry) {
                    final collection = entry?.key;
                    final products = entry?.value ?? [];
                    final p = products.isNotEmpty ? products[0] : null;
                    final price = p != null
                        ? '£${(p.price / 100).toStringAsFixed(2)}'
                        : '';

                    return GestureDetector(
                      onTap: collection != null
                          ? () => Navigator.pushNamed(
                              context, '/collections/${collection.id}')
                          : null,
                      child: Container(
                        height: 190,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)),
                        child: Stack(fit: StackFit.expand, children: [
                          if (collection?.imageUrl != null)
                            (collection!.imageUrl!.startsWith('assets/')
                                ? Image.asset(collection.imageUrl!,
                                    fit: BoxFit.cover)
                                : Image.network(collection.imageUrl!,
                                    fit: BoxFit.cover))
                          else
                            Container(color: Colors.grey[200]),
                          Container(color: Colors.black26),
                          Positioned(
                            left: 12,
                            bottom: 12,
                            right: 12,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(collection?.title ?? 'Featured',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  if (p != null)
                                    Text('${p.title} • $price',
                                        style: const TextStyle(
                                            color: Colors.white70)),
                                ]),
                          ),
                        ]),
                      ),
                    );
                  }

                  return Column(children: [
                    buildFeaturedEntry(first),
                    const SizedBox(height: 20),
                    buildFeaturedEntry(second)
                  ]);
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
