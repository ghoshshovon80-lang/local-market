/// Physical Shop Entity Model for Local Market
class ShopModel {
  final String id;
  final String ownerId;
  final String shopName;
  final String category;
  final String address;
  final double latitude;
  final double longitude;
  final String phone;
  final String openingTime;
  final String closingTime;
  final bool deliveryEnabled;
  final double deliveryFee;
  final bool verified;
  final DateTime createdAt;

  const ShopModel({
    required this.id,
    required this.ownerId,
    required this.shopName,
    required this.category,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phone,
    required this.openingTime,
    required this.closingTime,
    this.deliveryEnabled = true,
    this.deliveryFee = 10.0,
    this.verified = false,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_id': ownerId,
      'shop_name': shopName,
      'category': category,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'phone': phone,
      'opening_time': openingTime,
      'closing_time': closingTime,
      'delivery_enabled': deliveryEnabled,
      'delivery_fee': deliveryFee,
      'verified': verified,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: json['id'] as String,
      ownerId: json['owner_id'] as String,
      shopName: json['shop_name'] as String,
      category: json['category'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      phone: json['phone'] as String,
      openingTime: json['opening_time'] as String,
      closingTime: json['closing_time'] as String,
      deliveryEnabled: json['delivery_enabled'] as bool? ?? true,
      deliveryFee: (json['delivery_fee'] as num?)?.toDouble() ?? 10.0,
      verified: json['verified'] as bool? ?? false,
      createdAt: DateTime.parse(
        json['created_at'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}
