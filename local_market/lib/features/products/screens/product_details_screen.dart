import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/cart_service.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../models/product_model.dart';
import '../../../models/shop_model.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/navigation/custom_app_bar.dart';
import '../../../widgets/states/error_state_widget.dart';
import '../../../widgets/states/loading_widget.dart';
import '../../../widgets/status/availability_badge.dart';
import '../../../widgets/status/verified_badge.dart';
import '../repositories/mock_product_repository.dart';
import '../repositories/product_repository.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;
  final ProductRepository? repository;

  const ProductDetailsScreen({
    super.key,
    this.productId = 'prod_1',
    this.repository,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late ProductRepository _repository;

  bool _isLoading = true;
  ProductModel? _product;
  ShopModel? _shop;
  String? _error;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _repository = widget.repository ?? MockProductRepository();
    _loadProductData();
  }

  Future<void> _loadProductData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final product = await _repository.getProductById(widget.productId);
      ShopModel? shop;
      if (product != null) {
        shop = await _repository.getShopForProduct(product.shopId);
      }

      if (!mounted) return;
      setState(() {
        _product = product;
        _shop = shop;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Unable to load product details. Please try again.';
        _isLoading = false;
      });
    }
  }

  void _onAddToCartPressed() {
    if (_product == null || _shop == null) return;

    final result = CartService.instance.addToCart(
      _product!,
      _shop!,
      quantity: _quantity,
    );

    if (result.status == AddToCartStatus.success) {
      final total = _product!.price * _quantity;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Added $_quantity x ${_product!.name} (${CurrencyFormatter.format(total)}) to Cart!',
          ),
          backgroundColor: AppColors.primary,
          duration: const Duration(seconds: 2),
        ),
      );
    } else if (result.status == AddToCartStatus.differentShopConflict) {
      _showMultiShopConflictDialog(result.existingShopName ?? 'another shop');
    }
  }

  void _showMultiShopConflictDialog(String existingShopName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusLg,
          ),
          title: const Text(
            'Replace Cart Items?',
            style: AppTypography.sectionTitle,
          ),
          content: Text(
            'Your cart already contains items from "$existingShopName". Local Market orders are placed per shop.\n\nWould you like to clear your cart and start a new order from "${_shop?.shopName}"?',
            style: AppTypography.body,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Continue with $existingShopName'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
              onPressed: () {
                Navigator.pop(context);
                if (_product != null && _shop != null) {
                  CartService.instance.confirmClearAndAdd(
                    _product!,
                    _shop!,
                    quantity: _quantity,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Cart cleared. Added ${_product!.name}!'),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                }
              },
              child: const Text('Clear Cart & Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: _product?.name ?? 'Product Details',
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingWidget(message: 'Loading product details...');
    }

    if (_error != null || _product == null) {
      return ErrorStateWidget(
        title: 'Product Error',
        errorMessage: _error ?? 'Product not found.',
        onRetry: _loadProductData,
      );
    }

    final product = _product!;
    final shop = _shop;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image Container
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: AppSpacing.borderRadiusLg,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      size: 80,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Product Title, Price & Availability
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: AppTypography.display.copyWith(fontSize: 24),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    AvailabilityBadge(isAvailable: product.available),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(product.category, style: AppTypography.caption),
                const SizedBox(height: AppSpacing.md),

                Text(
                  CurrencyFormatter.formatWithUnit(product.price, product.unit),
                  style: AppTypography.priceLarge,
                ),
                const SizedBox(height: AppSpacing.lg),

                // Local Shop Card Header (Tap to view Shop)
                if (shop != null) ...[
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.shopDetails);
                    },
                    borderRadius: AppSpacing.borderRadiusMd,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: AppSpacing.borderRadiusMd,
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: const BoxDecoration(
                              color: AppColors.secondaryLight,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.storefront,
                              color: AppColors.secondary,
                              size: 24,
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
                                        style: AppTypography.cardTitle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (shop.verified) ...[
                                      const SizedBox(width: AppSpacing.xs),
                                      const VerifiedBadge(),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.xxs),
                                Text(
                                  '0.4 km away • ${shop.address}',
                                  style: AppTypography.caption,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],

                // Buying Options (Visit Shop vs Home Delivery)
                const Text('Fulfillment Options', style: AppTypography.label),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.sm + 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: AppSpacing.borderRadiusSm,
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.store,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            SizedBox(width: AppSpacing.xs),
                            Expanded(
                              child: Text(
                                'Visit Shop\n(In-Store Buy)',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.sm + 4),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryLight,
                          borderRadius: AppSpacing.borderRadiusSm,
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.delivery_dining,
                              color: AppColors.secondary,
                              size: 20,
                            ),
                            SizedBox(width: AppSpacing.xs),
                            Expanded(
                              child: Text(
                                'Home Delivery\n(Fee ₹10)',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                // Description
                const Text('Product Description', style: AppTypography.label),
                const SizedBox(height: AppSpacing.xs),
                Text(product.description, style: AppTypography.bodyMuted),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),

        // Bottom Fixed Bar (Quantity + Add to Cart)
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(top: BorderSide(color: AppColors.divider)),
          ),
          child: Row(
            children: [
              // Quantity Counter
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.divider),
                  borderRadius: AppSpacing.borderRadiusSm,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 18),
                      onPressed: _quantity > 1
                          ? () => setState(() => _quantity--)
                          : null,
                    ),
                    Text('$_quantity', style: AppTypography.cardTitle),
                    IconButton(
                      icon: const Icon(Icons.add, size: 18),
                      onPressed: () => setState(() => _quantity++),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Add to Cart Button
              Expanded(
                child: PrimaryButton(
                  text: 'Add to Cart',
                  icon: Icons.shopping_cart_outlined,
                  onPressed: product.available ? _onAddToCartPressed : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
