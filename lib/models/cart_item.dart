class CartItem {
  final String productId;
  final String name;
  final double price;
  final String image;
  final Map<String, String> options;
  int quantity;
  final String id;

  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    required this.options,
    required this.quantity,
    String? id,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        productId: json['productId'].toString(),
        name: json['name'] ?? '',
        price: (json['price'] as num).toDouble(),
        image: json['image'] ?? '',
        options: Map<String, String>.from(json['options'] ?? {}),
        quantity: json['quantity'] ?? 1,
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        'price': price,
        'image': image,
        'options': options,
        'quantity': quantity,
        'id': id,
      };
}
