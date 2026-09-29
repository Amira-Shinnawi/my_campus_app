import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/event_entity.dart';
import 'event_date_badge.dart';

/// Card component representing a single campus event item.
class EventCard extends StatelessWidget {
  final EventEntity event;
  final VoidCallback onTap;

  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
  });

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'workshop':
        return const Color(0xFF00897B); // Teal
      case 'competition':
        return const Color(0xFFE53935); // Red / Flame
      case 'sports':
        return const Color(0xFFE65100); // Orange
      case 'social':
        return const Color(0xFF8E24AA); // Purple
      case 'seminar':
      default:
        return const Color(0xFF1976D2); // Blue
    }
  }

  String _formatTime(DateTime date) {
    final int hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
    final String period = date.hour >= 12 ? 'PM' : 'AM';
    final String minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final Color categoryColor = _getCategoryColor(event.category);

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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.r16),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.p16),
          child: Row(
            children: <Widget>[
              // Left Date Badge
              EventDateBadge(
                date: event.date,
                categoryColor: categoryColor,
              ),
              const SizedBox(width: AppSizes.p16),

              // Event Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Top Row: Category Chip & "Soon" Badge
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.p8,
                            vertical: 2.0,
                          ),
                          decoration: BoxDecoration(
                            color: categoryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(AppSizes.r8),
                          ),
                          child: Text(
                            event.category.toUpperCase(),
                            style: AppTextStyles.caption.copyWith(
                              color: categoryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                        if (event.isSoon) ...<Widget>[
                          const SizedBox(width: AppSizes.p8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.p8,
                              vertical: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.error.withValues(alpha: 0.1),
                              borderRadius:
                                  BorderRadius.circular(AppSizes.r8),
                            ),
                            child: Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.local_fire_department_rounded,
                                  size: 11.0,
                                  color: AppColors.error,
                                ),
                                const SizedBox(width: 2.0),
                                Text(
                                  'Soon',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.error,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppSizes.p8),

                    // Title
                    Text(
                      event.title,
                      style: AppTextStyles.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSizes.p8),

                    // Location & Time Row
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on_outlined,
                          size: AppSizes.iconSm,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 2.0),
                        Expanded(
                          child: Text(
                            '${event.location} • ${_formatTime(event.date)}',
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
              const SizedBox(width: AppSizes.p8),

              // Arrow Icon
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14.0,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
