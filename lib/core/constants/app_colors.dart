import 'package:flutter/material.dart';

/// Centralized application color palette following the SoftTaqwa design system.
abstract class AppColors {
  /// Primary brand color - SoftTaqwa Green.
  static const Color primary = Color(0xFF1A7A4C);

  /// Variant of primary color for lighter highlights.
  static const Color primaryLight = Color(0xFF4CAF50);

  /// Variant of primary color for dark contrast.
  static const Color primaryDark = Color(0xFF0F4D2F);

  /// Secondary accent color.
  static const Color secondary = Color(0xFF388E3C);

  /// Light background color.
  static const Color background = Color(0xFFF8F9FA);

  /// Card and surface background color.
  static const Color surface = Color(0xFFFFFFFF);

  /// Primary text color.
  static const Color textPrimary = Color(0xFF1C1B1F);

  /// Secondary text color.
  static const Color textSecondary = Color(0xFF6C757D);

  /// Disabled element / hint text color.
  static const Color textMuted = Color(0xFFA0AEC0);

  /// Outline / border color.
  static const Color border = Color(0xFFE2E8F0);

  /// Soft tint background for cards / chips.
  static const Color softGreen = Color(0xFFE8F5E9);

  /// Error color for alerts and error states.
  static const Color error = Color(0xFFD32F2F);

  /// Success color.
  static const Color success = Color(0xFF2E7D32);

  /// Warning color.
  static const Color warning = Color(0xFFF57C00);
}
