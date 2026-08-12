import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../status/shop_status_badge.dart';
import '../status/verified_badge.dart';

/// Reusable Shop Card Foundation Component
class ShopCardFoundation extends StatelessWidget {
  final String shopName;
  final String category;
  final String distanceText;
  final bool isOpen;
  final bool isVerified;
  final bool deliveryAvailable;
  final Widget? shopImage;
  final VoidCallback? onTap;

  const ShopCardFoundation({
    super.key,
    required this.shopName,
    required this.category,
    required this.distanceText,
    this.isOpen = true,
    this.isVerified = false,
    this.deliveryAvailable = true,
    this.shopImage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm + 4),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.secondaryLight,
                  borderRadius: AppSpacing.borderRadiusSm,
                ),
                child:
                    shopImage ??
                    const Icon(
                      Icons.storefront_outlined,
                      size: AppSpacing.xl,
                      color: AppColors.secondary,
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
                            shopName,
                            style: AppTypography.cardTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isVerified) ...[
                          const SizedBox(width: AppSpacing.xs),
                          const VerifiedBadge(),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(category, style: AppTypography.caption),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        ShopStatusBadge(isOpen: isOpen),
                        const SizedBox(width: AppSpacing.md),
                        const Icon(
                          Icons.near_me_outlined,
                          size: AppSpacing.iconSm,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: AppSpacing.xxs),
                        Text(distanceText, style: AppTypography.caption),
                        if (deliveryAvailable) ...[
                          const SizedBox(width: AppSpacing.md),
                          const Icon(
                            Icons.delivery_dining,
                            size: AppSpacing.iconSm + 2,
                            color: AppColors.secondary,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
