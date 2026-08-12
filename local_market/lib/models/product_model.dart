/// Product Entity Model for Local Market
class ProductModel {
  final String id;
  final String shopId;
  final String name;
  final double price;
  final String unit; // e.g. kg, piece, packet
  final int stockQuantity;
  final String category;
  final String description;
  final String imageUrl;
  final bool available;
  final DateTime createdAt;

  const ProductModel({
    required this.id,
    required this.shopId,
    required this.name,
    required this.price,
    required this.unit,
    required this.stockQuantity,
    required this.category,
    required this.description,
    required this.imageUrl,
    this.available = true,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shop_id': shopId,
      'name': name,
      'price': price,
      'unit': unit,
      'stock_quantity': stockQuantity,
      'category': category,
      'description': description,
      'image_url': imageUrl,
      'available': available,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      shopId: json['shop_id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      unit: json['unit'] as String,
      stockQuantity: json['stock_quantity'] as int,
      category: json['category'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      available: json['available'] as bool? ?? true,
      createdAt: DateTime.parse(
        json['created_at'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}
