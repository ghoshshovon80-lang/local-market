import 'cards/shop_card_foundation.dart';
export 'cards/shop_card_foundation.dart';

/// ShopCard widget subclassing ShopCardFoundation for Phase 1/Phase 2 compatibility
class ShopCard extends ShopCardFoundation {
  const ShopCard({
    super.key,
    required super.shopName,
    required super.category,
    required super.distanceText,
    super.isOpen,
    super.isVerified,
    super.deliveryAvailable,
    super.shopImage,
    super.onTap,
  });
}
