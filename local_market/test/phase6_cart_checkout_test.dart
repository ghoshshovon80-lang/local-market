import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_market/core/services/cart_service.dart';
import 'package:local_market/core/services/order_service.dart';
import 'package:local_market/features/cart/screens/cart_screen.dart';
import 'package:local_market/features/checkout/screens/checkout_screen.dart';
import 'package:local_market/features/orders/screens/order_tracking_screen.dart';
import 'package:local_market/models/cart_item_model.dart';
import 'package:local_market/models/order_model.dart';
import 'package:local_market/models/product_model.dart';
import 'package:local_market/models/shop_model.dart';

void main() {
  final shopA = ShopModel(
    id: 'shop_a',
    ownerId: 'owner_a',
    shopName: 'Shop A Grocery',
    category: 'Grocery',
    address: 'Beldanga Market',
    latitude: 23.9318,
    longitude: 88.2514,
    phone: '9876543210',
    openingTime: '07:00 AM',
    closingTime: '09:00 PM',
    createdAt: DateTime.now(),
  );

  final shopB = ShopModel(
    id: 'shop_b',
    ownerId: 'owner_b',
    shopName: 'Shop B Bakery',
    category: 'Bakery',
    address: 'Station Road',
    latitude: 23.9350,
    longitude: 88.2530,
    phone: '9876543211',
    openingTime: '08:00 AM',
    closingTime: '10:00 PM',
    createdAt: DateTime.now(),
  );

  final prodA = ProductModel(
    id: 'prod_a',
    shopId: 'shop_a',
    name: 'Fresh Tomatoes',
    price: 40.0,
    unit: 'kg',
    stockQuantity: 10,
    category: 'Vegetables',
    description: 'Fresh tomatoes',
    imageUrl: '',
    createdAt: DateTime.now(),
  );

  final prodB = ProductModel(
    id: 'prod_b',
    shopId: 'shop_b',
    name: 'Fresh Bread',
    price: 30.0,
    unit: 'pkt',
    stockQuantity: 5,
    category: 'Bakery',
    description: 'Fresh bread',
    imageUrl: '',
    createdAt: DateTime.now(),
  );

  setUp(() {
    CartService.instance.clearCart();
  });

  test('CartService handles add, quantity updates and calculations', () {
    final cart = CartService.instance;
    expect(cart.isEmpty, isTrue);

    // Add 2x Prod A
    final res = cart.addToCart(prodA, shopA, quantity: 2);
    expect(res.status, AddToCartStatus.success);
    expect(cart.totalQuantity, 2);
    expect(cart.subtotal, 80.0);
    expect(cart.deliveryFee, 10.0);
    expect(cart.grandTotal, 90.0);

    // Update quantity by +1
    cart.updateQuantity(prodA.id, 1);
    expect(cart.totalQuantity, 3);
    expect(cart.subtotal, 120.0);

    // Change fulfillment to Store Pickup
    cart.setFulfillmentType(OrderType.visitShop);
    expect(cart.deliveryFee, 0.0);
    expect(cart.grandTotal, 120.0);
  });

  test('CartService enforces multi-shop cart rule', () {
    final cart = CartService.instance;
    cart.addToCart(prodA, shopA);

    // Attempt to add prodB from shopB
    final res = cart.addToCart(prodB, shopB);
    expect(res.status, AddToCartStatus.differentShopConflict);
    expect(res.existingShopName, 'Shop A Grocery');

    // Confirm clear and add
    cart.confirmClearAndAdd(prodB, shopB);
    expect(cart.currentShop!.id, 'shop_b');
    expect(cart.items.first.product.id, 'prod_b');
  });

  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      routes: {'/checkout': (context) => const CheckoutScreen()},
      home: child,
    );
  }

  testWidgets('CartScreen displays empty state when cart is empty', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget(const CartScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Your cart is empty'), findsOneWidget);
    expect(find.text('Explore Local Shops'), findsOneWidget);
  });

  testWidgets('CartScreen displays items and totals when cart has items', (
    WidgetTester tester,
  ) async {
    CartService.instance.addToCart(prodA, shopA, quantity: 2);

    await tester.pumpWidget(buildTestableWidget(const CartScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Shop A Grocery'), findsOneWidget);
    expect(find.text('Fresh Tomatoes'), findsOneWidget);
    expect(find.textContaining('Proceed to Checkout'), findsOneWidget);
  });

  testWidgets('OrderTrackingScreen displays placed orders from OrderService', (
    WidgetTester tester,
  ) async {
    final testOrder = OrderModel(
      id: 'LM-ORD-999',
      buyerId: 'buyer_1',
      shopId: 'shop_a',
      shopName: 'Shop A Grocery',
      items: [CartItemModel(product: prodA, quantity: 1, shopId: 'shop_a')],
      orderType: OrderType.homeDelivery,
      subtotal: 40.0,
      deliveryFee: 10.0,
      total: 50.0,
      status: OrderStatus.pending,
      createdAt: DateTime.now(),
    );

    OrderService.instance.addOrder(testOrder);

    await tester.pumpWidget(buildTestableWidget(const OrderTrackingScreen()));
    await tester.pumpAndSettle();

    expect(find.text('LM-ORD-999'), findsOneWidget);
    expect(find.text('Shop: Shop A Grocery'), findsOneWidget);
    expect(find.text('Pending'), findsOneWidget);
  });
}
