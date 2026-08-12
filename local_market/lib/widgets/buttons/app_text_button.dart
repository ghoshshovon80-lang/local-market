import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';

/// Reusable Text Button Component
class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color textColor;

  const AppTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor,
        minimumSize: const Size(
          AppSpacing.minTouchTargetSize,
          AppSpacing.minTouchTargetSize,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
