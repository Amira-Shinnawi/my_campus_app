import 'package:equatable/equatable.dart';

import '../../domain/entities/message_entity.dart';

/// Base state class for ChatCubit.
abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => <Object?>[];
}

/// Initial state before fetching chat message thread.
class ChatInitial extends ChatState {
  const ChatInitial();
}

/// Loading state while fetching message thread.
class ChatLoading extends ChatState {
  const ChatLoading();
}

/// Loaded state containing messages thread for target conversation.
class ChatLoaded extends ChatState {
  final List<MessageEntity> messages;

  const ChatLoaded(this.messages);

  @override
  List<Object?> get props => <Object?>[messages];
}

/// Error state containing error message.
class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}
