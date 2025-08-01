import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';


class MessageInput extends StatelessWidget {
  final TextEditingController messageController;
  final Function() onShowMessageOptions;
  final Function(String) onSendMessage;
  final Function(String) onChanged;

  const MessageInput({
    super.key,
    required this.messageController,
    required this.onShowMessageOptions,
    required this.onSendMessage,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              onPressed: onShowMessageOptions,
              icon: const Icon(Icons.add_circle_outline),
              color: AppTheme.moroccoGreen,
            ),
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppTheme.surfaceColor,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                onChanged: onChanged,
                onSubmitted: onSendMessage,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => onSendMessage(messageController.text),
              icon: const Icon(Icons.send),
              color: AppTheme.moroccoGreen,
            ),
          ],
        ),
      ),
    );
  }
}
