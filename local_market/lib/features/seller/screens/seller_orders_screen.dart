import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../models/order_model.dart';
import '../../../widgets/navigation/custom_app_bar.dart';
import '../../../widgets/order_status_badge.dart';
import '../../../widgets/states/empty_state_widget.dart';
import '../repositories/mock_seller_repository.dart';

class SellerOrdersScreen extends StatelessWidget {
  const SellerOrdersScreen({super.key});

  OrderStatus? _getNextStatus(OrderStatus current, OrderType type) {
    if (type == OrderType.homeDelivery) {
      switch (current) {
        case OrderStatus.pending:
          return OrderStatus.accepted;
        case OrderStatus.accepted:
          return OrderStatus.preparing;
        case OrderStatus.preparing:
          return OrderStatus.outForDelivery;
        case OrderStatus.outForDelivery:
          return OrderStatus.delivered;
        default:
          return null;
      }
    } else {
      switch (current) {
        case OrderStatus.pending:
          return OrderStatus.accepted;
        case OrderStatus.accepted:
          return OrderStatus.preparing;
        case OrderStatus.preparing:
          return OrderStatus.ready;
        case OrderStatus.ready:
          return OrderStatus.collected;
        default:
          return null;
      }
    }
  }

  String _getNextStatusButtonText(OrderStatus current, OrderType type) {
    final next = _getNextStatus(current, type);
    if (next == null) return 'Order Completed';
    switch (next) {
      case OrderStatus.accepted:
        return 'Accept Order';
      case OrderStatus.preparing:
        return 'Mark Preparing';
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Mark Delivered';
      case OrderStatus.ready:
        return 'Mark Ready for Pickup';
      case OrderStatus.collected:
        return 'Mark Order Completed';
      default:
        return 'Advance Status';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: MockSellerRepository.instance,
      builder: (context, _) {
        final repo = MockSellerRepository.instance;
        final orders = repo.orders;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: CustomAppBar(title: 'Seller Orders (${orders.length})'),
          body: orders.isEmpty
              ? const EmptyStateWidget(
                  title: 'No Incoming Orders',
                  subtitle:
                      'Orders placed by local buyers will appear here for processing.',
                  icon: Icons.receipt_long_outlined,
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    final nextStatus = _getNextStatus(
                      order.status,
                      order.orderType,
                    );

                    return Card(
                      margin: const EdgeInsets.only(bottom: AppSpacing.md),
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
                            Row(
                              children: [
                                Icon(
                                  order.orderType == OrderType.homeDelivery
                                      ? Icons.delivery_dining
                                      : Icons.store,
                                  size: 18,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  order.orderType == OrderType.homeDelivery
                                      ? 'Home Delivery'
                                      : 'Store Pickup',
                                  style: AppTypography.caption.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  CurrencyFormatter.format(order.total),
                                  style: AppTypography.priceMedium,
                                ),
                              ],
                            ),
                            const Divider(height: AppSpacing.md),

                            Text(
                              'Buyer: ${order.buyerId}',
                              style: AppTypography.caption,
                            ),
                            if (order.deliveryAddress != null)
                              Text(
                                'Address: ${order.deliveryAddress}',
                                style: AppTypography.caption,
                              ),
                            const SizedBox(height: AppSpacing.xs),

                            ...order.items.map(
                              (item) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${item.quantity}x ${item.product.name}',
                                    ),
                                    Text(
                                      CurrencyFormatter.format(item.subtotal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),

                            if (nextStatus != null)
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    repo.updateOrderStatus(
                                      order.id,
                                      nextStatus,
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Order ${order.id} status updated!',
                                        ),
                                        backgroundColor: AppColors.primary,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    _getNextStatusButtonText(
                                      order.status,
                                      order.orderType,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
