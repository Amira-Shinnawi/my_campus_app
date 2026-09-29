import 'package:equatable/equatable.dart';

/// Entity representing a chat conversation between student and instructor/admin.
class ConversationEntity extends Equatable {
  /// Unique conversation identifier.
  final String id;

  /// Contact full name.
  final String contactName;

  /// Contact title or role (e.g., "Doctor", "TA", "Academic Advisor").
  final String contactRole;

  /// Text of latest message in conversation.
  final String lastMessage;

  /// Timestamp of latest message.
  final DateTime lastMessageTime;

  /// Number of unread messages.
  final int unreadCount;

  /// Optional contact avatar image URL.
  final String? avatarUrl;

  const ConversationEntity({
    required this.id,
    required this.contactName,
    required this.contactRole,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    this.avatarUrl,
  });

  /// Returns 2-letter uppercase initials for avatar.
  String get initials {
    final List<String> parts = contactName.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return 'DR';
  }

  /// Creates a copy of [ConversationEntity] with updated fields.
  ConversationEntity copyWith({
    String? id,
    String? contactName,
    String? contactRole,
    String? lastMessage,
    DateTime? lastMessageTime,
    int? unreadCount,
    String? avatarUrl,
  }) {
    return ConversationEntity(
      id: id ?? this.id,
      contactName: contactName ?? this.contactName,
      contactRole: contactRole ?? this.contactRole,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        contactName,
        contactRole,
        lastMessage,
        lastMessageTime,
        unreadCount,
        avatarUrl,
      ];
}
