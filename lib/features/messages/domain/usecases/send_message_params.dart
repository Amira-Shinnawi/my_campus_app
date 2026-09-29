import 'package:equatable/equatable.dart';

/// Value parameters for sending a new chat message.
class SendMessageParams extends Equatable {
  /// Conversation identifier.
  final String conversationId;

  /// Text content of message.
  final String text;

  const SendMessageParams({
    required this.conversationId,
    required this.text,
  });

  @override
  List<Object?> get props => <Object?>[conversationId, text];
}
