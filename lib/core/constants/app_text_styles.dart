import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Centralized application typography styles using Google Fonts.
abstract class AppTextStyles {
  /// Display large text style (e.g. hero headers).
  static TextStyle get displayLarge => GoogleFonts.cairo(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Headline large text style (e.g. section headers).
  static TextStyle get headlineLarge => GoogleFonts.cairo(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Headline medium text style (e.g. card titles).
  static TextStyle get headlineMedium => GoogleFonts.cairo(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  /// Title medium text style (e.g. list tile titles).
  static TextStyle get titleMedium => GoogleFonts.cairo(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  /// Body large text style.
  static TextStyle get bodyLarge => GoogleFonts.cairo(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
      );

  /// Body medium text style.
  static TextStyle get bodyMedium => GoogleFonts.cairo(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
      );

  /// Button text style.
  static TextStyle get buttonText => GoogleFonts.cairo(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: AppColors.surface,
      );

  /// Caption / label small text style.
  static TextStyle get caption => GoogleFonts.cairo(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: AppColors.textMuted,
      );
}
