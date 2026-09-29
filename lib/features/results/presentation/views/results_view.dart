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
import '../../domain/entities/result_entity.dart';
import '../cubit/results_cubit.dart';
import '../cubit/results_state.dart';
import '../widgets/gpa_ring_card.dart';
import '../widgets/result_card.dart';

/// Main screen view displaying student academic results and GPA statistics.
class ResultsView extends StatelessWidget {
  const ResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResultsCubit>(
      create: (BuildContext context) => sl<ResultsCubit>()..fetchResults(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const CustomAppBar(title: 'Academic Results'),
        body: BlocBuilder<ResultsCubit, ResultsState>(
          builder: (BuildContext context, ResultsState state) {
            if (state is ResultsLoading) {
              return const LoadingWidget();
            }

            if (state is ResultsError) {
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
                          context.read<ResultsCubit>().fetchResults();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is ResultsLoaded) {
              if (state.allResults.isEmpty) {
                return const EmptyStateWidget(
                  title: 'No Grades Released',
                  message: 'Your academic results will appear here once published.',
                  icon: Icons.workspace_premium_outlined,
                );
              }

              final List<ResultEntity> currentResults = state.filteredResults;
              final List<String> semesters = state.availableSemesters;

              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () async {
                  await context.read<ResultsCubit>().fetchResults();
                },
                child: ListView(
                  padding: const EdgeInsets.all(AppSizes.p16),
                  children: <Widget>[
                    // GPA Ring Overview Card
                    GpaRingCard(
                      gpa: state.gpa,
                      totalCredits: state.totalCreditHours,
                      totalSubjects: currentResults.length,
                    ),
                    const SizedBox(height: AppSizes.p20),

                    // Semester Filter Row
                    SizedBox(
                      height: 40.0,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: semesters.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: AppSizes.p8),
                        itemBuilder: (context, index) {
                          final String semester = semesters[index];
                          final bool isSelected = semester.toLowerCase() ==
                              state.selectedSemester.toLowerCase();

                          return FilterChip(
                            selected: isSelected,
                            label: Text(
                              semester,
                              style: AppTextStyles.caption.copyWith(
                                color: isSelected
                                    ? AppColors.surface
                                    : AppColors.textPrimary,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            selectedColor: AppColors.primary,
                            backgroundColor: AppColors.surface,
                            onSelected: (bool selected) {
                              context
                                  .read<ResultsCubit>()
                                  .selectSemester(semester);
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: AppSizes.p16),

                    // Section Title: Subject Results List
                    Text(
                      'Course Performance',
                      style: AppTextStyles.headlineMedium.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSizes.p12),

                    // Subject Cards List
                    ...currentResults.map(
                      (ResultEntity item) => ResultCard(result: item),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
