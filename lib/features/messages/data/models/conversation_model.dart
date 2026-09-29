import '../../domain/entities/conversation_entity.dart';

/// Data Transfer Object (DTO) model for chat conversation.
class ConversationModel extends ConversationEntity {
  const ConversationModel({
    required super.id,
    required super.contactName,
    required super.contactRole,
    required super.lastMessage,
    required super.lastMessageTime,
    required super.unreadCount,
    super.avatarUrl,
  });

  /// Factory constructor to parse JSON map to [ConversationModel].
  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] as String,
      contactName: json['contact_name'] as String,
      contactRole: json['contact_role'] as String,
      lastMessage: json['last_message'] as String,
      lastMessageTime: DateTime.parse(json['last_message_time'] as String),
      unreadCount: json['unread_count'] as int,
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  /// Converts [ConversationModel] instance into JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'contact_name': contactName,
      'contact_role': contactRole,
      'last_message': lastMessage,
      'last_message_time': lastMessageTime.toIso8601String(),
      'unread_count': unreadCount,
      'avatar_url': avatarUrl,
    };
  }

  @override
  ConversationModel copyWith({
    String? id,
    String? contactName,
    String? contactRole,
    String? lastMessage,
    DateTime? lastMessageTime,
    int? unreadCount,
    String? avatarUrl,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      contactName: contactName ?? this.contactName,
      contactRole: contactRole ?? this.contactRole,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
