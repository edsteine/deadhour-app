import 'package:flutter/material.dart';
import '../../../../utils/theme.dart';

class RoomChatScrollFab extends StatelessWidget {
  final bool showScrollToBottom;
  final VoidCallback onScrollToBottom;

  const RoomChatScrollFab({
    super.key,
    required this.showScrollToBottom,
    required this.onScrollToBottom,
  });

  @override
  Widget build(BuildContext context) {
    if (!showScrollToBottom) return const SizedBox.shrink();

    return FloatingActionButton.small(
      onPressed: onScrollToBottom,
      backgroundColor: AppTheme.moroccoGreen,
      child: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
    );
  }
}