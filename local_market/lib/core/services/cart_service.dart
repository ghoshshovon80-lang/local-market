import 'package:flutter/foundation.dart';
import '../constants/app_constants.dart';
import '../../models/cart_item_model.dart';
import '../../models/order_model.dart';
import '../../models/product_model.dart';
import '../../models/shop_model.dart';

enum AddToCartStatus { success, differentShopConflict }

class AddToCartResult {
  final AddToCartStatus status;
  final String? existingShopName;

  const AddToCartResult._(this.status, this.existingShopName);

  factory AddToCartResult.success() =>
      const AddToCartResult._(AddToCartStatus.success, null);

  factory AddToCartResult.differentShop(String existingShopName) =>
      AddToCartResult._(
        AddToCartStatus.differentShopConflict,
        existingShopName,
      );
}

/// Centralized Persistent Cart Service (ChangeNotifier)
class CartService extends ChangeNotifier {
  static final CartService instance = CartService._internal();

  CartService._internal();

  final List<CartItemModel> _items = [];
  ShopModel? _currentShop;
  OrderType _selectedFulfillment = OrderType.homeDelivery;

  List<CartItemModel> get items => List.unmodifiable(_items);
  ShopModel? get currentShop => _currentShop;
  OrderType get selectedFulfillment => _selectedFulfillment;

  int get totalQuantity => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.subtotal);

  double get deliveryFee => _selectedFulfillment == OrderType.homeDelivery
      ? (_currentShop?.deliveryFee ?? AppConstants.defaultDeliveryFee)
      : 0.0;

  double get grandTotal => subtotal + deliveryFee;

  bool get isEmpty => _items.isEmpty;

  void setFulfillmentType(OrderType type) {
    _selectedFulfillment = type;
    notifyListeners();
  }

  AddToCartResult addToCart(
    ProductModel product,
    ShopModel shop, {
    int quantity = 1,
  }) {
    if (_items.isNotEmpty &&
        _currentShop != null &&
        _currentShop!.id != shop.id) {
      return AddToCartResult.differentShop(_currentShop!.shopName);
    }

    if (_items.isEmpty) {
      _currentShop = shop;
    }

    final index = _items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      final existing = _items[index];
      _items[index] = existing.copyWith(quantity: existing.quantity + quantity);
    } else {
      _items.add(
        CartItemModel(product: product, quantity: quantity, shopId: shop.id),
      );
    }

    notifyListeners();
    return AddToCartResult.success();
  }

  void confirmClearAndAdd(
    ProductModel product,
    ShopModel shop, {
    int quantity = 1,
  }) {
    clearCart();
    _currentShop = shop;
    _items.add(
      CartItemModel(product: product, quantity: quantity, shopId: shop.id),
    );
    notifyListeners();
  }

  void updateQuantity(String productId, int delta) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index < 0) return;

    final existing = _items[index];
    final newQuantity = existing.quantity + delta;

    if (newQuantity <= 0) {
      _items.removeAt(index);
    } else {
      _items[index] = existing.copyWith(quantity: newQuantity);
    }

    if (_items.isEmpty) {
      _currentShop = null;
    }

    notifyListeners();
  }

  void removeFromCart(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    if (_items.isEmpty) {
      _currentShop = null;
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    _currentShop = null;
    notifyListeners();
  }
}
