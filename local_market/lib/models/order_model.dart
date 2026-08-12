import 'cart_item_model.dart';

enum OrderType { visitShop, homeDelivery }

enum OrderStatus {
  pending,
  accepted,
  preparing,
  ready,
  outForDelivery,
  delivered,
  collected,
  cancelled,
  rejected,
}

/// Order Entity Model for Local Market
class OrderModel {
  final String id;
  final String buyerId;
  final String shopId;
  final String shopName;
  final List<CartItemModel> items;
  final OrderType orderType;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final OrderStatus status;
  final String paymentMethod;
  final String? deliveryAddress;
  final double? deliveryLatitude;
  final double? deliveryLongitude;
  final DateTime createdAt;

  const OrderModel({
    required this.id,
    required this.buyerId,
    required this.shopId,
    required this.shopName,
    this.items = const [],
    required this.orderType,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.status,
    this.paymentMethod = 'Pay at Shop / Cash on Delivery (COD)',
    this.deliveryAddress,
    this.deliveryLatitude,
    this.deliveryLongitude,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'buyer_id': buyerId,
      'shop_id': shopId,
      'shop_name': shopName,
      'items': items.map((i) => i.toJson()).toList(),
      'order_type': orderType.name,
      'subtotal': subtotal,
      'delivery_fee': deliveryFee,
      'total': total,
      'status': status.name,
      'payment_method': paymentMethod,
      'delivery_address': deliveryAddress,
      'delivery_latitude': deliveryLatitude,
      'delivery_longitude': deliveryLongitude,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      buyerId: json['buyer_id'] as String,
      shopId: json['shop_id'] as String,
      shopName: json['shop_name'] as String? ?? 'Local Shop',
      items:
          (json['items'] as List<dynamic>?)
              ?.map((i) => CartItemModel.fromJson(i as Map<String, dynamic>))
              .toList() ??
          const [],
      orderType: OrderType.values.byName(json['order_type'] as String),
      subtotal: (json['subtotal'] as num).toDouble(),
      deliveryFee: (json['delivery_fee'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      status: OrderStatus.values.byName(json['status'] as String),
      paymentMethod:
          json['payment_method'] as String? ??
          'Pay at Shop / Cash on Delivery (COD)',
      deliveryAddress: json['delivery_address'] as String?,
      deliveryLatitude: (json['delivery_latitude'] as num?)?.toDouble(),
      deliveryLongitude: (json['delivery_longitude'] as num?)?.toDouble(),
      createdAt: DateTime.parse(
        json['created_at'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}
