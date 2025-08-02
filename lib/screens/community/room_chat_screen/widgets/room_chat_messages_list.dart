import 'package:flutter/material.dart';
import 'package:deadhour/screens/community/widgets/chat_message_bubble.dart';
import 'package:deadhour/utils/mock_data.dart';

class RoomChatMessagesList extends StatelessWidget {
  final ScrollController scrollController;
  final List<Map<String, dynamic>> messages;
  final String messageFilter;
  final Function(DateTime) formatTime;
  final Function(Map<String, dynamic>) bookDeal;
  final Function(Map<String, dynamic>) joinGroup;
  final Widget Function(Map<String, dynamic>) buildMessageReactions;

  const RoomChatMessagesList({
    super.key,
    required this.scrollController,
    required this.messages,
    required this.messageFilter,
    required this.formatTime,
    required this.bookDeal,
    required this.joinGroup,
    required this.buildMessageReactions,
  });

  @override
  Widget build(BuildContext context) {
    final filteredMessages = _getFilteredMessages();
    
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: filteredMessages.length,
        itemBuilder: (context, index) {
          final message = filteredMessages[index];
          return Column(
            children: [
              ChatMessageBubble(
                message: message,
                isCurrentUser: message['userId'] == MockData.currentUser.id,
                formatTime: formatTime,
                bookDeal: bookDeal,
                joinGroup: joinGroup,
              ),
              // Show message reactions if any
              if (message['reactions'] != null)
                buildMessageReactions(message),
            ],
          );
        },
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredMessages() {
    switch (messageFilter) {
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
}