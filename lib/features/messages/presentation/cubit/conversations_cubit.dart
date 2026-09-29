import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/conversation_entity.dart';
import '../../domain/usecases/get_conversations.dart';
import 'conversations_state.dart';

/// Cubit managing state for student conversations list screen.
class ConversationsCubit extends Cubit<ConversationsState> {
  final GetConversations getConversations;

  ConversationsCubit({required this.getConversations})
      : super(const ConversationsInitial());

  /// Fetches conversations list from repository.
  Future<void> fetchConversations() async {
    emit(const ConversationsLoading());

    final result = await getConversations(NoParams());

    result.fold(
      (failure) => emit(ConversationsError(failure.message)),
      (List<ConversationEntity> list) {
        emit(ConversationsLoaded(list));
      },
    );
  }

  /// Alias for fetchConversations.
  Future<void> loadConversations() => fetchConversations();
}
