import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/product_model.dart';

class FirestoreProductRepository {
  final FirebaseFirestore _firestore;

  FirestoreProductRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _productsRef =>
      _firestore.collection('products');

  Future<void> addProduct(ProductModel product) async {
    await _productsRef.doc(product.id).set(product.toJson());
  }

  Future<void> updateProduct(ProductModel product) async {
    await _productsRef.doc(product.id).update(product.toJson());
  }

  Future<void> deleteProduct(String productId) async {
    await _productsRef.doc(productId).delete();
  }

  Future<List<ProductModel>> getProductsByShop(String shopId) async {
    final query = await _productsRef.where('shop_id', isEqualTo: shopId).get();
    return query.docs.map((doc) => ProductModel.fromJson(doc.data())).toList();
  }

  Future<List<ProductModel>> getNearbyProducts() async {
    final query = await _productsRef.limit(30).get();
    return query.docs.map((doc) => ProductModel.fromJson(doc.data())).toList();
  }
}
