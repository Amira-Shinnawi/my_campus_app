import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/subject_attendance_entity.dart';

/// Card widget displaying attendance summary for a single subject.
class SubjectAttendanceCard extends StatelessWidget {
  final SubjectAttendanceEntity subjectSummary;

  const SubjectAttendanceCard({
    super.key,
    required this.subjectSummary,
  });

  Color _getStatusColor(double pct) {
    if (pct >= 85.0) {
      return AppColors.success;
    } else if (pct >= 70.0) {
      return AppColors.warning;
    } else {
      return AppColors.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double pct = subjectSummary.attendancePercentage;
    final Color color = _getStatusColor(pct);

    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.p12),
      padding: const EdgeInsets.all(AppSizes.p16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Subject Name and Percentage
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  subjectSummary.subjectName,
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.p8,
                  vertical: AppSizes.p4,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.r8),
                ),
                child: Text(
                  '${pct.toStringAsFixed(0)}%',
                  style: AppTextStyles.caption.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.p8),

          // Linear Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.r8),
            child: LinearProgressIndicator(
              value: pct / 100.0,
              minHeight: 8.0,
              backgroundColor: color.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          const SizedBox(height: AppSizes.p8),

          // Sessions Count Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${subjectSummary.attendedSessions}/${subjectSummary.totalSessions} Sessions Attended',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              if (subjectSummary.absentSessions > 0)
                Text(
                  '${subjectSummary.absentSessions} Absent',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
