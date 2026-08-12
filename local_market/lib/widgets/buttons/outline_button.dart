import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Reusable Outline Button Component
class AppOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color borderColor;

  const AppOutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.borderColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: borderColor,
        minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
        side: BorderSide(color: borderColor, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: AppSpacing.iconMd, color: borderColor),
            const SizedBox(width: AppSpacing.sm),
          ],
          Text(
            text,
            style: AppTypography.buttonText.copyWith(color: borderColor),
          ),
        ],
      ),
    );
  }
}
