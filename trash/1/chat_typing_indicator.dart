import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

/// Typing indicator showing which users are currently typing
class ChatTypingIndicator extends StatelessWidget {
  final List<String> typingUsers;

  const ChatTypingIndicator({
    super.key,
    required this.typingUsers,
  });

  @override
  Widget build(BuildContext context) {
    if (typingUsers.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 20,
                  height: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTypingDot(0),
                      _buildTypingDot(200),
                      _buildTypingDot(400),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${typingUsers.join(', ')} ${typingUsers.length == 1 ? 'is' : 'are'} typing...',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int delay) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500 + delay),
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        color: AppTheme.moroccoGreen,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}