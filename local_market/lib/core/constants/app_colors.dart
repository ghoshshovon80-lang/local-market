import 'package:flutter/material.dart';

/// Semantic Color Palette for Local Market Design System.
abstract class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF2E7D32); // Fresh Local Green
  static const Color primaryLight = Color(0xFFE8F5E9); // Surface Light Green
  static const Color primaryDark = Color(0xFF1B5E20); // Dark Green

  static const Color secondary = Color(0xFFF57C00); // Warm Accent Orange
  static const Color secondaryLight = Color(0xFFFFF3E0);

  // Neutral Colors
  static const Color background = Color(
    0xFFF8F9FA,
  ); // Off-white neutral background
  static const Color surface = Color(0xFFFFFFFF); // White container surfaces
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE0E0E0); // Border and divider grey
  static const Color inputBackground = Color(0xFFFAFAFA);

  // Typography & Text Colors
  static const Color textPrimary = Color(
    0xFF212121,
  ); // High contrast dark charcoal
  static const Color textSecondary = Color(0xFF616161); // Medium muted grey
  static const Color textMuted = Color(0xFF757575);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Status & Feedback Semantic Colors
  static const Color success = Color(0xFF2E7D32); // Green
  static const Color successLight = Color(0xFFE8F5E9);
  static const Color warning = Color(0xFFFFA000); // Amber/Yellow
  static const Color warningLight = Color(0xFFFFF8E1);
  static const Color error = Color(0xFFD32F2F); // Red
  static const Color errorLight = Color(0xFFFFEBEE);
  static const Color info = Color(0xFF1976D2); // Blue
  static const Color infoLight = Color(0xFFE3F2FD);

  // Business Specific Status Colors
  static const Color openStatus = Color(0xFF2E7D32);
  static const Color closedStatus = Color(0xFFD32F2F);
  static const Color verifiedBadge = Color(0xFF1976D2);
  static const Color disabled = Color(0xFFBDBDBD);
}
