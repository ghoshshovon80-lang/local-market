import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/order_service.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../models/order_model.dart';
import '../../../widgets/buttons/outline_button.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/navigation/custom_app_bar.dart';
import '../../../widgets/order_status_badge.dart';
import '../../../widgets/states/empty_state_widget.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderModel? confirmedOrder =
        ModalRoute.of(context)?.settings.arguments as OrderModel?;

    if (confirmedOrder != null) {
      return _buildOrderConfirmationView(context, confirmedOrder);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'My Local Orders'),
      body: ListenableBuilder(
        listenable: OrderService.instance,
        builder: (context, _) {
          final orders = OrderService.instance.orders;

          if (orders.isEmpty) {
            return EmptyStateWidget(
              title: 'No Orders Yet',
              subtitle:
                  'Place your first local market order from nearby physical shops.',
              icon: Icons.inventory_2_outlined,
              actionText: 'Explore Local Shops',
              onAction: () {
                Navigator.pushReplacementNamed(context, AppRoutes.buyerHome);
              },
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                child: InkWell(
                  onTap: () => _showOrderDetailsModal(context, order),
                  borderRadius: AppSpacing.borderRadiusMd,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(order.id, style: AppTypography.cardTitle),
                            OrderStatusBadge(status: order.status),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Shop: ${order.shopName}',
                          style: AppTypography.body,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          children: [
                            Icon(
                              order.orderType == OrderType.homeDelivery
                                  ? Icons.delivery_dining
                                  : Icons.store,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              order.orderType == OrderType.homeDelivery
                                  ? 'Home Delivery'
                                  : 'Store Pickup',
                              style: AppTypography.caption,
                            ),
                            const Spacer(),
                            Text(
                              CurrencyFormatter.format(order.total),
                              style: AppTypography.priceMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildOrderConfirmationView(BuildContext context, OrderModel order) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: 'Order Confirmation',
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: const BoxDecoration(
                  color: AppColors.successLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  size: 72,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              const Text(
                'Order Placed Successfully!',
                style: AppTypography.screenTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text('Order ID: ${order.id}', style: AppTypography.bodyMuted),
              const SizedBox(height: AppSpacing.lg),

              // Confirmation Info Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppSpacing.borderRadiusLg,
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  children: [
                    Text(
                      'Shop: ${order.shopName}',
                      style: AppTypography.cardTitle,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      order.orderType == OrderType.homeDelivery
                          ? '🛵 Home Delivery to ${order.deliveryAddress ?? "Beldanga"}'
                          : '🏪 Pick up directly from shop during opening hours',
                      style: AppTypography.caption,
                      textAlign: TextAlign.center,
                    ),
                    const Divider(height: AppSpacing.md),
                    Text(
                      'Total: ${CurrencyFormatter.format(order.total)}',
                      style: AppTypography.priceLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Payment: ${order.paymentMethod}',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              PrimaryButton(
                text: 'View All Orders',
                icon: Icons.inventory_2_outlined,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.buyerHome);
                },
              ),
              const SizedBox(height: AppSpacing.md),
              AppOutlineButton(
                text: 'Continue Shopping',
                icon: Icons.storefront,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.buyerHome);
                },
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        ),
      ),
    );
  }

  void _showOrderDetailsModal(BuildContext context, OrderModel order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusLg),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order ${order.id}', style: AppTypography.sectionTitle),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text('Shop: ${order.shopName}', style: AppTypography.body),
              Text(
                'Fulfillment: ${order.orderType == OrderType.homeDelivery ? "Home Delivery (Fee ₹10)" : "Store Pickup (Free)"}',
                style: AppTypography.caption,
              ),
              const Divider(height: AppSpacing.lg),
              const Text('Items Ordered:', style: AppTypography.label),
              const SizedBox(height: AppSpacing.xs),
              ...order.items.map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${item.quantity}x ${item.product.name}'),
                      Text(CurrencyFormatter.format(item.subtotal)),
                    ],
                  ),
                ),
              ),
              const Divider(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Amount:', style: AppTypography.cardTitle),
                  Text(
                    CurrencyFormatter.format(order.total),
                    style: AppTypography.priceMedium,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Payment Method: ${order.paymentMethod}',
                style: AppTypography.caption.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        );
      },
    );
  }
}
