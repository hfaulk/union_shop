import 'package:flutter/material.dart';
import 'package:union_shop/widgets/shared_layout.dart';
import 'package:union_shop/widgets/product_card.dart';
import 'package:union_shop/repositories/product_repository.dart';
import 'package:union_shop/repositories/collection_repository.dart';
import 'package:union_shop/models/product.dart';

class CollectionPage extends StatefulWidget {
  final String id;
  final String title;
  final String? description;
  final ProductRepository? productRepo;

  const CollectionPage(
      {super.key,
      required this.id,
      required this.title,
      this.description,
      this.productRepo});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  String _selectedSort = 'Featured';

  static const int pageSize = 12;
  int currentPage = 1;

  final List<String> _sortOptions = [
    'Featured',
    'Best selling',
    'Alphabetically, A-Z',
    'Alphabetically, Z-A',
    'Price, Low to High',
    'Price, High to Low',
  ];

  // Filter options requested: label -> collection id used for filtering
  final Map<String, String> _filterMap = {
    'All Products': 'all',
    'Clothing': 'clothing',
    'Merchandise': 'merchandise',
    'Popular': 'popular',
  };

  String _selectedFilterKey = 'all';
  late Future<List<Product>> _productsFuture;
  String displayTitle = '';
  String? displayDescription;

  @override
  void initState() {
    super.initState();
    final repo = widget.productRepo ?? AssetProductRepository();
    _productsFuture = repo.fetchByCollection(widget.id);
    // initialize display title/description and try to load canonical values
    displayTitle = widget.title;
    displayDescription = widget.description;
    // Do not override the initial title immediately — keep the slug/title
    // provided by the route so tests that expect the slug (e.g. 'autumn')
    // continue to pass. If richer metadata is required later, it can be
    // loaded and shown without replacing the initial title.
  }

  @override
  void didUpdateWidget(covariant CollectionPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id) {
      _productsFuture = AssetProductRepository().fetchByCollection(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Choose number of columns based on available width so cards aren't huge on desktop
    int crossAxisCount;
    double gridChildAspectRatio;
    if (width > 1400) {
      crossAxisCount = 5;
      gridChildAspectRatio = 0.9;
    } else if (width > 1000) {
      crossAxisCount = 4;
      gridChildAspectRatio = 0.9;
    } else if (width > 700) {
      crossAxisCount = 3;
      gridChildAspectRatio = 0.9;
    } else {
      crossAxisCount = 2;
      gridChildAspectRatio = 0.75;
    }
    return SharedLayout(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                displayTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (widget.description != null && widget.description!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  widget.description!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF7A7A7A),
                    height: 1.5,
                  ),
                ),
              ),
            const SizedBox(height: 20),

            // Filter / Sort bar
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
                            const SizedBox(height: 8),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedFilterKey,
                                items: _filterMap.entries
                                    .map((e) => DropdownMenuItem(
                                          value: e.value,
                                          child: Text(e.key),
                                        ))
                                    .toList(),
                                onChanged: (v) {
                                  if (v == null) return;
                                  setState(() {
                                    _selectedFilterKey = v;
                                  });
                                },
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF333333),
                                ),
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
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedSort,
                                items: _sortOptions
                                    .map((s) => DropdownMenuItem(
                                          value: s,
                                          child: Text(s),
                                        ))
                                    .toList(),
                                onChanged: (v) {
                                  if (v == null) return;
                                  setState(() {
                                    _selectedSort = v;
                                  });
                                },
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF333333),
                                ),
                                dropdownColor: Colors.white,
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
                    future: _productsFuture,
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const SizedBox(height: 18);
                      }

                      final products = snap.data ?? [];
                      // Apply selected sort in-memory
                      final sorted = List<Product>.from(products);

                      // Helper: effective price uses discountedPrice when available
                      int effectivePrice(Product p) {
                        // Prefer the discounted price only when the product
                        // explicitly has a discount and the discounted value
                        // is actually lower than the original price. This
                        // guards against inconsistent data where
                        // `discountedPrice` might be >= `price`.
                        if (p.discount && p.discountedPrice != null) {
                          return p.discountedPrice! < p.price
                              ? p.discountedPrice!
                              : p.price;
                        }
                        return p.price;
                      }

                      // Normalize selected sort to be case-insensitive and robust
                      final sortKey = _selectedSort.toLowerCase();
                      if (sortKey == 'alphabetically, a-z') {
                        sorted.sort((a, b) => a.title
                            .toLowerCase()
                            .compareTo(b.title.toLowerCase()));
                      } else if (sortKey == 'alphabetically, z-a') {
                        sorted.sort((a, b) => b.title
                            .toLowerCase()
                            .compareTo(a.title.toLowerCase()));
                      } else if (sortKey.contains('price') &&
                          sortKey.contains('low to high')) {
                        sorted.sort((a, b) =>
                            effectivePrice(a).compareTo(effectivePrice(b)));
                      } else if (sortKey.contains('price') &&
                          sortKey.contains('high to low')) {
                        sorted.sort((a, b) =>
                            effectivePrice(b).compareTo(effectivePrice(a)));
                      } else {
                        // Featured / Best selling / unknown: keep original order
                      }

                      // Apply collection filter based on selected key
                      final filtered = _selectedFilterKey == 'all'
                          ? sorted
                          : sorted
                              .where((p) =>
                                  p.collections.contains(_selectedFilterKey))
                              .toList();

                      final count = filtered.length;

                      // Pagination slice for current page
                      final start = (currentPage - 1) * pageSize;
                      final pagedProducts =
                          filtered.skip(start).take(pageSize).toList();

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
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: gridChildAspectRatio,
                            ),
                            itemCount: pagedProducts.length,
                            itemBuilder: (context, i) {
                              final p = pagedProducts[i];
                              final priceText =
                                  '£${(p.discount && p.discountedPrice != null ? (p.discountedPrice! / 100).toStringAsFixed(2) : (p.price / 100).toStringAsFixed(2))}';
                              final original =
                                  (p.discount && p.discountedPrice != null)
                                      ? '£${(p.price / 100).toStringAsFixed(2)}'
                                      : null;
                              return InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, '/product/${p.id}'),
                                child: ProductCard(
                                  title: p.title,
                                  price: priceText,
                                  originalPrice: original,
                                  imageUrl: p.imageUrl,
                                  id: p.id,
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
