import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

/// Category badge widget displaying category label with matching color.
class NoticeCategoryBadge extends StatelessWidget {
  /// Category name string.
  final String category;

  const NoticeCategoryBadge({
    super.key,
    required this.category,
  });

  Color _getCategoryColor() {
    switch (category.toLowerCase()) {
      case 'exam':
        return AppColors.error;
      case 'event':
        return const Color(0xFF1E88E5);
      case 'general':
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color badgeColor = _getCategoryColor();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.p12,
        vertical: AppSizes.p4,
      ),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSizes.r16),
        border: Border.all(
          color: badgeColor.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        category,
        style: TextStyle(
          color: badgeColor,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
