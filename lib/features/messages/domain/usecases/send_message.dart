import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/messages_repository.dart';
import 'send_message_params.dart';

/// Use case for sending a new message in a conversation.
class SendMessage implements UseCase<void, SendMessageParams> {
  final MessagesRepository repository;

  const SendMessage(this.repository);

  @override
  Future<Either<Failure, void>> call(SendMessageParams params) async {
    return repository.sendMessage(params.conversationId, params.text);
  }
}
