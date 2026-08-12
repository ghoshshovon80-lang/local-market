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
  final OrderType orderType;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final OrderStatus status;
  final String? deliveryAddress;
  final double? deliveryLatitude;
  final double? deliveryLongitude;
  final DateTime createdAt;

  const OrderModel({
    required this.id,
    required this.buyerId,
    required this.shopId,
    required this.orderType,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.status,
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
      'order_type': orderType.name,
      'subtotal': subtotal,
      'delivery_fee': deliveryFee,
      'total': total,
      'status': status.name,
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
      orderType: OrderType.values.byName(json['order_type'] as String),
      subtotal: (json['subtotal'] as num).toDouble(),
      deliveryFee: (json['delivery_fee'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      status: OrderStatus.values.byName(json['status'] as String),
      deliveryAddress: json['delivery_address'] as String?,
      deliveryLatitude: (json['delivery_latitude'] as num?)?.toDouble(),
      deliveryLongitude: (json['delivery_longitude'] as num?)?.toDouble(),
      createdAt: DateTime.parse(
        json['created_at'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}
