import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency_formatter.dart';
import '../status/availability_badge.dart';

/// Reusable Product Card Foundation Component
class ProductCardFoundation extends StatelessWidget {
  final String productName;
  final double price;
  final String unit;
  final String shopName;
  final String distanceText;
  final bool isAvailable;
  final Widget? imageWidget;
  final VoidCallback? onTap;

  const ProductCardFoundation({
    super.key,
    required this.productName,
    required this.price,
    required this.unit,
    required this.shopName,
    required this.distanceText,
    this.isAvailable = true,
    this.imageWidget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              color: AppColors.primaryLight,
              child:
                  imageWidget ??
                  const Center(
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      size: AppSpacing.xxl,
                      color: AppColors.primary,
                    ),
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm + 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: AppTypography.cardTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    CurrencyFormatter.formatWithUnit(price, unit),
                    style: AppTypography.priceMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      const Icon(
                        Icons.storefront,
                        size: AppSpacing.iconSm,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          shopName,
                          style: AppTypography.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: AppSpacing.iconSm,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(distanceText, style: AppTypography.caption),
                      const Spacer(),
                      AvailabilityBadge(isAvailable: isAvailable),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
