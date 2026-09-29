import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../domain/entities/event_entity.dart';
import '../widgets/event_date_badge.dart';

/// Screen displaying full detail description and registration for a campus event.
class EventDetailsView extends StatelessWidget {
  final EventEntity event;

  const EventDetailsView({
    super.key,
    required this.event,
  });

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'workshop':
        return const Color(0xFF00897B);
      case 'competition':
        return const Color(0xFFE53935);
      case 'sports':
        return const Color(0xFFE65100);
      case 'social':
        return const Color(0xFF8E24AA);
      case 'seminar':
      default:
        return const Color(0xFF1976D2);
    }
  }

  String _formatFullDate(DateTime date) {
    final List<String> weekdays = <String>[
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    final List<String> months = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    final String dayName = weekdays[date.weekday - 1];
    final String monthName = months[date.month - 1];
    final int hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
    final String period = date.hour >= 12 ? 'PM' : 'AM';
    final String minute = date.minute.toString().padLeft(2, '0');

    return '$dayName, $monthName ${date.day}, ${date.year} at $hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final Color categoryColor = _getCategoryColor(event.category);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Event Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Top Hero Container Illustration Card
            Container(
              width: double.infinity,
              height: 180.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    categoryColor,
                    categoryColor.withValues(alpha: 0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppSizes.r24),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: categoryColor.withValues(alpha: 0.3),
                    blurRadius: 12.0,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    right: -20,
                    bottom: -20,
                    child: Icon(
                      Icons.event_seat_rounded,
                      size: 140.0,
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.p24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.p12,
                            vertical: AppSizes.p4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            borderRadius:
                                BorderRadius.circular(AppSizes.r16),
                          ),
                          child: Text(
                            event.category.toUpperCase(),
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.surface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.p8),
                        Text(
                          event.title,
                          style: AppTextStyles.headlineMedium.copyWith(
                            color: AppColors.surface,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.p24),

            // Date & Time Details Tile
            Row(
              children: <Widget>[
                EventDateBadge(
                  date: event.date,
                  categoryColor: categoryColor,
                ),
                const SizedBox(width: AppSizes.p16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Date & Time',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        _formatFullDate(event.date),
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.p16),
            const Divider(color: AppColors.border),
            const SizedBox(height: AppSizes.p16),

            // Location Info Tile
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(AppSizes.p12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.location_on_rounded,
                    color: AppColors.primary,
                    size: AppSizes.iconMd,
                  ),
                ),
                const SizedBox(width: AppSizes.p16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Venue Location',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        event.location,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.p20),

            // Description Section
            Text(
              'About Event',
              style: AppTextStyles.headlineMedium.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.p12),
            Text(
              event.description,
              style: AppTextStyles.bodyMedium.copyWith(
                height: 1.6,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSizes.p32),

            // Action Button: RSVP / Register
            CustomButton(
              text: 'Register / RSVP Now',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Successfully registered for ${event.title}! 🎉',
                    ),
                    backgroundColor: AppColors.primary,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
