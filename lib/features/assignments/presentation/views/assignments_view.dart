import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/assignment_entity.dart';
import '../../domain/entities/assignment_status.dart';
import '../cubit/assignments_cubit.dart';
import '../cubit/assignments_state.dart';
import '../widgets/assignment_card.dart';
import '../widgets/assignment_filter_chips.dart';

/// Main screen view displaying student assignments task list with interactive status updates.
class AssignmentsView extends StatelessWidget {
  const AssignmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AssignmentsCubit>(
      create: (BuildContext context) =>
          sl<AssignmentsCubit>()..loadAssignments(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const CustomAppBar(title: 'Assignments'),
        body: BlocBuilder<AssignmentsCubit, AssignmentsState>(
          builder: (BuildContext context, AssignmentsState state) {
            if (state is AssignmentsLoading) {
              return const LoadingWidget();
            }

            if (state is AssignmentsError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.p24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.error_outline_rounded,
                        color: AppColors.error,
                        size: AppSizes.iconXl,
                      ),
                      const SizedBox(height: AppSizes.p16),
                      Text(
                        state.message,
                        style: AppTextStyles.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSizes.p24),
                      CustomButton(
                        text: 'Retry',
                        onPressed: () {
                          context.read<AssignmentsCubit>().loadAssignments();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is AssignmentsLoaded) {
              final List<AssignmentEntity> currentAssignments =
                  state.filteredAssignments;

              return Column(
                children: <Widget>[
                  const SizedBox(height: AppSizes.p12),

                  // Filter Chips Bar
                  AssignmentFilterChips(
                    selectedFilter: state.filter,
                    onFilterChanged: (AssignmentStatus? filter) {
                      context.read<AssignmentsCubit>().changeFilter(filter);
                    },
                  ),
                  const SizedBox(height: AppSizes.p12),

                  // Assignments List
                  Expanded(
                    child: currentAssignments.isEmpty
                        ? const EmptyStateWidget(
                            title: 'No Assignments Found',
                            message: 'You have no assignments matching this status.',
                            icon: Icons.assignment_turned_in_outlined,
                          )
                        : RefreshIndicator(
                            color: AppColors.primary,
                            onRefresh: () async {
                              await context
                                  .read<AssignmentsCubit>()
                                  .loadAssignments();
                            },
                            child: ListView.builder(
                              padding: const EdgeInsets.all(AppSizes.p16),
                              itemCount: currentAssignments.length,
                              itemBuilder: (BuildContext context, int index) {
                                final AssignmentEntity item =
                                    currentAssignments[index];
                                return AssignmentCard(
                                  assignment: item,
                                  onMarkSubmitted: () {
                                    context
                                        .read<AssignmentsCubit>()
                                        .markAsSubmitted(item.id);

                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${item.title} marked as Submitted! 🎉',
                                        ),
                                        backgroundColor: AppColors.primary,
                                        behavior: SnackBarBehavior.floating,
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
