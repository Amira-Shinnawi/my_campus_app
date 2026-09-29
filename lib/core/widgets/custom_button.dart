import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_text_styles.dart';

/// Reusable elevated button component with loading state and custom styling.
class CustomButton extends StatelessWidget {
  /// Button label text.
  final String text;

  /// Callback executed on tap.
  final VoidCallback? onPressed;

  /// Whether to display a loading indicator instead of text.
  final bool isLoading;

  /// Background color override.
  final Color? backgroundColor;

  /// Text color override.
  final Color? textColor;

  /// Width of the button. Defaults to full width if null.
  final double? width;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveBgColor = backgroundColor ?? AppColors.primary;
    final Color effectiveTextColor = textColor ?? AppColors.surface;

    return SizedBox(
      width: width ?? double.infinity,
      height: AppSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBgColor,
          disabledBackgroundColor: effectiveBgColor.withValues(alpha: 0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r12),
          ),
          elevation: 0.0,
        ),
        child: isLoading
            ? SizedBox(
                height: AppSizes.iconMd,
                width: AppSizes.iconMd,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
                ),
              )
            : Text(
                text,
                style: AppTextStyles.buttonText.copyWith(
                  color: effectiveTextColor,
                ),
              ),
      ),
    );
  }
}
