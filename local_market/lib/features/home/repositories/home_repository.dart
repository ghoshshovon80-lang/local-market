import '../../../models/product_model.dart';
import '../../../models/shop_model.dart';

class CategoryItem {
  final String id;
  final String title;
  final String iconName;

  const CategoryItem({
    required this.id,
    required this.title,
    required this.iconName,
  });
}

abstract class HomeRepository {
  Future<List<CategoryItem>> getCategories();
  Future<List<ShopModel>> getNearbyShops({required String locationName});
  Future<List<ProductModel>> getNearbyProducts({required String locationName});
}
