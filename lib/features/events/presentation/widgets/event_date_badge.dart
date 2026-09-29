import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Calendar-style date badge displaying day and month with category accent color.
class EventDateBadge extends StatelessWidget {
  final DateTime date;
  final Color categoryColor;

  const EventDateBadge({
    super.key,
    required this.date,
    required this.categoryColor,
  });

  String _getMonthAbbr(int month) {
    const List<String> months = <String>[
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58.0,
      height: 64.0,
      decoration: BoxDecoration(
        color: categoryColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSizes.r12),
        border: Border.all(
          color: categoryColor.withValues(alpha: 0.3),
          width: 1.2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${date.day}',
            style: AppTextStyles.headlineLarge.copyWith(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: categoryColor,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            _getMonthAbbr(date.month),
            style: AppTextStyles.caption.copyWith(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: categoryColor,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
