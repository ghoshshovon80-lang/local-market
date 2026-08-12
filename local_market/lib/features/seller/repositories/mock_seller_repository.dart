import 'package:flutter/foundation.dart';
import '../../../models/cart_item_model.dart';
import '../../../models/order_model.dart';
import '../../../models/product_model.dart';
import '../../../models/shop_model.dart';
import 'seller_repository.dart';

class MockSellerRepository extends ChangeNotifier implements SellerRepository {
  static final MockSellerRepository instance = MockSellerRepository._internal();

  MockSellerRepository._internal() {
    _initDefaults();
  }

  ShopModel? _currentShop;
  final List<ProductModel> _sellerProducts = [];
  final List<OrderModel> _sellerOrders = [];

  ShopModel? get currentShop => _currentShop;
  List<ProductModel> get products => List.unmodifiable(_sellerProducts);
  List<OrderModel> get orders => List.unmodifiable(_sellerOrders);

  void _initDefaults() {
    _currentShop = ShopModel(
      id: 'LM-SHOP-847291',
      ownerId: 'owner_seller_1',
      shopName: 'Rahman Grocery Store',
      category: 'Grocery & Staples',
      address: 'Station Road, Beldanga Market Area',
      latitude: 23.9318,
      longitude: 88.2514,
      phone: '+91 9876543210',
      openingTime: '07:00 AM',
      closingTime: '09:00 PM',
      deliveryEnabled: true,
      deliveryFee: 10.0,
      verified: true,
      createdAt: DateTime.now(),
    );

    _sellerProducts.addAll([
      ProductModel(
        id: 'prod_seller_1',
        shopId: 'LM-SHOP-847291',
        name: 'Fresh Desi Tomatoes',
        price: 35.0,
        unit: 'kg',
        stockQuantity: 50,
        category: 'Fresh Vegetables',
        description: 'Locally farmed fresh red tomatoes.',
        imageUrl: '',
        available: true,
        createdAt: DateTime.now(),
      ),
      ProductModel(
        id: 'prod_seller_2',
        shopId: 'LM-SHOP-847291',
        name: 'Fortune Sunflower Oil 1L',
        price: 135.0,
        unit: 'pouch',
        stockQuantity: 20,
        category: 'Grocery & Staples',
        description: 'Refined sunflower cooking oil.',
        imageUrl: '',
        available: true,
        createdAt: DateTime.now(),
      ),
    ]);

    _sellerOrders.addAll([
      OrderModel(
        id: 'LM-ORD-77821',
        buyerId: 'buyer_10',
        shopId: 'LM-SHOP-847291',
        shopName: 'Rahman Grocery Store',
        items: [
          CartItemModel(
            product: _sellerProducts.first,
            quantity: 2,
            shopId: 'LM-SHOP-847291',
          ),
        ],
        orderType: OrderType.homeDelivery,
        subtotal: 70.0,
        deliveryFee: 10.0,
        total: 80.0,
        status: OrderStatus.pending,
        paymentMethod: 'Cash on Delivery (COD)',
        deliveryAddress: 'Beldanga Station Road',
        createdAt: DateTime.now().subtract(const Duration(minutes: 25)),
      ),
    ]);
  }

  @override
  Future<ShopModel?> getSellerShop() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _currentShop;
  }

  @override
  Future<ShopModel> saveShopProfile(ShopModel shop) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentShop = shop;
    notifyListeners();
    return _currentShop!;
  }

  @override
  Future<void> toggleShopOpenStatus(bool isOpen) async {
    if (_currentShop == null) return;
    // Update shop state
    notifyListeners();
  }

  @override
  Future<List<ProductModel>> getSellerProducts() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.unmodifiable(_sellerProducts);
  }

  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _sellerProducts.add(product);
    notifyListeners();
    return product;
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _sellerProducts.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _sellerProducts[index] = product;
      notifyListeners();
    }
    return product;
  }

  @override
  Future<void> deleteProduct(String productId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _sellerProducts.removeWhere((p) => p.id == productId);
    notifyListeners();
  }

  @override
  Future<void> toggleProductAvailability(
    String productId,
    bool available,
  ) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _sellerProducts.indexWhere((p) => p.id == productId);
    if (index >= 0) {
      final p = _sellerProducts[index];
      _sellerProducts[index] = ProductModel(
        id: p.id,
        shopId: p.shopId,
        name: p.name,
        price: p.price,
        unit: p.unit,
        stockQuantity: p.stockQuantity,
        category: p.category,
        description: p.description,
        imageUrl: p.imageUrl,
        available: available,
        createdAt: p.createdAt,
      );
      notifyListeners();
    }
  }

  @override
  Future<List<OrderModel>> getSellerOrders() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.unmodifiable(_sellerOrders);
  }

  @override
  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _sellerOrders.indexWhere((o) => o.id == orderId);
    if (index >= 0) {
      final o = _sellerOrders[index];
      _sellerOrders[index] = OrderModel(
        id: o.id,
        buyerId: o.buyerId,
        shopId: o.shopId,
        shopName: o.shopName,
        items: o.items,
        orderType: o.orderType,
        subtotal: o.subtotal,
        deliveryFee: o.deliveryFee,
        total: o.total,
        status: newStatus,
        paymentMethod: o.paymentMethod,
        deliveryAddress: o.deliveryAddress,
        createdAt: o.createdAt,
      );
      notifyListeners();
    }
  }
}
