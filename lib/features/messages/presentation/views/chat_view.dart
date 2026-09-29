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
import '../../domain/entities/conversation_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/chat_state.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/message_bubble.dart';

/// Screen displaying interactive chat messages for a specific conversation.
class ChatView extends StatelessWidget {
  final ConversationEntity conversation;

  const ChatView({
    super.key,
    required this.conversation,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatCubit>(
      create: (BuildContext context) =>
          sl<ChatCubit>()..loadMessages(conversation.id),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          centerTitle: false,
          title: conversation.contactName,
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: AppSizes.p16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.p8,
                    vertical: AppSizes.p4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.softGreen,
                    borderRadius: BorderRadius.circular(AppSizes.r8),
                  ),
                  child: Text(
                    conversation.contactRole,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (BuildContext context, ChatState state) {
                  if (state is ChatLoading) {
                    return const LoadingWidget();
                  }

                  if (state is ChatError) {
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
                                context
                                    .read<ChatCubit>()
                                    .loadMessages(conversation.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (state is ChatLoaded) {
                    if (state.messages.isEmpty) {
                      return const EmptyStateWidget(
                        title: 'لا توجد رسائل',
                        message: 'ابدأ المحادثة بكتابة إرسال أول رسالة.',
                        icon: Icons.chat_bubble_outline_rounded,
                      );
                    }

                    // We present messages reversed so latest messages are at the bottom.
                    final List<MessageEntity> reversedMessages =
                        state.messages.reversed.toList();

                    return ListView.separated(
                      reverse: true,
                      padding: const EdgeInsets.all(AppSizes.p16),
                      itemCount: reversedMessages.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: AppSizes.p8),
                      itemBuilder: (BuildContext context, int index) {
                        final MessageEntity message = reversedMessages[index];
                        return MessageBubble(message: message);
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
            BlocBuilder<ChatCubit, ChatState>(
              builder: (BuildContext context, ChatState state) {
                return ChatInputBar(
                  onSend: (text) {
                    context.read<ChatCubit>().sendMessage(text);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
