import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/result_entity.dart';

/// Card widget displaying individual subject academic result and grade details.
class ResultCard extends StatelessWidget {
  final ResultEntity result;

  const ResultCard({
    super.key,
    required this.result,
  });

  Color _getGradeColor(String grade) {
    switch (grade.toUpperCase()) {
      case 'A+':
      case 'A':
        return AppColors.success; // Green
      case 'B+':
      case 'B':
        return const Color(0xFF1976D2); // Blue
      case 'C+':
      case 'C':
        return AppColors.warning; // Orange
      case 'D+':
      case 'D':
      case 'F':
      default:
        return AppColors.error; // Red
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color gradeColor = _getGradeColor(result.grade);

    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.p12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.r16),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.6),
          width: 1.0,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.r16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Colored vertical accent line
              Container(
                width: 5.0,
                color: gradeColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.p16),
                  child: Row(
                    children: <Widget>[
                      // Left Column: Title & Subtitle info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              result.subjectName,
                              style: AppTextStyles.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: AppSizes.p4),
                            Row(
                              children: <Widget>[
                                Text(
                                  result.semester,
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(width: AppSizes.p8),
                                Container(
                                  width: 4.0,
                                  height: 4.0,
                                  decoration: const BoxDecoration(
                                    color: AppColors.textMuted,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: AppSizes.p8),
                                Text(
                                  '${result.creditHours} Credit Hours',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSizes.p8),
                            Text(
                              'Score: ${result.score.toStringAsFixed(1)}%',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSizes.p12),

                      // Right Badge: Grade Chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.p12,
                          vertical: AppSizes.p8,
                        ),
                        decoration: BoxDecoration(
                          color: gradeColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppSizes.r12),
                          border: Border.all(
                            color: gradeColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          result.grade,
                          style: AppTextStyles.headlineMedium.copyWith(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: gradeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
