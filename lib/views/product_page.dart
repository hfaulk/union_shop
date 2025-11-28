import 'package:flutter/material.dart';
import 'package:union_shop/widgets/shared_layout.dart';
import 'package:union_shop/view_models/cart_view_model.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/repositories/product_repository.dart';
// kept minimal: no repository/model imports required for now

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _quantity = 1;
  final int _maxQuantity = 10;
  final int _minQuantity = 1;
  String _selectedColor = 'Black';
  String _selectedSize = 'S';
  Product? _loadedProduct;
  bool _isLoadingProduct = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loadedProduct != null || _isLoadingProduct) return;
    final args = ModalRoute.of(context)?.settings.arguments;
    final argMap = (args is Map) ? args as Map<String, dynamic> : null;
    final id = argMap?['id'] as String?;
    if (id != null) {
      _isLoadingProduct = true;
      AssetProductRepository().fetchById(id).then((p) {
        if (p != null) setState(() => _loadedProduct = p);
      }).whenComplete(() => _isLoadingProduct = false);
    }
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    // Read minimal product fields from route arguments (if provided)
    final args = ModalRoute.of(context)?.settings.arguments;
    final argMap = (args is Map) ? args as Map<String, dynamic> : null;
    final passedTitle = argMap?['title'] as String? ?? _loadedProduct?.title;
    final passedImage =
        argMap?['imageUrl'] as String? ?? _loadedProduct?.imageUrl;
    final passedPriceRaw = argMap?['price'] ?? _loadedProduct?.price;

    String priceText = '£15.00';
    if (passedPriceRaw != null) {
      if (passedPriceRaw is int) {
        priceText = '£${(passedPriceRaw / 100).toStringAsFixed(2)}';
      } else if (passedPriceRaw is String) {
        priceText = passedPriceRaw;
      }
    }

    final passedDiscount =
        (argMap?['discount'] == true) || (_loadedProduct?.discount == true);
    final passedDiscountedRaw =
        argMap?['discountedPrice'] ?? _loadedProduct?.discountedPrice;
    String? discountedText;
    if (passedDiscountedRaw != null) {
      if (passedDiscountedRaw is int) {
        discountedText = '£${(passedDiscountedRaw / 100).toStringAsFixed(2)}';
      } else if (passedDiscountedRaw is String) {
        discountedText = passedDiscountedRaw;
      }
    }

    // Minimal: render using the passed-in fields only (keeps diff small)
    return SharedLayout(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        passedImage ??
                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.image_not_supported,
                                  size: 64, color: Colors.grey),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    passedTitle ?? 'Placeholder Product Name',
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 12),
                  // Show discounted pricing if available
                  passedDiscount && discountedText != null
                      ? Row(
                          children: [
                            Text(
                              priceText,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color(0xFF9E9E9E),
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              discountedText,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4d2963),
                              ),
                            ),
                          ],
                        )
                      : Text(
                          priceText,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4d2963)),
                        ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tax included.',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  const Text('Color',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedColor,
                    items: ['Black', 'White']
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => _selectedColor = v ?? 'Black'),
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Size',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _selectedSize,
                          items: ['S', 'M', 'L']
                              .map((s) =>
                                  DropdownMenuItem(value: s, child: Text(s)))
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _selectedSize = v ?? 'S'),
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 14),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 112,
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: _quantity > _minQuantity
                                    ? () => setState(() => _quantity--)
                                    : null,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                    minWidth: 36, minHeight: 36),
                              ),
                              Text('$_quantity',
                                  style: const TextStyle(fontSize: 16)),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: _quantity < _maxQuantity
                                    ? () => setState(() => _quantity++)
                                    : null,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                    minWidth: 36, minHeight: 36),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        final vm = appCartViewModel;
                        if (vm == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Cart not ready')));
                          return;
                        }
                        final price =
                            double.tryParse(priceText.replaceAll('£', '')) ??
                                0.0;
                        // Prefer discounted value if present
                        double finalPrice = price;
                        if (passedDiscount && passedDiscountedRaw != null) {
                          if (passedDiscountedRaw is int) {
                            finalPrice = passedDiscountedRaw / 100.0;
                          } else if (passedDiscountedRaw is String) {
                            finalPrice = double.tryParse(
                                    passedDiscountedRaw.replaceAll('£', '')) ??
                                price;
                          }
                        }
                        final item = CartItem(
                          productId: (argMap?['id'] ??
                                  DateTime.now().millisecondsSinceEpoch)
                              .toString(),
                          name: passedTitle ?? 'Product',
                          price: finalPrice,
                          image: passedImage ?? '',
                          options: {
                            'size': _selectedSize,
                            'color': _selectedColor
                          },
                          quantity: _quantity,
                        );
                        vm.addItem(item);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to cart')));
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Color(0xFF4d2963)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: const Text('ADD TO CART',
                          style: TextStyle(
                              color: Color(0xFF4d2963),
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5B33E1),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: const Text('Buy with shop',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('More payment options',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Description',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                  const SizedBox(height: 8),
                  const Text(
                    'Product Description Please!',
                    style: TextStyle(
                        fontSize: 16, color: Colors.grey, height: 1.5),
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
