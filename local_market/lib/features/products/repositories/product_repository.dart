import '../../../models/product_model.dart';
import '../../../models/shop_model.dart';

abstract class ProductRepository {
  Future<ProductModel?> getProductById(String productId);
  Future<ShopModel?> getShopForProduct(String shopId);
}
