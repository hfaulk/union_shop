import 'package:flutter/material.dart';
import 'package:union_shop/view_models/cart_view_model.dart';
import 'package:union_shop/views/product_page.dart';
import 'package:union_shop/views/about.dart';
import 'package:union_shop/views/collections.dart';
import 'package:union_shop/views/collection_page.dart';
import 'package:union_shop/views/login.dart';
import 'package:union_shop/views/cart_page.dart';
import 'package:union_shop/views/search_screen.dart';
import 'package:union_shop/views/home_view.dart';
export 'package:union_shop/widgets/product_card.dart';

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
        '/search': (context) => const SearchScreen(),
        '/cart': (context) => const CartPage(),
        '/collections': (context) => const CollectionsPage(),
        '/about': (context) => const AboutPage(),
        '/login': (context) => const LoginPage(),
      },
      onGenerateRoute: (settings) {
        final name = settings.name ?? '';
        // parse as URI to handle any encoded parts
        final uri = Uri.parse(name);
        // match /product/:id -> forward id via settings.arguments for ProductPage
        if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'product') {
          final id = uri.pathSegments[1];
          return MaterialPageRoute(
            settings: RouteSettings(name: name, arguments: {'id': id}),
            builder: (context) => const ProductPage(),
          );
        }
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
