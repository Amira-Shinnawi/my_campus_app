import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/conversation_entity.dart';
import '../entities/message_entity.dart';

/// Abstract repository contract for student chat and message operations.
abstract class MessagesRepository {
  /// Fetches list of active chat conversations.
  Future<Either<Failure, List<ConversationEntity>>> getConversations();

  /// Fetches messages thread for a specific conversation by [conversationId].
  Future<Either<Failure, List<MessageEntity>>> getMessages(
    String conversationId,
  );

  /// Sends a new message in [conversationId].
  Future<Either<Failure, void>> sendMessage(
    String conversationId,
    String text,
  );
}
