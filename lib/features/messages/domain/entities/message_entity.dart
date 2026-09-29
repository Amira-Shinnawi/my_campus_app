import 'package:equatable/equatable.dart';

/// Entity representing an individual chat message in a conversation.
class MessageEntity extends Equatable {
  /// Unique message identifier.
  final String id;

  /// Associated conversation identifier.
  final String conversationId;

  /// Text message content.
  final String text;

  /// Message timestamp.
  final DateTime timestamp;

  /// Whether message was sent by the current student.
  final bool isSentByMe;

  const MessageEntity({
    required this.id,
    required this.conversationId,
    required this.text,
    required this.timestamp,
    required this.isSentByMe,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        conversationId,
        text,
        timestamp,
        isSentByMe,
      ];
}
