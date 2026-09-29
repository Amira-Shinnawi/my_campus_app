import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/message_entity.dart';
import '../../domain/usecases/get_messages.dart';
import '../../domain/usecases/send_message.dart';
import '../../domain/usecases/send_message_params.dart';
import 'chat_state.dart';

/// Cubit managing state for an active chat message thread.
class ChatCubit extends Cubit<ChatState> {
  final GetMessages getMessages;
  final SendMessage sendMessageUseCase;

  ChatCubit({
    required this.getMessages,
    required this.sendMessageUseCase,
  }) : super(const ChatInitial());

  String? _activeConversationId;

  /// Loads message thread for [conversationId].
  Future<void> loadMessages(String conversationId) async {
    _activeConversationId = conversationId;
    emit(const ChatLoading());

    final result = await getMessages(conversationId);

    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (List<MessageEntity> messages) {
        emit(ChatLoaded(messages));
      },
    );
  }

  /// Sends a new text message and optimistically updates local thread state.
  Future<void> sendMessage(String text, [String? conversationId]) async {
    final String targetConversationId =
        conversationId ?? _activeConversationId ?? '';
    if (text.trim().isEmpty || targetConversationId.isEmpty) {
      return;
    }

    final String trimmedText = text.trim();

    // Optimistically update local thread if in ChatLoaded state
    if (state is ChatLoaded) {
      final ChatLoaded currentState = state as ChatLoaded;
      final MessageEntity optimisticMsg = MessageEntity(
        id: 'msg_opt_${DateTime.now().millisecondsSinceEpoch}',
        conversationId: targetConversationId,
        text: trimmedText,
        timestamp: DateTime.now(),
        isSentByMe: true,
      );

      final List<MessageEntity> updatedMessages =
          List<MessageEntity>.from(currentState.messages)..add(optimisticMsg);

      emit(ChatLoaded(updatedMessages));
    }

    final result = await sendMessageUseCase(
      SendMessageParams(
        conversationId: targetConversationId,
        text: trimmedText,
      ),
    );

    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (_) {
        // Successfully sent
      },
    );
  }
}
