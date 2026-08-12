import '../../../models/order_model.dart';
import '../../../models/product_model.dart';
import '../../../models/shop_model.dart';

abstract class SellerRepository {
  Future<ShopModel?> getSellerShop();
  Future<ShopModel> saveShopProfile(ShopModel shop);
  Future<void> toggleShopOpenStatus(bool isOpen);

  Future<List<ProductModel>> getSellerProducts();
  Future<ProductModel> addProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<void> deleteProduct(String productId);
  Future<void> toggleProductAvailability(String productId, bool available);

  Future<List<OrderModel>> getSellerOrders();
  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus);
}
