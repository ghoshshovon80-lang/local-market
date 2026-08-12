import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Reusable Primary Button Component
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        foregroundColor: textColor ?? AppColors.textOnPrimary,
        minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Colors.white,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: AppSpacing.iconMd),
                  const SizedBox(width: AppSpacing.xs),
                ],
                Flexible(
                  child: Text(
                    text,
                    style: AppTypography.buttonText.copyWith(
                      color: textColor ?? AppColors.textOnPrimary,
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
