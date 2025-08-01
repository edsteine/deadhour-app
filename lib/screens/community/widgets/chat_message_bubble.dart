import 'package:flutter/material.dart';

import '../../../utils/mock_data.dart';
import '../../../utils/theme.dart';

class ChatMessageBubble extends StatelessWidget {
  final Map<String, dynamic> message;
  final bool isCurrentUser;
  final Function(DateTime) formatTime;
  final Function(Map<String, dynamic>) bookDeal;
  final Function(Map<String, dynamic>) joinGroup;

  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.formatTime,
    required this.bookDeal,
    required this.joinGroup,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isCurrentUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(message['userAvatar']),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: isCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (!isCurrentUser)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      message['userName'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                  ),
                _buildMessageBubble(context),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    formatTime(message['timestamp']),
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppTheme.lightText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isCurrentUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundImage:
                  NetworkImage(MockData.currentUser.profilePicture),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context) {
    switch (message['type']) {
      case 'deal_alert':
        return _buildDealAlertBubble(context);
      case 'group_formation':
        return _buildGroupFormationBubble(context);
      default:
        return _buildTextBubble();
    }
  }

  Widget _buildTextBubble() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isCurrentUser ? AppTheme.moroccoGreen : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16).copyWith(
          bottomRight: isCurrentUser ? const Radius.circular(4) : null,
          bottomLeft: !isCurrentUser ? const Radius.circular(4) : null,
        ),
      ),
      child: Text(
        message['message'],
        style: TextStyle(
          fontSize: 14,
          color: isCurrentUser ? Colors.white : AppTheme.primaryText,
        ),
      ),
    );
  }

  Widget _buildDealAlertBubble(BuildContext context) {
    final dealInfo = message['dealInfo'];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'DEAL ALERT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                dealInfo['discount'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            message['message'],
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dealInfo['venueName'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Valid until ${dealInfo['validUntil']}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppTheme.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => bookDeal(dealInfo),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    minimumSize: Size.zero,
                  ),
                  child: const Text(
                    'Book',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupFormationBubble(BuildContext context) {
    final groupInfo = message['groupInfo'];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.1),
        border: Border.all(color: AppColors.info.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.info,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'GROUP FORMING',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '+${groupInfo['additionalDiscount']}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.info,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            message['message'],
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${groupInfo['currentSize']}/${groupInfo['minSize']} people',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Additional ${groupInfo['additionalDiscount']} group discount',
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppTheme.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => joinGroup(groupInfo),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.info,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    minimumSize: Size.zero,
                  ),
                  child: const Text(
                    'Join',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
