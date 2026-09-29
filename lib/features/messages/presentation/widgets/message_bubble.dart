import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/message_entity.dart';

/// Chat message bubble widget styled differently based on sender.
class MessageBubble extends StatelessWidget {
  final MessageEntity message;

  const MessageBubble({
    super.key,
    required this.message,
  });

  String _formatTime(DateTime time) {
    final int hour = time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
    final String period = time.hour >= 12 ? 'PM' : 'AM';
    final String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final bool isMe = message.isSentByMe;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: AppSizes.p12,
          left: isMe ? 48.0 : 0,
          right: isMe ? 0 : 48.0,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p16,
          vertical: AppSizes.p12,
        ),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppSizes.r16),
            topRight: const Radius.circular(AppSizes.r16),
            bottomLeft: Radius.circular(isMe ? AppSizes.r16 : AppSizes.r4),
            bottomRight: Radius.circular(isMe ? AppSizes.r4 : AppSizes.r16),
          ),
          border: isMe
              ? null
              : Border.all(
                  color: AppColors.border.withValues(alpha: 0.6),
                ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message.text,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isMe ? AppColors.surface : AppColors.textPrimary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  _formatTime(message.timestamp),
                  style: AppTextStyles.caption.copyWith(
                    color: isMe
                        ? AppColors.surface.withValues(alpha: 0.75)
                        : AppColors.textMuted,
                    fontSize: 10.0,
                  ),
                ),
                if (isMe) ...<Widget>[
                  const SizedBox(width: 4.0),
                  Icon(
                    Icons.done_all_rounded,
                    size: 14.0,
                    color: AppColors.surface.withValues(alpha: 0.85),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
