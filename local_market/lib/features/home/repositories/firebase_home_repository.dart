import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/product_model.dart';
import '../../../models/shop_model.dart';
import 'home_repository.dart';

class FirebaseHomeRepository implements HomeRepository {
  final FirebaseFirestore _firestore;

  FirebaseHomeRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<CategoryItem>> getCategories() async {
    return const [
      CategoryItem(
        id: 'cat_1',
        title: 'Grocery & Staples',
        iconName: 'local_grocery_store',
      ),
      CategoryItem(
        id: 'cat_2',
        title: 'Fresh Vegetables',
        iconName: 'eco',
      ),
      CategoryItem(
        id: 'cat_3',
        title: 'Dairy & Eggs',
        iconName: 'egg',
      ),
      CategoryItem(
        id: 'cat_4',
        title: 'Bakery & Snacks',
        iconName: 'bakery_dining',
      ),
      CategoryItem(
        id: 'cat_5',
        title: 'Fish & Meat',
        iconName: 'set_meal',
      ),
      CategoryItem(
        id: 'cat_6',
        title: 'Personal Care',
        iconName: 'clean_hands',
      ),
    ];
  }

  @override
  Future<List<ShopModel>> getNearbyShops({required String locationName}) async {
    try {
      final snapshot = await _firestore.collection('shops').limit(20).get();
      return snapshot.docs
          .map((doc) => ShopModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<ProductModel>> getNearbyProducts({
    required String locationName,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('products')
          .where('available', isEqualTo: true)
          .limit(30)
          .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
