import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

import 'package:deadhour/utils/mock_data.dart';



/// Scrollable list of chat messages with reactions
class ChatMessagesList extends StatelessWidget {
  final ScrollController scrollController;
  final List<Map<String, dynamic>> messages;
  final Function(String, String) onReactToMessage;

  const ChatMessagesList({
    super.key,
    required this.scrollController,
    required this.messages,
    required this.onReactToMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return Column(
            children: [
              ChatMessageBubble(
                message: message,
                isCurrentUser: message['userId'] == MockData.currentUser.id,
                formatTime: _formatTime,
                bookDeal: (dealInfo) => _bookDeal(context, dealInfo),
                joinGroup: (groupInfo) => _joinGroup(context, groupInfo),
              ),
              // Show message reactions if any
              if (message['reactions'] != null)
                ChatMessageReactions(
                  message: message,
                  onReactToMessage: onReactToMessage,
                ),
            ],
          );
        },
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}d';
    }
  }

  void _bookDeal(BuildContext context, Map<String, dynamic> dealInfo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Book Deal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Venue: ${dealInfo['venueName']}'),
            Text('Discount: ${dealInfo['discount']}'),
            Text('Valid until: ${dealInfo['validUntil']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Deal booked successfully!'),
                  backgroundColor: AppTheme.moroccoGreen,
                ),
              );
            },
            child: const Text('Book Now'),
          ),
        ],
      ),
    );
  }

  void _joinGroup(BuildContext context, Map<String, dynamic> groupInfo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Join Group'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Group size: ${groupInfo['currentSize']}/${groupInfo['minSize']}'),
            Text('Additional discount: ${groupInfo['additionalDiscount']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Joined group successfully!'),
                  backgroundColor: AppTheme.moroccoGreen,
                ),
              );
            },
            child: const Text('Join Group'),
          ),
        ],
      ),
    );
  }
}