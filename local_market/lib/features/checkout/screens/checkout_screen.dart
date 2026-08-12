import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/cart_service.dart';
import '../../../core/services/order_service.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../models/order_model.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/navigation/custom_app_bar.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  void _onPlaceOrderPressed(BuildContext context) {
    final cart = CartService.instance;
    if (cart.isEmpty || cart.currentShop == null) return;

    final shop = cart.currentShop!;
    final orderId =
        'LM-ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

    final order = OrderModel(
      id: orderId,
      buyerId: 'buyer_1',
      shopId: shop.id,
      shopName: shop.shopName,
      items: List.from(cart.items),
      orderType: cart.selectedFulfillment,
      subtotal: cart.subtotal,
      deliveryFee: cart.deliveryFee,
      total: cart.grandTotal,
      status: OrderStatus.pending,
      paymentMethod: cart.selectedFulfillment == OrderType.homeDelivery
          ? 'Cash on Delivery (COD)'
          : 'Pay at Shop upon Pickup',
      deliveryAddress: 'Beldanga, Main Market Area',
      createdAt: DateTime.now(),
    );

    // Save order locally
    OrderService.instance.addOrder(order);

    // Clear active cart
    cart.clearCart();

    // Navigate to confirmation screen
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.orderTracking,
      arguments: order,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartService.instance;
    final shop = cart.currentShop;

    if (cart.isEmpty || shop == null) {
      return Scaffold(
        appBar: const CustomAppBar(title: 'Checkout'),
        body: const Center(child: Text('No active cart items for checkout.')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Order Checkout'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shop Card Banner
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
                            'Ordering From',
                            style: AppTypography.caption,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            shop.shopName,
                            style: AppTypography.sectionTitle,
                          ),
                          Text(shop.address, style: AppTypography.bodyMuted),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Fulfillment Selection Summary Card
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color:
                            cart.selectedFulfillment == OrderType.homeDelivery
                            ? AppColors.primaryLight
                            : AppColors.secondaryLight,
                        borderRadius: AppSpacing.borderRadiusLg,
                        border: Border.all(
                          color:
                              cart.selectedFulfillment == OrderType.homeDelivery
                              ? AppColors.primary
                              : AppColors.secondary,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            cart.selectedFulfillment == OrderType.homeDelivery
                                ? Icons.delivery_dining
                                : Icons.store,
                            size: 32,
                            color:
                                cart.selectedFulfillment ==
                                    OrderType.homeDelivery
                                ? AppColors.primary
                                : AppColors.secondary,
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cart.selectedFulfillment ==
                                          OrderType.homeDelivery
                                      ? 'Fulfillment: Home Delivery'
                                      : 'Fulfillment: Store Pickup',
                                  style: AppTypography.cardTitle,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  cart.selectedFulfillment ==
                                          OrderType.homeDelivery
                                      ? 'Deliver to: Beldanga, Main Market (Fee ₹${cart.deliveryFee.toStringAsFixed(0)})'
                                      : 'Collect at: ${shop.shopName} during opening hours (₹0 fee)',
                                  style: AppTypography.caption,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Mandatory Payment Method Banner (COD / Pay at Shop)
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
                          const Row(
                            children: [
                              Icon(
                                Icons.payments_outlined,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: AppSpacing.xs),
                              Text(
                                'Payment Method',
                                style: AppTypography.sectionTitle,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            cart.selectedFulfillment == OrderType.homeDelivery
                                ? 'Cash on Delivery (COD)'
                                : 'Pay at Shop upon Pickup',
                            style: AppTypography.cardTitle.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'No online payment required for MVP. Pay directly to the local shopkeeper.',
                            style: AppTypography.caption,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Order Items Summary
                    const Text(
                      'Order Items',
                      style: AppTypography.sectionTitle,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        final item = cart.items[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item.quantity}x ${item.product.name}',
                                style: AppTypography.body,
                              ),
                              Text(
                                CurrencyFormatter.format(item.subtotal),
                                style: AppTypography.body.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const Divider(height: AppSpacing.lg),

                    // Final Bill Totals
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Items Subtotal', style: AppTypography.body),
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
                        const Text(
                          'Delivery Charge',
                          style: AppTypography.body,
                        ),
                        Text(
                          CurrencyFormatter.format(cart.deliveryFee),
                          style: AppTypography.body,
                        ),
                      ],
                    ),
                    const Divider(height: AppSpacing.lg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount Payable',
                          style: AppTypography.sectionTitle,
                        ),
                        Text(
                          CurrencyFormatter.format(cart.grandTotal),
                          style: AppTypography.priceLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),

            // Confirm Place Order Button
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.divider)),
              ),
              child: PrimaryButton(
                text:
                    'Confirm & Place Order (${CurrencyFormatter.format(cart.grandTotal)})',
                icon: Icons.check_circle_outline,
                onPressed: () => _onPlaceOrderPressed(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
