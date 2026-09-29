import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/conversation_entity.dart';
import '../cubit/conversations_cubit.dart';
import '../cubit/conversations_state.dart';
import '../widgets/conversation_card.dart';

/// Screen displaying the list of all chat conversations for the student.
class ConversationsListView extends StatelessWidget {
  const ConversationsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConversationsCubit>(
      create: (BuildContext context) =>
          sl<ConversationsCubit>()..loadConversations(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const CustomAppBar(title: 'Messages',isBack: false,),
        body: BlocBuilder<ConversationsCubit, ConversationsState>(
          builder: (BuildContext context, ConversationsState state) {
            if (state is ConversationsLoading) {
              return const LoadingWidget();
            }

            if (state is ConversationsError) {
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
                        text: 'إعادة المحاولة',
                        onPressed: () {
                          context.read<ConversationsCubit>().loadConversations();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is ConversationsLoaded) {
              if (state.conversations.isEmpty) {
                return const EmptyStateWidget(
                  title: 'لا توجد محادثات',
                  message: 'لم تبدأ أي محادثة مع أعضاء هيئة التدريس بعد.',
                  icon: Icons.chat_bubble_outline_rounded,
                );
              }

              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () async {
                  await context.read<ConversationsCubit>().loadConversations();
                },
                child: ListView.separated(
                  padding: const EdgeInsets.all(AppSizes.p16),
                  itemCount: state.conversations.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppSizes.p12),
                  itemBuilder: (BuildContext context, int index) {
                    final ConversationEntity conversation =
                        state.conversations[index];
                    return ConversationCard(
                      conversation: conversation,
                      onTap: () async {
                        await context.push(
                          AppRouter.chatPath,
                          extra: conversation,
                        );
                        if (context.mounted) {
                          context
                              .read<ConversationsCubit>()
                              .loadConversations();
                        }
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
