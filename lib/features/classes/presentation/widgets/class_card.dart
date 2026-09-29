import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/class_entity.dart';

/// Card widget representing a single class schedule item.
class ClassCard extends StatelessWidget {
  final ClassEntity classEntity;

  const ClassCard({
    super.key,
    required this.classEntity,
  });

  /// Helper to get color code for different class types.
  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'lab':
        return const Color(0xFF00897B); // Teal / Turquoise
      case 'section':
        return const Color(0xFFE65100); // Deep Amber / Orange
      case 'lecture':
      default:
        return const Color(0xFF1976D2); // Primary Blue
    }
  }

  /// Helper icon for class type.
  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'lab':
        return Icons.computer_rounded;
      case 'section':
        return Icons.groups_rounded;
      case 'lecture':
      default:
        return Icons.menu_book_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color typeColor = _getTypeColor(classEntity.type);

    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.p12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.r16),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.7),
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
              // Colored vertical strip on left side indicating session type
              Container(
                width: 5.0,
                color: typeColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.p16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Top Header: Time & Type Badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Class Time range
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.access_time_rounded,
                                size: AppSizes.iconSm,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: AppSizes.p4),
                              Text(
                                '${classEntity.startTime} - ${classEntity.endTime}',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          // Session Type Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.p8,
                              vertical: AppSizes.p4,
                            ),
                            decoration: BoxDecoration(
                              color: typeColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(AppSizes.r8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  _getTypeIcon(classEntity.type),
                                  size: 13.0,
                                  color: typeColor,
                                ),
                                const SizedBox(width: AppSizes.p4),
                                Text(
                                  classEntity.type,
                                  style: AppTextStyles.caption.copyWith(
                                    color: typeColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.p12),

                      // Subject Name
                      Text(
                        classEntity.subjectName,
                        style: AppTextStyles.headlineMedium.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppSizes.p8),

                      // Instructor & Location
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.person_outline_rounded,
                            size: AppSizes.iconSm,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: AppSizes.p4),
                          Expanded(
                            child: Text(
                              classEntity.instructorName,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.p4),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.location_on_outlined,
                            size: AppSizes.iconSm,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: AppSizes.p4),
                          Expanded(
                            child: Text(
                              classEntity.location,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              overflow: TextOverflow.ellipsis,
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
