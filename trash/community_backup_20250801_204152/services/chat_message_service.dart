import '../../../utils/mock_data.dart';

/// Service for managing chat messages, filtering, and reactions
class ChatMessageService {
  /// Get initial mock messages for the room
  List<Map<String, dynamic>> getInitialMessages() {
    return [
      {
        'id': '1',
        'userId': 'user1',
        'userName': 'Ahmed Hassan',
        'userAvatar': 'https://i.pravatar.cc/150?img=1',
        'message':
            'Hey everyone! Just discovered this amazing café in Gueliz with 40% off until 6 PM!',
        'type': 'deal_alert',
        'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
        'dealInfo': {
          'venueName': 'Café Atlas',
          'discount': '40%',
          'validUntil': '6 PM today',
        },
      },
      {
        'id': '2',
        'userId': 'user2',
        'userName': 'Fatima Zahra',
        'userAvatar': 'https://i.pravatar.cc/150?img=2',
        'message': 'That sounds great! Is it the one near the Majorelle Garden?',
        'type': 'text',
        'timestamp': DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
      },
      {
        'id': '3',
        'userId': 'user1',
        'userName': 'Ahmed Hassan',
        'userAvatar': 'https://i.pravatar.cc/150?img=1',
        'message': 'Yes, exactly! The atmosphere is perfect for afternoon work sessions.',
        'type': 'text',
        'timestamp': DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
      },
      {
        'id': '4',
        'userId': 'user3',
        'userName': 'Youssef Alami',
        'userAvatar': 'https://i.pravatar.cc/150?img=3',
        'message': 'Anyone interested in forming a group? We could get the group discount!',
        'type': 'group_formation',
        'timestamp': DateTime.now().subtract(const Duration(hours: 1, minutes: 15)),
        'groupInfo': {
          'minSize': 4,
          'currentSize': 1,
          'additionalDiscount': '10%',
        },
      },
      {
        'id': '5',
        'userId': 'user4',
        'userName': 'Laila Benali',
        'userAvatar': 'https://i.pravatar.cc/150?img=4',
        'message': 'I\'m in! What time are you thinking?',
        'type': 'text',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 45)),
      },
      {
        'id': '6',
        'userId': 'user5',
        'userName': 'Omar Tazi',
        'userAvatar': 'https://i.pravatar.cc/150?img=5',
        'message': 'Count me in too! 🙋‍♂️',
        'type': 'text',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 30)),
      },
      {
        'id': '7',
        'userId': 'business_atlas',
        'userName': 'Café Atlas',
        'userAvatar': 'https://i.pravatar.cc/150?img=6',
        'message': 'Thank you all for the interest! 🙏 We have reserved a special section for DeadHour community members.',
        'type': 'business_message',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 15)),
        'isVerified': true,
        'businessInfo': {
          'category': 'Restaurant',
          'rating': 4.8,
          'specialOffer': 'Additional 5% off for groups of 4+'
        },
      },
      {
        'id': '8',
        'userId': 'user6',
        'userName': 'Khadija El Mansouri',
        'userAvatar': 'https://i.pravatar.cc/150?img=7',
        'message': 'Perfect! What time should we meet? I suggest 4 PM to get the full discount window.',
        'type': 'text',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 10)),
      },
      {
        'id': '9',
        'userId': 'user7',
        'userName': 'Rachid Benjelloun',
        'userAvatar': 'https://i.pravatar.cc/150?img=8',
        'message': '📍 Café Atlas Location: https://maps.app.goo.gl/xyz123',
        'type': 'location_share',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
        'locationInfo': {
          'name': 'Café Atlas',
          'address': 'Avenue Mohammed V, Gueliz, Marrakech',
          'walkingTime': '12 min from Majorelle Garden'
        },
      },
    ];
  }

  /// Create a new user message
  Map<String, dynamic> createUserMessage(String text) {
    return {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'userId': MockData.currentUser.id,
      'userName': MockData.currentUser.name,
      'userAvatar': MockData.currentUser.profilePicture,
      'message': text,
      'type': 'text',
      'timestamp': DateTime.now(),
    };
  }

  /// Filter messages based on type
  List<Map<String, dynamic>> getFilteredMessages(
      List<Map<String, dynamic>> messages, String filter) {
    switch (filter) {
      case 'deals':
        return messages
            .where((msg) =>
                msg['type'] == 'deal_alert' ||
                msg['dealInfo'] != null ||
                msg['message'].toLowerCase().contains('deal') ||
                msg['message'].toLowerCase().contains('discount'))
            .toList();
      case 'groups':
        return messages
            .where((msg) =>
                msg['type'] == 'group_formation' ||
                msg['groupInfo'] != null ||
                msg['message'].toLowerCase().contains('group') ||
                msg['message'].toLowerCase().contains('join'))
            .toList();
      case 'questions':
        return messages
            .where((msg) =>
                msg['message'].contains('?') ||
                msg['message'].toLowerCase().contains('help') ||
                msg['message'].toLowerCase().contains('question'))
            .toList();
      default:
        return messages;
    }
  }

  /// Toggle message reaction
  void toggleMessageReaction(
      List<Map<String, dynamic>> messages, String messageId, String emoji) {
    final messageIndex = messages.indexWhere((msg) => msg['id'] == messageId);
    if (messageIndex != -1) {
      final message = messages[messageIndex];
      final reactions = Map<String, List<String>>.from(message['reactions'] ?? {});

      if (reactions[emoji] == null) {
        reactions[emoji] = [];
      }

      final currentUserId = MockData.currentUser.id;
      if (reactions[emoji]!.contains(currentUserId)) {
        reactions[emoji]!.remove(currentUserId);
        if (reactions[emoji]!.isEmpty) {
          reactions.remove(emoji);
        }
      } else {
        reactions[emoji]!.add(currentUserId);
      }

      messages[messageIndex]['reactions'] = reactions;
    }
  }
}