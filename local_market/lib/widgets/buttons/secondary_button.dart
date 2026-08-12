import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Reusable Secondary Button Component (Surface Fill with Accent Color)
class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.primary,
        minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: AppSpacing.iconMd, color: AppColors.primary),
            const SizedBox(width: AppSpacing.xs),
          ],
          Flexible(
            child: Text(
              text,
              style: AppTypography.buttonText.copyWith(
                color: AppColors.primary,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
