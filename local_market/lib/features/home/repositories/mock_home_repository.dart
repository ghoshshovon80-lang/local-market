import '../../../models/product_model.dart';
import '../../../models/shop_model.dart';
import 'home_repository.dart';

class MockHomeRepository implements HomeRepository {
  @override
  Future<List<CategoryItem>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      CategoryItem(
        id: 'cat_1',
        title: 'Grocery & Staples',
        iconName: 'shopping_bag',
      ),
      CategoryItem(id: 'cat_2', title: 'Fresh Vegetables', iconName: 'eco'),
      CategoryItem(id: 'cat_3', title: 'Fruits', iconName: 'apple'),
      CategoryItem(id: 'cat_4', title: 'Dairy & Eggs', iconName: 'egg'),
      CategoryItem(
        id: 'cat_5',
        title: 'Bakery & Snacks',
        iconName: 'bakery_dining',
      ),
      CategoryItem(id: 'cat_6', title: 'Fish & Meat', iconName: 'set_meal'),
      CategoryItem(
        id: 'cat_7',
        title: 'Personal Care',
        iconName: 'clean_hands',
      ),
    ];
  }

  @override
  Future<List<ShopModel>> getNearbyShops({required String locationName}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      ShopModel(
        id: 'shop_1',
        ownerId: 'owner_1',
        shopName: 'ABC Grocery Store',
        category: 'Grocery & Staples',
        address: '$locationName Main Market',
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
        address: 'Station Road, $locationName',
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
      ShopModel(
        id: 'shop_3',
        ownerId: 'owner_3',
        shopName: 'Subho Sweet & Bakery',
        category: 'Bakery & Snacks',
        address: 'Bus Stand, $locationName',
        latitude: 23.9380,
        longitude: 88.2550,
        phone: '+91 9876543212',
        openingTime: '08:00 AM',
        closingTime: '10:00 PM',
        deliveryEnabled: true,
        deliveryFee: 10.0,
        verified: false,
        createdAt: DateTime.now(),
      ),
    ];
  }

  @override
  Future<List<ProductModel>> getNearbyProducts({
    required String locationName,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      ProductModel(
        id: 'prod_1',
        shopId: 'shop_1',
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
        id: 'prod_2',
        shopId: 'shop_2',
        name: 'Minikit White Rice',
        price: 52.0,
        unit: 'kg',
        stockQuantity: 100,
        category: 'Grocery & Staples',
        description: 'Premium quality white rice.',
        imageUrl: '',
        available: true,
        createdAt: DateTime.now(),
      ),
      ProductModel(
        id: 'prod_3',
        shopId: 'shop_1',
        name: 'Amul Taaza Milk 500ml',
        price: 28.0,
        unit: 'pkt',
        stockQuantity: 30,
        category: 'Dairy & Eggs',
        description: 'Fresh toned milk packet.',
        imageUrl: '',
        available: true,
        createdAt: DateTime.now(),
      ),
      ProductModel(
        id: 'prod_4',
        shopId: 'shop_3',
        name: 'Fresh Farm Eggs (6 pcs)',
        price: 42.0,
        unit: 'pack',
        stockQuantity: 20,
        category: 'Dairy & Eggs',
        description: 'Nutritious farm fresh brown eggs.',
        imageUrl: '',
        available: true,
        createdAt: DateTime.now(),
      ),
    ];
  }
}
