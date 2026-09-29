import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/assignment_status.dart';

/// Row of filter chips for filtering assignments by status.
class AssignmentFilterChips extends StatelessWidget {
  /// Currently selected status filter (null = All).
  final AssignmentStatus? selectedFilter;

  /// Callback when filter selection changes.
  final ValueChanged<AssignmentStatus?> onFilterChanged;

  const AssignmentFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<_FilterOption> options = <_FilterOption>[
      const _FilterOption(label: 'All', status: null),
      const _FilterOption(label: 'Pending', status: AssignmentStatus.pending),
      const _FilterOption(
          label: 'Submitted', status: AssignmentStatus.submitted),
      const _FilterOption(label: 'Overdue', status: AssignmentStatus.overdue),
    ];

    return SizedBox(
      height: 44.0,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: AppSizes.p8),
        itemBuilder: (BuildContext context, int index) {
          final _FilterOption option = options[index];
          final bool isSelected = selectedFilter == option.status;

          return ChoiceChip(
            selected: isSelected,
            label: Text(
              option.label,
              style: AppTextStyles.caption.copyWith(
                color: isSelected ? AppColors.surface : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            selectedColor: AppColors.primary,
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.r24),
              side: BorderSide(
                color: isSelected ? AppColors.primary : AppColors.border,
                width: 1.2,
              ),
            ),
            onSelected: (bool selected) {
              onFilterChanged(option.status);
            },
          );
        },
      ),
    );
  }
}

class _FilterOption {
  final String label;
  final AssignmentStatus? status;

  const _FilterOption({
    required this.label,
    required this.status,
  });
}
