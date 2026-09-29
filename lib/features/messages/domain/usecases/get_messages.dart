import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/message_entity.dart';
import '../repositories/messages_repository.dart';

/// Use case for retrieving message thread for a conversation.
class GetMessages implements UseCase<List<MessageEntity>, String> {
  final MessagesRepository repository;

  const GetMessages(this.repository);

  @override
  Future<Either<Failure, List<MessageEntity>>> call(
    String conversationId,
  ) async {
    return repository.getMessages(conversationId);
  }
}
