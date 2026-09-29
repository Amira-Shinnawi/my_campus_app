import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/conversation_entity.dart';
import '../repositories/messages_repository.dart';

/// Use case for retrieving student chat conversations.
class GetConversations
    implements UseCase<List<ConversationEntity>, NoParams> {
  final MessagesRepository repository;

  const GetConversations(this.repository);

  @override
  Future<Either<Failure, List<ConversationEntity>>> call(
    NoParams params,
  ) async {
    return repository.getConversations();
  }
}
