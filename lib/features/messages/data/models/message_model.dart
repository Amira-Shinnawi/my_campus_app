import '../../domain/entities/message_entity.dart';

/// Data Transfer Object (DTO) model for individual chat message.
class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.conversationId,
    required super.text,
    required super.timestamp,
    required super.isSentByMe,
  });

  /// Factory constructor to parse JSON map to [MessageModel].
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      conversationId: json['conversation_id'] as String,
      text: json['text'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isSentByMe: json['is_sent_by_me'] as bool,
    );
  }

  /// Converts [MessageModel] instance into JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'conversation_id': conversationId,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'is_sent_by_me': isSentByMe,
    };
  }
}
