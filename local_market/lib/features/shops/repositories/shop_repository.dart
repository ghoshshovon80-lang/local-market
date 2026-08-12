import '../../../models/product_model.dart';
import '../../../models/shop_model.dart';

abstract class ShopRepository {
  Future<ShopModel?> getShopById(String shopId);
  Future<List<ProductModel>> getShopProducts(String shopId);
}
