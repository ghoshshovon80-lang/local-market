import 'cards/product_card_foundation.dart';
export 'cards/product_card_foundation.dart';

/// ProductCard widget subclassing ProductCardFoundation for Phase 1/Phase 2 compatibility
class ProductCard extends ProductCardFoundation {
  const ProductCard({
    super.key,
    required super.productName,
    required super.price,
    required super.unit,
    required super.shopName,
    required super.distanceText,
    super.isAvailable,
    super.imageWidget,
    super.onTap,
  });
}
