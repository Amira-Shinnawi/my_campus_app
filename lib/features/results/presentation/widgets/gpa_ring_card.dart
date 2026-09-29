import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../attendance/presentation/widgets/attendance_ring_painter.dart';

/// Card component displaying GPA score circular progress badge and academic standing.
class GpaRingCard extends StatelessWidget {
  final double gpa;
  final int totalCredits;
  final int totalSubjects;

  const GpaRingCard({
    super.key,
    required this.gpa,
    required this.totalCredits,
    required this.totalSubjects,
  });

  Color _getGpaColor(double score) {
    if (score >= 3.5) {
      return AppColors.primary; // SoftTaqwa Green
    } else if (score >= 3.0) {
      return const Color(0xFF1976D2); // Primary Blue
    } else if (score >= 2.0) {
      return AppColors.warning; // Amber / Orange
    } else {
      return AppColors.error; // Red
    }
  }

  String _getStandingText(double score) {
    if (score >= 3.6) {
      return 'First Class Honors (Dean\'s List)';
    } else if (score >= 3.0) {
      return 'Very Good Standing';
    } else if (score >= 2.0) {
      return 'Good Standing';
    } else {
      return 'Academic Probation Warning';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color mainColor = _getGpaColor(gpa);
    final double progress = (gpa / 4.0).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(AppSizes.p20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.r24),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.6),
          width: 1.0,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          // Central Ring Indicator
          SizedBox(
            width: 140.0,
            height: 140.0,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CustomPaint(
                  size: const Size(140.0, 140.0),
                  painter: AttendanceRingPainter(
                    progress: progress,
                    strokeColor: mainColor,
                    trackColor: mainColor.withValues(alpha: 0.12),
                    strokeWidth: 12.0,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      gpa.toStringAsFixed(2),
                      style: AppTextStyles.displayLarge.copyWith(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      'Out of 4.00',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.p16),

          // Academic Standing Badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.p12,
              vertical: AppSizes.p4,
            ),
            decoration: BoxDecoration(
              color: mainColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSizes.r16),
            ),
            child: Text(
              _getStandingText(gpa),
              style: AppTextStyles.caption.copyWith(
                color: mainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: AppSizes.p16),
          const Divider(height: 1.0, color: AppColors.border),
          const SizedBox(height: AppSizes.p16),

          // Summary Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    '$totalCredits',
                    style: AppTextStyles.headlineMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Earned Credits',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                height: 24.0,
                width: 1.0,
                color: AppColors.border,
              ),
              Column(
                children: <Widget>[
                  Text(
                    '$totalSubjects',
                    style: AppTextStyles.headlineMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Completed Subjects',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
