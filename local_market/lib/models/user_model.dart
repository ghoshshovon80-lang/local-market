enum UserRole { buyer, seller }

/// User Profile Entity Model for Local Market
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? phone;
  final UserRole role;
  final String? address;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.phone,
    required this.role,
    this.address,
    this.latitude,
    this.longitude,
    required this.createdAt,
  });

  bool get isSeller => role == UserRole.seller;
  bool get isBuyer => role == UserRole.buyer;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role.name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String? ?? 'Local User',
      email: map['email'] as String? ?? '',
      phone: map['phone'] as String?,
      role: UserRole.values.byName(map['role'] as String? ?? 'buyer'),
      address: map['address'] as String?,
      latitude: (map['latitude'] as num?)?.toDouble(),
      longitude: (map['longitude'] as num?)?.toDouble(),
      createdAt: DateTime.parse(
        map['created_at'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() => toMap();
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel.fromMap(json);
}
