import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';

class RoomChatTypingIndicator extends StatelessWidget {
  final List<String> typingUsers;

  const RoomChatTypingIndicator({
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
                _buildTypingAnimation(),
                const SizedBox(width: 8),
                Text(
                  _getTypingText(),
                  style: const TextStyle(
                    color: AppTheme.secondaryText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingAnimation() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Container(
          margin: EdgeInsets.only(right: index < 2 ? 2 : 0),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 400 + (index * 200)),
            opacity: 1.0,
            child: Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: AppTheme.secondaryText,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      }),
    );
  }

  String _getTypingText() {
    if (typingUsers.length == 1) {
      return '${typingUsers.first} is typing...';
    } else if (typingUsers.length == 2) {
      return '${typingUsers.first} and ${typingUsers.last} are typing...';
    } else {
      return '${typingUsers.length} people are typing...';
    }
  }
}