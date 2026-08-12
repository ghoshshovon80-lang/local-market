import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';

/// Reusable Verified Shop Badge Icon Component
class VerifiedBadge extends StatelessWidget {
  final double size;

  const VerifiedBadge({super.key, this.size = AppSpacing.iconSm});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Verified Shop',
      child: Icon(Icons.verified, size: size, color: AppColors.verifiedBadge),
    );
  }
}
