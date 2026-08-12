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
}
