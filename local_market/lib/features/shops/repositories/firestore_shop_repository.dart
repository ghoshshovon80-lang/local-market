import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/shop_model.dart';

class FirestoreShopRepository {
  final FirebaseFirestore _firestore;

  FirestoreShopRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _shopsRef =>
      _firestore.collection('shops');

  Future<void> createOrUpdateShop(ShopModel shop) async {
    await _shopsRef.doc(shop.id).set(shop.toJson(), SetOptions(merge: true));
  }

  Future<ShopModel?> getShopById(String shopId) async {
    final doc = await _shopsRef.doc(shopId).get();
    if (!doc.exists || doc.data() == null) return null;
    return ShopModel.fromJson(doc.data()!);
  }

  Future<List<ShopModel>> getNearbyShops({required String locationName}) async {
    final query = await _shopsRef.limit(20).get();
    return query.docs.map((doc) => ShopModel.fromJson(doc.data())).toList();
  }
}
