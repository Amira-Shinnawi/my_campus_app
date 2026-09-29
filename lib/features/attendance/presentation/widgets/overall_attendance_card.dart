import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import 'attendance_ring_painter.dart';

/// Card component showing overall attendance percentage ring and breakdown legend.
class OverallAttendanceCard extends StatelessWidget {
  final double percentage;
  final int presentCount;
  final int lateCount;
  final int absentCount;

  const OverallAttendanceCard({
    super.key,
    required this.percentage,
    required this.presentCount,
    required this.lateCount,
    required this.absentCount,
  });

  /// Helper returning theme color based on percentage threshold.
  Color _getStatusColor(double pct) {
    if (pct >= 85.0) {
      return AppColors.success; // Green (Excellent)
    } else if (pct >= 70.0) {
      return AppColors.warning; // Orange/Amber (Good/Warning)
    } else {
      return AppColors.error; // Red (At Risk)
    }
  }

  /// Helper returning text badge based on percentage threshold.
  String _getStatusText(double pct) {
    if (pct >= 85.0) {
      return 'Excellent Standing';
    } else if (pct >= 70.0) {
      return 'Good Standing';
    } else {
      return 'Attention Required';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color mainColor = _getStatusColor(percentage);

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
                    progress: percentage / 100.0,
                    strokeColor: mainColor,
                    trackColor: mainColor.withValues(alpha: 0.12),
                    strokeWidth: 12.0,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${percentage.toStringAsFixed(0)}%',
                      style: AppTextStyles.displayLarge.copyWith(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      'Overall',
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

          // Status Badge
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
              _getStatusText(percentage),
              style: AppTextStyles.caption.copyWith(
                color: mainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: AppSizes.p20),
          const Divider(height: 1.0, color: AppColors.border),
          const SizedBox(height: AppSizes.p16),

          // Legend Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _LegendItem(
                label: 'Present',
                count: presentCount,
                color: AppColors.success,
              ),
              _LegendItem(
                label: 'Late',
                count: lateCount,
                color: AppColors.warning,
              ),
              _LegendItem(
                label: 'Absent',
                count: absentCount,
                color: AppColors.error,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _LegendItem({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppSizes.p8),
        Text(
          '$label: ',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          '$count',
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
