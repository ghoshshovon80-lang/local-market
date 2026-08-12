import 'package:flutter_test/flutter_test.dart';
import 'package:local_market/core/services/firebase_service.dart';
import 'package:local_market/models/cart_item_model.dart';
import 'package:local_market/models/order_model.dart';
import 'package:local_market/models/product_model.dart';
import 'package:local_market/models/shop_model.dart';

void main() {
  test('ShopModel serialization for Firestore matches schema', () {
    final shop = ShopModel(
      id: 'LM-SHOP-123456',
      ownerId: 'owner_1',
      shopName: 'Test Market Shop',
      category: 'Grocery',
      address: 'Main Market, Beldanga',
      latitude: 23.9318,
      longitude: 88.2514,
      phone: '9876543210',
      openingTime: '07:00 AM',
      closingTime: '09:00 PM',
      deliveryEnabled: true,
      deliveryFee: 10.0,
      verified: true,
      createdAt: DateTime.parse('2026-08-12T12:00:00.000Z'),
    );

    final json = shop.toJson();
    expect(json['id'], 'LM-SHOP-123456');
    expect(json['shop_name'], 'Test Market Shop');
    expect(json['latitude'], 23.9318);

    final deserialized = ShopModel.fromJson(json);
    expect(deserialized.id, shop.id);
    expect(deserialized.shopName, shop.shopName);
  });

  test('ProductModel serialization for Firestore matches schema', () {
    final prod = ProductModel(
      id: 'prod_101',
      shopId: 'LM-SHOP-123456',
      name: 'Fresh Tomatoes',
      price: 40.0,
      unit: 'kg',
      stockQuantity: 25,
      category: 'Vegetables',
      description: 'Fresh red tomatoes',
      imageUrl: 'https://example.com/tomato.jpg',
      available: true,
      createdAt: DateTime.parse('2026-08-12T12:00:00.000Z'),
    );

    final json = prod.toJson();
    expect(json['id'], 'prod_101');
    expect(json['price'], 40.0);

    final deserialized = ProductModel.fromJson(json);
    expect(deserialized.name, prod.name);
    expect(deserialized.imageUrl, prod.imageUrl);
  });

  test(
    'OrderModel and CartItemModel serialization for Firestore matches schema',
    () {
      final prod = ProductModel(
        id: 'prod_101',
        shopId: 'LM-SHOP-123456',
        name: 'Fresh Tomatoes',
        price: 40.0,
        unit: 'kg',
        stockQuantity: 25,
        category: 'Vegetables',
        description: 'Fresh red tomatoes',
        imageUrl: 'https://example.com/tomato.jpg',
        available: true,
        createdAt: DateTime.parse('2026-08-12T12:00:00.000Z'),
      );

      final order = OrderModel(
        id: 'LM-ORD-555',
        buyerId: 'buyer_1',
        shopId: 'LM-SHOP-123456',
        shopName: 'Test Market Shop',
        items: [
          CartItemModel(product: prod, quantity: 2, shopId: 'LM-SHOP-123456'),
        ],
        orderType: OrderType.homeDelivery,
        subtotal: 80.0,
        deliveryFee: 10.0,
        total: 90.0,
        status: OrderStatus.pending,
        paymentMethod: 'Cash on Delivery (COD)',
        deliveryAddress: 'Beldanga Station Road',
        createdAt: DateTime.parse('2026-08-12T12:00:00.000Z'),
      );

      final json = order.toJson();
      expect(json['id'], 'LM-ORD-555');
      expect(json['items'], isA<List>());
      expect((json['items'] as List).first['quantity'], 2);

      final deserialized = OrderModel.fromJson(json);
      expect(deserialized.id, order.id);
      expect(deserialized.items.first.product.name, 'Fresh Tomatoes');
    },
  );

  test(
    'FirebaseService provides safe fallback when uninitialized in tests',
    () {
      final service = FirebaseService.instance;
      expect(service.isInitialized, isFalse);
      expect(service.firestore, isNull);
      expect(service.storage, isNull);
      expect(AppConfig.useFirebase, isFalse);
    },
  );
}
