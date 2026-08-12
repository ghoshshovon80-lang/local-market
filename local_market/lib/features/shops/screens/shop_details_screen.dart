import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/map_navigation_service.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/product_model.dart';
import '../../../models/shop_model.dart';
import '../../../widgets/buttons/outline_button.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/cards/product_card_foundation.dart';
import '../../../widgets/navigation/custom_app_bar.dart';
import '../../../widgets/states/error_state_widget.dart';
import '../../../widgets/states/loading_widget.dart';
import '../../../widgets/status/shop_status_badge.dart';
import '../../../widgets/status/verified_badge.dart';
import '../repositories/mock_shop_repository.dart';
import '../repositories/shop_repository.dart';

class ShopDetailsScreen extends StatefulWidget {
  final String shopId;
  final ShopRepository? repository;
  final MapNavigationService? navigationService;

  const ShopDetailsScreen({
    super.key,
    this.shopId = 'shop_1',
    this.repository,
    this.navigationService,
  });

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  late ShopRepository _repository;
  late MapNavigationService _navigationService;

  bool _isLoading = true;
  ShopModel? _shop;
  List<ProductModel> _products = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _repository = widget.repository ?? MockShopRepository();
    _navigationService = widget.navigationService ?? AppMapNavigationService();
    _loadShopData();
  }

  Future<void> _loadShopData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final shop = await _repository.getShopById(widget.shopId);
      final products = await _repository.getShopProducts(widget.shopId);

      if (!mounted) return;
      setState(() {
        _shop = shop;
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Unable to load shop details. Please try again.';
        _isLoading = false;
      });
    }
  }

  void _onGetDirectionsPressed() {
    if (_shop != null) {
      _navigationService.openDirections(
        latitude: _shop!.latitude,
        longitude: _shop!.longitude,
        shopName: _shop!.shopName,
      );
    }
  }

  void _onCallShopPressed() {
    if (_shop != null) {
      _navigationService.makePhoneCall(phoneNumber: _shop!.phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: _shop?.shopName ?? 'Shop Details',
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingWidget(message: 'Loading shop details...');
    }

    if (_error != null || _shop == null) {
      return ErrorStateWidget(
        title: 'Shop Error',
        errorMessage: _error ?? 'Shop not found.',
        onRetry: _loadShopData,
      );
    }

    final shop = _shop!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shop Banner Container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppSpacing.borderRadiusLg,
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: AppSpacing.borderRadiusMd,
                      ),
                      child: const Icon(
                        Icons.storefront,
                        size: 36,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  shop.shopName,
                                  style: AppTypography.screenTitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (shop.verified) ...[
                                const SizedBox(width: AppSpacing.xs),
                                const VerifiedBadge(size: 20),
                              ],
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(shop.category, style: AppTypography.bodyMuted),
                          const SizedBox(height: AppSpacing.sm),
                          ShopStatusBadge(isOpen: true),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                const Divider(),
                const SizedBox(height: AppSpacing.sm),

                // Location & Hours Info
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: AppSpacing.iconMd,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(shop.address, style: AppTypography.body),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: AppSpacing.iconMd,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      'Hours: ${shop.openingTime} - ${shop.closingTime}',
                      style: AppTypography.caption,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    const Icon(
                      Icons.delivery_dining,
                      size: AppSpacing.iconMd,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      'Home Delivery Available (₹${shop.deliveryFee.toStringAsFixed(0)})',
                      style: AppTypography.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                // Actions: Get Directions & Call Shop
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        text: 'Get Directions',
                        icon: Icons.directions_outlined,
                        onPressed: _onGetDirectionsPressed,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: AppOutlineButton(
                        text: 'Call Shop',
                        icon: Icons.phone_outlined,
                        onPressed: _onCallShopPressed,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Products Available in Shop Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Shop Products', style: AppTypography.sectionTitle),
              Text('${_products.length} items', style: AppTypography.caption),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          _products.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(AppSpacing.xl),
                  child: Center(
                    child: Text('No products currently listed for this shop.'),
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: AppSpacing.sm,
                    mainAxisSpacing: AppSpacing.sm,
                  ),
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final prod = _products[index];
                    return ProductCardFoundation(
                      productName: prod.name,
                      price: prod.price,
                      unit: prod.unit,
                      shopName: shop.shopName,
                      distanceText: '0.4 km',
                      isAvailable: prod.available,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.productDetails);
                      },
                    );
                  },
                ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}
