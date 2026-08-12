import 'product_model.dart';

/// Single Cart Item Entity Model
class CartItemModel {
  final ProductModel product;
  final int quantity;
  final String shopId;

  const CartItemModel({
    required this.product,
    required this.quantity,
    required this.shopId,
  });

  double get subtotal => product.price * quantity;

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      product: product,
      quantity: quantity ?? this.quantity,
      shopId: shopId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'shop_id': shopId,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      shopId: json['shop_id'] as String,
    );
  }
}
