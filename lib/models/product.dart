class Product {
  final String id;
  final String title;
  final int price;
  final String imageUrl;
  final List<String> collections;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.collections = const [],
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

    return Product(
      id: json['id'] as String,
      title: json['title'] as String,
      price: json['price'] as int,
      imageUrl: json['imageUrl'] as String,
      collections: collections,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'imageUrl': imageUrl,
        'collections': collections,
      };
}
