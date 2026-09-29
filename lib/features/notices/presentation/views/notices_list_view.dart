import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/notice_entity.dart';
import '../cubit/notices_cubit.dart';
import '../cubit/notices_state.dart';
import '../widgets/notice_card.dart';

/// Screen view displaying campus notices list with state handling.
class NoticesListView extends StatelessWidget {
  const NoticesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoticesCubit>(
      create: (BuildContext context) => sl<NoticesCubit>()..fetchNotices(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          title: 'Notices',
          isBack: false,
         
        ),
        body: BlocBuilder<NoticesCubit, NoticesState>(
          builder: (BuildContext context, NoticesState state) {
            if (state is NoticesLoading) {
              return const LoadingWidget();
            }

            if (state is NoticesError) {
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
                          context.read<NoticesCubit>().fetchNotices();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is NoticesLoaded) {
              if (state.notices.isEmpty) {
                return const EmptyStateWidget(
                  title: 'No Notices Available',
                  message:
                      'Check back later for university updates and notices.',
                  icon: Icons.notifications_off_outlined,
                );
              }

              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () async {
                  await context.read<NoticesCubit>().fetchNotices();
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(AppSizes.p16),
                  itemCount: state.notices.length,
                  itemBuilder: (BuildContext context, int index) {
                    final NoticeEntity notice = state.notices[index];
                    return NoticeCard(
                      notice: notice,
                      onTap: () {
                        context.push('/notices/details', extra: notice);
                      },
                    );
                  },
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
