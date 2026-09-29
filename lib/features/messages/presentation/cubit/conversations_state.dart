import 'package:equatable/equatable.dart';

import '../../domain/entities/conversation_entity.dart';

/// Base state class for ConversationsCubit.
abstract class ConversationsState extends Equatable {
  const ConversationsState();

  @override
  List<Object?> get props => <Object?>[];
}

/// Initial state before fetching chat conversations.
class ConversationsInitial extends ConversationsState {
  const ConversationsInitial();
}

/// Loading state while fetching conversations.
class ConversationsLoading extends ConversationsState {
  const ConversationsLoading();
}

/// Loaded state containing list of chat conversations.
class ConversationsLoaded extends ConversationsState {
  final List<ConversationEntity> conversations;

  const ConversationsLoaded(this.conversations);

  @override
  List<Object?> get props => <Object?>[conversations];
}

/// Error state containing error message.
class ConversationsError extends ConversationsState {
  final String message;

  const ConversationsError(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}
