import 'package:flutter/material.dart';
import '../../core/theme/app_typography.dart';

/// Standard Form Field Label Component
class FormLabel extends StatelessWidget {
  final String label;
  final bool isRequired;

  const FormLabel({super.key, required this.label, this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: AppTypography.label),
        if (isRequired) ...[
          const SizedBox(width: 4),
          const Text('*', style: TextStyle(color: Colors.red, fontSize: 14)),
        ],
      ],
    );
  }
}
