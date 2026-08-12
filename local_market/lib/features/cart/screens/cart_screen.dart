import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/cart_service.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../models/order_model.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/navigation/custom_app_bar.dart';
import '../../../widgets/states/empty_state_widget.dart';
import '../../../widgets/status/verified_badge.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: CartService.instance,
      builder: (context, _) {
        final cart = CartService.instance;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: CustomAppBar(
            title: 'My Cart (${cart.totalQuantity})',
            actions: [
              if (!cart.isEmpty)
                TextButton(
                  onPressed: () => cart.clearCart(),
                  child: const Text(
                    'Clear',
                    style: TextStyle(color: AppColors.error),
                  ),
                ),
            ],
          ),
          body: cart.isEmpty
              ? EmptyStateWidget(
                  title: 'Your cart is empty',
                  subtitle:
                      'Explore local physical shops near your area and add fresh items to your cart.',
                  icon: Icons.shopping_cart_outlined,
                  actionText: 'Explore Local Shops',
                  onAction: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.buyerHome,
                    );
                  },
                )
              : _buildCartContent(context, cart),
        );
      },
    );
  }

  Widget _buildCartContent(BuildContext context, CartService cart) {
    final shop = cart.currentShop;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Active Shop Banner
                if (shop != null)
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppSpacing.borderRadiusLg,
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.storefront,
                          color: AppColors.primary,
                          size: AppSpacing.iconLg,
                        ),
                        const SizedBox(width: AppSpacing.sm),
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
                              Text(shop.address, style: AppTypography.caption),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: AppSpacing.lg),

                // Fulfillment Selection Toggle (Pickup vs Home Delivery)
                const Text(
                  'Choose Fulfillment',
                  style: AppTypography.sectionTitle,
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            cart.setFulfillmentType(OrderType.homeDelivery),
                        child: Container(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color:
                                cart.selectedFulfillment ==
                                    OrderType.homeDelivery
                                ? AppColors.primaryLight
                                : AppColors.surface,
                            borderRadius: AppSpacing.borderRadiusMd,
                            border: Border.all(
                              color:
                                  cart.selectedFulfillment ==
                                      OrderType.homeDelivery
                                  ? AppColors.primary
                                  : AppColors.divider,
                              width:
                                  cart.selectedFulfillment ==
                                      OrderType.homeDelivery
                                  ? 2
                                  : 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.delivery_dining,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Home Delivery',
                                    style: AppTypography.label,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Fee: ₹${shop?.deliveryFee.toStringAsFixed(0) ?? "10"}',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            cart.setFulfillmentType(OrderType.visitShop),
                        child: Container(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color:
                                cart.selectedFulfillment == OrderType.visitShop
                                ? AppColors.secondaryLight
                                : AppColors.surface,
                            borderRadius: AppSpacing.borderRadiusMd,
                            border: Border.all(
                              color:
                                  cart.selectedFulfillment ==
                                      OrderType.visitShop
                                  ? AppColors.secondary
                                  : AppColors.divider,
                              width:
                                  cart.selectedFulfillment ==
                                      OrderType.visitShop
                                  ? 2
                                  : 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.store,
                                    color: AppColors.secondary,
                                    size: 20,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Store Pickup',
                                    style: AppTypography.label,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Fee: FREE (₹0)',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),

                // Cart Items List
                const Text('Items in Cart', style: AppTypography.sectionTitle),
                const SizedBox(height: AppSpacing.sm),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.sm + 4),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: AppSpacing.borderRadiusSm,
                              ),
                              child: const Icon(
                                Icons.shopping_bag_outlined,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.name,
                                    style: AppTypography.cardTitle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    CurrencyFormatter.formatWithUnit(
                                      item.product.price,
                                      item.product.unit,
                                    ),
                                    style: AppTypography.caption,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Subtotal: ${CurrencyFormatter.format(item.subtotal)}',
                                    style: AppTypography.priceMedium,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                    size: 20,
                                  ),
                                  onPressed: () =>
                                      cart.updateQuantity(item.product.id, -1),
                                ),
                                Text(
                                  '${item.quantity}',
                                  style: AppTypography.cardTitle,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                    size: 20,
                                  ),
                                  onPressed: () =>
                                      cart.updateQuantity(item.product.id, 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.xl),

                // Bill Details Card
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: AppSpacing.borderRadiusLg,
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bill Summary',
                        style: AppTypography.sectionTitle,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Items Subtotal',
                            style: AppTypography.body,
                          ),
                          Text(
                            CurrencyFormatter.format(cart.subtotal),
                            style: AppTypography.body,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cart.selectedFulfillment == OrderType.homeDelivery
                                ? 'Delivery Charge'
                                : 'Store Pickup Fee',
                            style: AppTypography.body,
                          ),
                          Text(
                            CurrencyFormatter.format(cart.deliveryFee),
                            style: AppTypography.body.copyWith(
                              color: cart.deliveryFee == 0
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                              fontWeight: cart.deliveryFee == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: AppSpacing.lg),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Grand Total',
                            style: AppTypography.sectionTitle,
                          ),
                          Text(
                            CurrencyFormatter.format(cart.grandTotal),
                            style: AppTypography.priceLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),

        // Checkout Button Bottom Bar
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(top: BorderSide(color: AppColors.divider)),
          ),
          child: PrimaryButton(
            text:
                'Proceed to Checkout (${CurrencyFormatter.format(cart.grandTotal)})',
            icon: Icons.arrow_forward,
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.checkout);
            },
          ),
        ),
      ],
    );
  }
}
