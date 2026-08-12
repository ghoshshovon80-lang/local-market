import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/order_model.dart';

class FirestoreOrderRepository {
  final FirebaseFirestore _firestore;

  FirestoreOrderRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _ordersRef =>
      _firestore.collection('orders');

  Future<void> createOrder(OrderModel order) async {
    await _ordersRef.doc(order.id).set(order.toJson());
  }

  Future<List<OrderModel>> getOrdersByBuyer(String buyerId) async {
    final query = await _ordersRef.where('buyer_id', isEqualTo: buyerId).get();
    return query.docs.map((doc) => OrderModel.fromJson(doc.data())).toList();
  }

  Future<List<OrderModel>> getOrdersByShop(String shopId) async {
    final query = await _ordersRef.where('shop_id', isEqualTo: shopId).get();
    return query.docs.map((doc) => OrderModel.fromJson(doc.data())).toList();
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    await _ordersRef.doc(orderId).update({'status': status.name});
  }
}
