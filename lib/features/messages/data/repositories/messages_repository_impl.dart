import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/conversation_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/messages_repository.dart';
import '../datasources/messages_local_data_source.dart';

/// Implementation of [MessagesRepository] accessing local data source.
class MessagesRepositoryImpl implements MessagesRepository {
  final MessagesLocalDataSource localDataSource;

  const MessagesRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<ConversationEntity>>> getConversations() async {
    try {
      final List<ConversationEntity> conversations =
          await localDataSource.getConversations();
      return Right<Failure, List<ConversationEntity>>(conversations);
    } catch (e) {
      return Left<Failure, List<ConversationEntity>>(
        ServerFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getMessages(
    String conversationId,
  ) async {
    try {
      final List<MessageEntity> messages =
          await localDataSource.getMessages(conversationId);
      return Right<Failure, List<MessageEntity>>(messages);
    } catch (e) {
      return Left<Failure, List<MessageEntity>>(
        ServerFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage(
    String conversationId,
    String text,
  ) async {
    try {
      await localDataSource.sendMessage(conversationId, text);
      return const Right<Failure, void>(null);
    } catch (e) {
      return Left<Failure, void>(
        ServerFailure(e.toString()),
      );
    }
  }
}
