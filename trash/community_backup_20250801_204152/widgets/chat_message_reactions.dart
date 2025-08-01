import 'package:flutter/material.dart';
import '../../../utils/theme.dart';
import '../../../utils/mock_data.dart';

/// Message reactions widget with emoji counts and interaction
class ChatMessageReactions extends StatelessWidget {
  final Map<String, dynamic> message;
  final Function(String, String) onReactToMessage;

  const ChatMessageReactions({
    super.key,
    required this.message,
    required this.onReactToMessage,
  });

  @override
  Widget build(BuildContext context) {
    final reactions = message['reactions'] as Map<String, List<String>>? ?? {};
    if (reactions.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(left: 48, right: 16, bottom: 4),
      child: Wrap(
        spacing: 4,
        children: reactions.entries.map((entry) {
          final emoji = entry.key;
          final users = entry.value;
          final hasUserReacted = users.contains(MockData.currentUser.id);
          
          return GestureDetector(
            onTap: () => onReactToMessage(message['id'], emoji),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: hasUserReacted
                    ? AppTheme.moroccoGreen.withValues(alpha: 0.2)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: hasUserReacted
                      ? AppTheme.moroccoGreen
                      : Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 12)),
                  const SizedBox(width: 2),
                  Text(
                    users.length.toString(),
                    style: TextStyle(
                      fontSize: 10,
                      color: hasUserReacted
                          ? AppTheme.moroccoGreen
                          : AppTheme.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}