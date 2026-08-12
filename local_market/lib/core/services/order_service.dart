import 'package:flutter/foundation.dart';
import '../../models/order_model.dart';

/// Centralized Local Order Storage Service (ChangeNotifier)
class OrderService extends ChangeNotifier {
  static final OrderService instance = OrderService._internal();

  OrderService._internal();

  final List<OrderModel> _orders = [];

  List<OrderModel> get orders => List.unmodifiable(_orders);

  void addOrder(OrderModel order) {
    _orders.insert(0, order); // Most recent orders first
    notifyListeners();
  }

  OrderModel? getOrderById(String orderId) {
    try {
      return _orders.firstWhere((o) => o.id == orderId);
    } catch (_) {
      return null;
    }
  }
}
