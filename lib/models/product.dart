class Product {
  final String id;
  final String title;
  final int price;
  final String imageUrl;
  final List<String> collections;
  // Optional discount fields: when `discount` is true and `discountedPrice` is set (in pence),
  // UI should show the original price struck-through and the discounted price prominently.
  final bool discount;
  final int? discountedPrice;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.collections = const [],
    this.discount = false,
    this.discountedPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final rawCollections = json['collections'];
    List<String> collections = const [];
    if (rawCollections is List) {
      collections = rawCollections
          .map((e) => e?.toString() ?? '')
          .where((s) => s.isNotEmpty)
          .toList();
    }
    // Read optional discount fields
    final discountFlag = json['discount'] == true;
    int? discounted;
    if (json['discountedPrice'] is int) {
      discounted = json['discountedPrice'] as int;
    }

    return Product(
      id: json['id'] as String,
      title: json['title'] as String,
      price: json['price'] as int,
      imageUrl: json['imageUrl'] as String,
      collections: collections,
      discount: discountFlag,
      discountedPrice: discounted,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'imageUrl': imageUrl,
        'collections': collections,
        if (discount) 'discount': true,
        if (discountedPrice != null) 'discountedPrice': discountedPrice,
      };
}
