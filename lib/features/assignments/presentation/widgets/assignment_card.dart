import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/assignment_entity.dart';
import '../../domain/entities/assignment_status.dart';

/// Card widget displaying details of a single assignment and action to submit.
class AssignmentCard extends StatelessWidget {
  final AssignmentEntity assignment;
  final VoidCallback? onMarkSubmitted;

  const AssignmentCard({
    super.key,
    required this.assignment,
    this.onMarkSubmitted,
  });

  Color _getStatusColor(AssignmentStatus status) {
    switch (status) {
      case AssignmentStatus.submitted:
        return AppColors.success;
      case AssignmentStatus.overdue:
        return AppColors.error;
      case AssignmentStatus.pending:
        return AppColors.warning;
    }
  }

  String _formatDueDate(DateTime date) {
    final List<String> months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return 'Due: ${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final Color statusColor = _getStatusColor(assignment.status);
    final bool isOverdue = assignment.status == AssignmentStatus.overdue ||
        (assignment.status == AssignmentStatus.pending &&
            assignment.dueDate.isBefore(DateTime.now()));

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
              // Left status vertical strip
              Container(
                width: 5.0,
                color: statusColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.p16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Top Row: Subject Name & Status Badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            assignment.subjectName,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.p8,
                              vertical: AppSizes.p4,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(AppSizes.r8),
                            ),
                            child: Text(
                              assignment.status.name.toUpperCase(),
                              style: AppTextStyles.caption.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.p8),

                      // Title
                      Text(
                        assignment.title,
                        style: AppTextStyles.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSizes.p4),

                      // Description
                      Text(
                        assignment.description,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 13.0,
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSizes.p12),

                      // Bottom Row: Due Date & Action Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today_rounded,
                                size: AppSizes.iconSm,
                                color: isOverdue
                                    ? AppColors.error
                                    : AppColors.textSecondary,
                              ),
                              const SizedBox(width: AppSizes.p4),
                              Text(
                                _formatDueDate(assignment.dueDate),
                                style: AppTextStyles.caption.copyWith(
                                  color: isOverdue
                                      ? AppColors.error
                                      : AppColors.textSecondary,
                                  fontWeight: isOverdue
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          if (assignment.status != AssignmentStatus.submitted)
                            OutlinedButton.icon(
                              onPressed: onMarkSubmitted,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                side: const BorderSide(color: AppColors.primary),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.p12,
                                  vertical: AppSizes.p4,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSizes.r12),
                                ),
                              ),
                              icon: const Icon(
                                Icons.check_circle_outline_rounded,
                                size: 16.0,
                              ),
                              label: Text(
                                'Mark Submitted',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
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
