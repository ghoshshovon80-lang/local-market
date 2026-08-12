import '../../../models/product_model.dart';
import '../../../models/shop_model.dart';
import 'product_repository.dart';

class MockProductRepository implements ProductRepository {
  final List<ProductModel> _mockProducts = [
    ProductModel(
      id: 'prod_1',
      shopId: 'shop_1',
      name: 'Fresh Desi Tomatoes',
      price: 35.0,
      unit: 'kg',
      stockQuantity: 50,
      category: 'Fresh Vegetables',
      description:
          'Locally farmed fresh red tomatoes sourced daily from Beldanga mandi. Guaranteed farm fresh quality.',
      imageUrl: '',
      available: true,
      createdAt: DateTime.now(),
    ),
    ProductModel(
      id: 'prod_2',
      shopId: 'shop_2',
      name: 'Minikit White Rice',
      price: 52.0,
      unit: 'kg',
      stockQuantity: 100,
      category: 'Grocery & Staples',
      description: 'Premium polished minikit white rice from local rice mills.',
      imageUrl: '',
      available: true,
      createdAt: DateTime.now(),
    ),
  ];

  final List<ShopModel> _mockShops = [
    ShopModel(
      id: 'shop_1',
      ownerId: 'owner_1',
      shopName: 'ABC Grocery Store',
      category: 'Grocery & Staples',
      address: 'Station Road, Beldanga Main Market',
      latitude: 23.9318,
      longitude: 88.2514,
      phone: '+91 9876543210',
      openingTime: '07:00 AM',
      closingTime: '09:00 PM',
      deliveryEnabled: true,
      deliveryFee: 10.0,
      verified: true,
      createdAt: DateTime.now(),
    ),
    ShopModel(
      id: 'shop_2',
      ownerId: 'owner_2',
      shopName: 'Maa Lakshmi Stores',
      category: 'Fresh Vegetables',
      address: 'Station Road, Beldanga',
      latitude: 23.9350,
      longitude: 88.2530,
      phone: '+91 9876543211',
      openingTime: '06:00 AM',
      closingTime: '08:30 PM',
      deliveryEnabled: true,
      deliveryFee: 10.0,
      verified: true,
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Future<ProductModel?> getProductById(String productId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockProducts.firstWhere(
      (p) => p.id == productId,
      orElse: () => _mockProducts.first,
    );
  }

  @override
  Future<ShopModel?> getShopForProduct(String shopId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockShops.firstWhere(
      (s) => s.id == shopId,
      orElse: () => _mockShops.first,
    );
  }
}
