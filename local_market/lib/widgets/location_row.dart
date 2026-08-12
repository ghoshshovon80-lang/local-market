import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_spacing.dart';
import '../core/theme/app_typography.dart';

/// Reusable Location Header Row
class LocationRow extends StatelessWidget {
  final String locationName;
  final VoidCallback? onTap;

  const LocationRow({super.key, required this.locationName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppSpacing.borderRadiusSm,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.xs,
          horizontal: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_on,
              color: AppColors.primary,
              size: AppSpacing.iconMd,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(locationName, style: AppTypography.cardTitle),
            const SizedBox(width: AppSpacing.xs),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.textSecondary,
              size: AppSpacing.iconMd,
            ),
          ],
        ),
      ),
    );
  }
}
