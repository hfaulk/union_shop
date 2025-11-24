import 'package:flutter/material.dart';
import 'package:union_shop/views/product_page.dart';
import 'package:union_shop/views/about.dart';
import 'package:union_shop/views/collections.dart';
import 'package:union_shop/views/collection_page.dart';
import 'package:union_shop/widgets/shared_layout.dart';
import 'package:union_shop/repositories/home_repository.dart';
import 'package:union_shop/repositories/collection_repository.dart';
import 'package:union_shop/repositories/product_repository.dart';

void main() {
  runApp(const UnionShopApp());
}

// Small helper: format integer pence as a pounds string, e.g. 1499 -> £14.99
String penceToPounds(int pence) => '£${(pence / 100).toStringAsFixed(2)}';

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      home: const HomeScreen(),
      initialRoute: '/',
      routes: {
        '/product': (context) => const ProductPage(),
        '/collections': (context) => const CollectionsPage(),
        '/about': (context) => const AboutPage(),
      },
      onGenerateRoute: (settings) {
        final name = settings.name ?? '';
        // parse as URI to handle any encoded parts
        final uri = Uri.parse(name);
        // match /collections/:slug
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments[0] == 'collections') {
          final slug = uri.pathSegments[1];
          final title = Uri.decodeComponent(slug.replaceAll('-', ' '));
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => CollectionPage(
              id: slug,
              title: title,
            ),
          );
        }
        return null; // fall back to routes map
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateToCollection(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return SharedLayout(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ),
                  // Content overlay - loaded from `assets/data/home_config.json`
                  Positioned(
                    left: 24,
                    right: 24,
                    top: 80,
                    child: FutureBuilder<HomeData?>(
                      future: HomeRepository(
                        collectionRepo: AssetCollectionRepository(),
                        productRepo: AssetProductRepository(),
                      ).load(),
                      builder: (context, snapshot) {
                        final home = snapshot.data;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              home?.heroTitle ??
                                  'Essential Range - Over 20% Off!',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              home?.heroDescription ??
                                  'Over 20% off on our Essential Range. Come and grab yours while stocks last!',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton(
                              onPressed: () {
                                final heroCollection = home?.heroCollection;
                                if (heroCollection != null) {
                                  Navigator.pushNamed(context,
                                      '/collections/${heroCollection.id}');
                                } else {
                                  navigateToCollection(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4d2963),
                                foregroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                                minimumSize: const Size(0, 56),
                              ),
                              child: const Text(
                                'BROWSE COLLECTION',
                                style:
                                    TextStyle(fontSize: 14, letterSpacing: 1),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Featured Collection #1 Section
            Container(
              child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      const Text('Featured Collection #1',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black))
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String? originalPrice;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
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
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              if (originalPrice != null) ...[
                Row(
                  children: [
                    Text(
                      originalPrice!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      price,
                      style: const TextStyle(fontSize: 13, color: Colors.blue),
                    ),
                  ],
                ),
              ] else ...[
                Text(
                  price,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
