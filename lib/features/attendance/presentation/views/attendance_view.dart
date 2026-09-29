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
import '../../domain/entities/attendance_record_entity.dart';
import '../../domain/entities/subject_attendance_entity.dart';
import '../cubit/attendance_cubit.dart';
import '../cubit/attendance_state.dart';
import '../widgets/attendance_record_tile.dart';
import '../widgets/overall_attendance_card.dart';
import '../widgets/subject_attendance_card.dart';

/// Main screen view for student attendance analytics and records.
class AttendanceView extends StatelessWidget {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AttendanceCubit>(
      create: (BuildContext context) =>
          sl<AttendanceCubit>()..fetchAttendance(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const CustomAppBar(title: 'Attendance'),
        body: BlocBuilder<AttendanceCubit, AttendanceState>(
          builder: (BuildContext context, AttendanceState state) {
            if (state is AttendanceLoading) {
              return const LoadingWidget();
            }

            if (state is AttendanceError) {
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
                          context.read<AttendanceCubit>().fetchAttendance();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is AttendanceLoaded) {
              if (state.records.isEmpty) {
                return const EmptyStateWidget(
                  title: 'No Attendance Records',
                  message: 'Attendance logs will appear here once recorded.',
                  icon: Icons.fact_check_outlined,
                );
              }

              final List<SubjectAttendanceEntity> summaries =
                  state.subjectSummaries;

              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () async {
                  await context.read<AttendanceCubit>().fetchAttendance();
                },
                child: ListView(
                  padding: const EdgeInsets.all(AppSizes.p16),
                  children: <Widget>[
                    // Top Overall Attendance Ring Card
                    OverallAttendanceCard(
                      percentage: state.overallPercentage,
                      presentCount: state.presentCount,
                      lateCount: state.lateCount,
                      absentCount: state.absentCount,
                    ),
                    const SizedBox(height: AppSizes.p20),

                    // Section Title: Per-Subject Breakdown
                    Text(
                      'Subject Breakdown',
                      style: AppTextStyles.headlineMedium.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSizes.p12),

                    // Subject Cards List
                    ...summaries.map(
                      (SubjectAttendanceEntity summary) =>
                          SubjectAttendanceCard(subjectSummary: summary),
                    ),
                    const SizedBox(height: AppSizes.p16),

                    // Section Title: Recent History Logs
                    Text(
                      'Recent Session Logs',
                      style: AppTextStyles.headlineMedium.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSizes.p12),

                    // Recent 5 log records
                    ...state.records.take(6).map(
                          (AttendanceRecordEntity record) =>
                              AttendanceRecordTile(record: record),
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
