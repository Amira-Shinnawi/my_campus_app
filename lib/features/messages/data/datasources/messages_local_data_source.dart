import '../models/conversation_model.dart';
import '../models/message_model.dart';

/// Abstract data source interface for local messages and conversations.
abstract class MessagesLocalDataSource {
  /// Fetches list of active chat conversations.
  Future<List<ConversationModel>> getConversations();

  /// Fetches message thread for a specific conversation.
  Future<List<MessageModel>> getMessages(String conversationId);

  /// Appends a newly sent message to target conversation.
  Future<void> sendMessage(String conversationId, String text);
}

/// In-memory mutable implementation of [MessagesLocalDataSource].
class MessagesLocalDataSourceImpl implements MessagesLocalDataSource {
  MessagesLocalDataSourceImpl();

  final List<ConversationModel> _conversations = <ConversationModel>[
    ConversationModel(
      id: 'conv_1',
      contactName: 'Dr. Sarah Ahmed',
      contactRole: 'Doctor • Mobile Programming',
      lastMessage: 'Please review the Clean Architecture submission guide.',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 15)),
      unreadCount: 2,
    ),
    ConversationModel(
      id: 'conv_2',
      contactName: 'Prof. Mohamed Hassan',
      contactRole: 'Professor • Software Engineering',
      lastMessage: 'Your SRS document has been approved.',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 3)),
      unreadCount: 0,
    ),
    ConversationModel(
      id: 'conv_3',
      contactName: 'Eng. Nouran Ali',
      contactRole: 'TA • Database Systems Lab',
      lastMessage: 'Don\'t forget tomorrow\'s lab quiz at 12:30 PM.',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 1,
    ),
    ConversationModel(
      id: 'conv_4',
      contactName: 'Dr. Tarek Mahmoud',
      contactRole: 'Academic Advisor',
      lastMessage: 'Let\'s schedule a brief meeting regarding course registration.',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
      unreadCount: 0,
    ),
  ];

  final Map<String, List<MessageModel>> _messages = <String, List<MessageModel>>{
    'conv_1': <MessageModel>[
      MessageModel(
        id: 'm1',
        conversationId: 'conv_1',
        text: 'Good morning Dr. Sarah, I have a question regarding the Flutter assignment.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isSentByMe: true,
      ),
      MessageModel(
        id: 'm2',
        conversationId: 'conv_1',
        text: 'Good morning Amira! Sure, what is your question?',
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
        isSentByMe: false,
      ),
      MessageModel(
        id: 'm3',
        conversationId: 'conv_1',
        text: 'Should we include custom painters for the UI widgets?',
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
        isSentByMe: true,
      ),
      MessageModel(
        id: 'm4',
        conversationId: 'conv_1',
        text: 'Yes! Custom painters earn bonus points. Please review the Clean Architecture submission guide.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        isSentByMe: false,
      ),
    ],
    'conv_2': <MessageModel>[
      MessageModel(
        id: 'm5',
        conversationId: 'conv_2',
        text: 'Hello Prof. Mohamed, I submitted the SRS document yesterday.',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        isSentByMe: true,
      ),
      MessageModel(
        id: 'm6',
        conversationId: 'conv_2',
        text: 'Your SRS document has been approved.',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        isSentByMe: false,
      ),
    ],
    'conv_3': <MessageModel>[
      MessageModel(
        id: 'm7',
        conversationId: 'conv_3',
        text: 'Don\'t forget tomorrow\'s lab quiz at 12:30 PM.',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isSentByMe: false,
      ),
    ],
    'conv_4': <MessageModel>[
      MessageModel(
        id: 'm8',
        conversationId: 'conv_4',
        text: 'Let\'s schedule a brief meeting regarding course registration.',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        isSentByMe: false,
      ),
    ],
  };

  @override
  Future<List<ConversationModel>> getConversations() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return List<ConversationModel>.from(_conversations);
  }

  @override
  Future<List<MessageModel>> getMessages(String conversationId) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return List<MessageModel>.from(_messages[conversationId] ?? <MessageModel>[]);
  }

  @override
  Future<void> sendMessage(String conversationId, String text) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    final MessageModel newMsg = MessageModel(
      id: 'm_${DateTime.now().millisecondsSinceEpoch}',
      conversationId: conversationId,
      text: text,
      timestamp: DateTime.now(),
      isSentByMe: true,
    );

    _messages.putIfAbsent(conversationId, () => <MessageModel>[]).add(newMsg);

    // Update conversation last message in list
    final int convIndex =
        _conversations.indexWhere((ConversationModel c) => c.id == conversationId);
    if (convIndex != -1) {
      _conversations[convIndex] = _conversations[convIndex].copyWith(
        lastMessage: text,
        lastMessageTime: DateTime.now(),
        unreadCount: 0,
      );
    }
  }
}
