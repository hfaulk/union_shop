import 'package:flutter/material.dart';
import 'package:union_shop/widgets/shared_layout.dart';
import 'package:union_shop/repositories/product_repository.dart';
// collections are not fetched here; FILTER BY will use static options from the screenshot
import 'package:union_shop/models/product.dart';

class CollectionPage extends StatefulWidget {
  final String id;
  final String title;
  final String? description;

  const CollectionPage(
      {super.key, required this.id, required this.title, this.description});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  String _selectedSort = 'Featured';

  final List<String> _sortOptions = [
    'Featured',
    'Best selling',
    'Alphabetically, A-Z',
    'Alphabetically, Z-A',
    'Price, low to high',
    'Price, high to low',
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

  @override
  void initState() {
    super.initState();
    _productsFuture = AssetProductRepository().fetchByCollection(widget.id);
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
    return SharedLayout(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                widget.title,
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
                      switch (_selectedSort) {
                        case 'Alphabetically, A-Z':
                          sorted.sort((a, b) => a.title
                              .toLowerCase()
                              .compareTo(b.title.toLowerCase()));
                          break;
                        case 'Alphabetically, Z-A':
                          sorted.sort((a, b) => b.title
                              .toLowerCase()
                              .compareTo(a.title.toLowerCase()));
                          break;
                        case 'Price, low to high':
                          sorted.sort((a, b) => a.price.compareTo(b.price));
                          break;
                        case 'Price, high to low':
                          sorted.sort((a, b) => b.price.compareTo(a.price));
                          break;
                        default:
                          // Featured / Best selling / unknown: keep original order
                          break;
                      }

                      // Apply collection filter based on selected key
                      final filtered = _selectedFilterKey == 'all'
                          ? sorted
                          : sorted
                              .where((p) =>
                                  p.collections.contains(_selectedFilterKey))
                              .toList();

                      final count = filtered.length;

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
                              childAspectRatio: 0.9,
                            ),
                            itemCount: filtered.length,
                            itemBuilder: (context, i) {
                              final p = filtered[i];
                              return Card(
                                clipBehavior: Clip.hardEdge,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    // Image (covers area). Falls back to placeholder on error/empty URL.
                                    AspectRatio(
                                      aspectRatio: 4 / 3,
                                      child: Builder(builder: (ctx) {
                                        final src = p.imageUrl;
                                        if (src.isEmpty) {
                                          return Container(
                                            color: const Color(0xFFF2F2F2),
                                            child: const Center(
                                              child: Icon(
                                                Icons.image,
                                                color: Color(0xFFBDBDBD),
                                              ),
                                            ),
                                          );
                                        }

                                        return Image.network(
                                          src,
                                          fit: BoxFit.cover,
                                          loadingBuilder:
                                              (context, child, chunk) {
                                            if (chunk == null) return child;
                                            return Container(
                                              color: const Color(0xFFF2F2F2),
                                              child: const Center(
                                                child: SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stack) {
                                            return Container(
                                              color: const Color(0xFFF2F2F2),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.broken_image,
                                                  color: Color(0xFFBDBDBD),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12.0, 8.0, 12.0, 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            p.title,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF2E2E2E),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '£' +
                                                (p.price / 100)
                                                    .toStringAsFixed(2),
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Color(0xFF7A7A7A),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
