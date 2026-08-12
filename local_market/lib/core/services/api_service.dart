/// Abstract API/Repository Service Interface for backend data interaction.
abstract class ApiService {
  Future<List<Map<String, dynamic>>> getNearbyShops({
    required double latitude,
    required double longitude,
    double radiusKm = 5.0,
  });

  Future<List<Map<String, dynamic>>> searchProducts(String query);

  Future<Map<String, dynamic>?> getShopDetails(String shopId);

  Future<Map<String, dynamic>?> getProductDetails(String productId);
}
