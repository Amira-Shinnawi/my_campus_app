import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

/// A bottom input bar for typing and sending chat messages.
class ChatInputBar extends StatefulWidget {
  /// Callback triggered when the user sends a non-empty message.
  final ValueChanged<String> onSend;

  const ChatInputBar({super.key, required this.onSend});

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  late final TextEditingController _controller;
  bool _isComposing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmitted() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    _controller.clear();
    setState(() {
      _isComposing = false;
    });

    widget.onSend(text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.p12,
        vertical: AppSizes.p8,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppSizes.r24),
                  border: Border.all(color: AppColors.border),
                ),
                // padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
                child: TextField(
                  controller: _controller,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (text) {
                    setState(() {
                      _isComposing = text.trim().isNotEmpty;
                    });
                  },
                  onSubmitted: (_) => _handleSubmitted(),
                  decoration: const InputDecoration(
                    hintText: 'Write message...',
                    hintStyle: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: AppSizes.p12,
                      horizontal: AppSizes.p16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSizes.p8),
            Material(
              color: _isComposing ? AppColors.primary : AppColors.border,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: _isComposing ? _handleSubmitted : null,
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.p12),
                  child: Icon(
                    Icons.send_rounded,
                    color: _isComposing ? Colors.white : AppColors.textMuted,
                    size: AppSizes.iconMd,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
