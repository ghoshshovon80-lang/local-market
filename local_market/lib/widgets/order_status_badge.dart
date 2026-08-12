import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../models/order_model.dart';
import 'status/status_badge.dart';

/// Reusable Color-Coded Order Status Badge
class OrderStatusBadge extends StatelessWidget {
  final OrderStatus status;

  const OrderStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    String label;
    IconData? icon;

    switch (status) {
      case OrderStatus.pending:
        bg = AppColors.warningLight;
        fg = AppColors.warning;
        label = 'Pending';
        icon = Icons.schedule;
        break;
      case OrderStatus.accepted:
        bg = AppColors.infoLight;
        fg = AppColors.info;
        label = 'Accepted';
        icon = Icons.thumb_up_alt_outlined;
        break;
      case OrderStatus.preparing:
        bg = Colors.purple.shade50;
        fg = Colors.purple;
        label = 'Preparing';
        icon = Icons.flatware;
        break;
      case OrderStatus.ready:
        bg = Colors.teal.shade50;
        fg = Colors.teal;
        label = 'Ready';
        icon = Icons.check_circle_outline;
        break;
      case OrderStatus.outForDelivery:
        bg = AppColors.secondaryLight;
        fg = AppColors.secondary;
        label = 'Out for Delivery';
        icon = Icons.delivery_dining;
        break;
      case OrderStatus.delivered:
      case OrderStatus.collected:
        bg = AppColors.successLight;
        fg = AppColors.success;
        label = status == OrderStatus.delivered ? 'Delivered' : 'Collected';
        icon = Icons.task_alt;
        break;
      case OrderStatus.cancelled:
      case OrderStatus.rejected:
        bg = AppColors.errorLight;
        fg = AppColors.error;
        label = status == OrderStatus.cancelled ? 'Cancelled' : 'Rejected';
        icon = Icons.cancel_outlined;
        break;
    }

    return StatusBadge(
      label: label,
      backgroundColor: bg,
      textColor: fg,
      icon: icon,
    );
  }
}
