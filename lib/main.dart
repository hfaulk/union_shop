import 'package:flutter/material.dart';
import 'package:union_shop/view_models/cart_view_model.dart';
import 'package:union_shop/views/product_page.dart';
import 'package:union_shop/views/about.dart';
import 'package:union_shop/views/collections.dart';
import 'package:union_shop/views/collection_page.dart';
import 'package:union_shop/views/login.dart';
import 'package:union_shop/views/cart_page.dart';
import 'package:union_shop/widgets/shared_layout.dart';
import 'package:union_shop/widgets/hero_carousel.dart';
import 'package:union_shop/widgets/product_image_area.dart';
import 'package:union_shop/widgets/product_info_area.dart';
import 'package:union_shop/repositories/home_repository.dart';
import 'package:union_shop/repositories/collection_repository.dart';
import 'package:union_shop/repositories/product_repository.dart';
import 'package:union_shop/views/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cartViewModel = CartViewModel();
  // expose globally for simple access from screens
  appCartViewModel = cartViewModel;
  await cartViewModel.loadCart();
  runApp(UnionShopApp(cartViewModel: cartViewModel));
}

// Small helper: format integer pence as a pounds string, e.g. 1499 -> £14.99
String penceToPounds(int pence) => '£${(pence / 100).toStringAsFixed(2)}';

class UnionShopApp extends StatelessWidget {
  final CartViewModel? cartViewModel;
  const UnionShopApp({super.key, this.cartViewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      home: const HomeView(),
      initialRoute: '/',
      routes: {
        '/product': (context) => const ProductPage(),
        '/cart': (context) => const CartPage(),
        '/collections': (context) => const CollectionsPage(),
        '/about': (context) => const AboutPage(),
        '/login': (context) => const LoginPage(),
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

@Deprecated('Use HomeView')
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
            // Hero Section (replaced by widget)
            SizedBox(
                height: 400, width: double.infinity, child: HeroCarousel()),

            // Featured Collection #1 Section (driven from home_config.json)
            FutureBuilder<HomeData?>(
              future: HomeRepository(
                collectionRepo: AssetCollectionRepository(),
                productRepo: AssetProductRepository(),
              ).load(),
              builder: (context, snapshot) {
                final home = snapshot.data;
                if (home == null || home.featured.isEmpty) {
                  // fallback: show same placeholders while loading or if no data
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        const Text('Featured Collection',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        const SizedBox(height: 16),
                        Row(children: [
                          Expanded(
                              child: SizedBox(
                            height: 190,
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              clipBehavior: Clip.antiAlias,
                              child: ProductCard(
                                  title: 'Sample Product',
                                  price: '£20.00',
                                  imageUrl: 'https://via.placeholder.com/150'),
                            ),
                          )),
                          const SizedBox(width: 20),
                          Expanded(
                              child: SizedBox(
                            height: 190,
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              clipBehavior: Clip.antiAlias,
                              child: ProductCard(
                                  title: 'Sample Product',
                                  price: '£20.00',
                                  originalPrice: '£25.00',
                                  imageUrl: 'https://via.placeholder.com/150'),
                            ),
                          ))
                        ])
                      ],
                    ),
                  );
                }

                // Use the first featured collection from the config
                final first = home.featured.entries.first;
                final collection = first.key;
                final products = first.value;

                return Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(collection.title,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 190,
                                child: products.isNotEmpty
                                    ? Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        clipBehavior: Clip.antiAlias,
                                        child: ProductCard(
                                          title: products[0].title,
                                          price: penceToPounds(products[0]
                                                      .discount &&
                                                  products[0].discountedPrice !=
                                                      null
                                              ? products[0].discountedPrice!
                                              : products[0].price),
                                          originalPrice: products[0].discount &&
                                                  products[0].discountedPrice !=
                                                      null
                                              ? penceToPounds(products[0].price)
                                              : null,
                                          imageUrl: products[0].imageUrl,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                            const SizedBox(width: 32),
                            Expanded(
                              child: SizedBox(
                                height: 190,
                                child: products.length > 1
                                    ? Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        clipBehavior: Clip.antiAlias,
                                        child: ProductCard(
                                          title: products[1].title,
                                          price: penceToPounds(products[1]
                                                      .discount &&
                                                  products[1].discountedPrice !=
                                                      null
                                              ? products[1].discountedPrice!
                                              : products[1].price),
                                          originalPrice: products[1].discount &&
                                                  products[1].discountedPrice !=
                                                      null
                                              ? penceToPounds(products[1].price)
                                              : null,
                                          imageUrl: products[1].imageUrl,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
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
          // Image area: extracted to a reusable widget
          ProductImageArea(imageUrl: imageUrl),
          // Info area: extracted to a reusable widget
          ProductInfoArea(
            title: title,
            price: price,
            originalPrice: originalPrice,
          ),
        ],
      ),
    );
  }
}
