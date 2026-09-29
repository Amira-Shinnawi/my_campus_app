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
import '../../domain/entities/class_entity.dart';
import '../cubit/classes_cubit.dart';
import '../cubit/classes_state.dart';
import '../widgets/class_card.dart';
import '../widgets/day_selector.dart';

/// Main screen view for displaying student class schedule and timetable.
class ClassesView extends StatelessWidget {
  const ClassesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClassesCubit>(
      create: (BuildContext context) => sl<ClassesCubit>()..fetchClasses(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const CustomAppBar(title: 'Class Schedule'),
        body: BlocBuilder<ClassesCubit, ClassesState>(
          builder: (BuildContext context, ClassesState state) {
            if (state is ClassesLoading) {
              return const LoadingWidget();
            }

            if (state is ClassesError) {
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
                          context.read<ClassesCubit>().fetchClasses();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is ClassesLoaded) {
              final List<ClassEntity> currentClasses = state.filteredClasses;

              return Column(
                children: <Widget>[
                  const SizedBox(height: AppSizes.p12),
                  // Day selector tabs
                  DaySelector(
                    days: ClassesCubit.availableDays,
                    selectedDay: state.selectedDay,
                    onDaySelected: (String day) {
                      context.read<ClassesCubit>().selectDay(day);
                    },
                  ),
                  const SizedBox(height: AppSizes.p12),

                  // Classes list view for selected day
                  Expanded(
                    child: currentClasses.isEmpty
                        ? EmptyStateWidget(
                            title: 'No Classes Today 🎉',
                            message:
                                'No lectures or labs scheduled for ${state.selectedDay}.',
                            icon: Icons.event_available_outlined,
                          )
                        : RefreshIndicator(
                            color: AppColors.primary,
                            onRefresh: () async {
                              await context.read<ClassesCubit>().fetchClasses();
                            },
                            child: ListView.builder(
                              padding: const EdgeInsets.all(AppSizes.p16),
                              itemCount: currentClasses.length,
                              itemBuilder: (BuildContext context, int index) {
                                final ClassEntity item = currentClasses[index];
                                return ClassCard(classEntity: item);
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
