import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:deadhour/screens/community/widgets/room_chat_app_bar.dart';
import 'package:deadhour/screens/community/widgets/room_info_banner.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:go_router/go_router.dart';
import '../../utils/mock_data.dart';

class RoomChatScreen extends StatefulWidget {
  final String roomId;

  const RoomChatScreen({
    super.key,
    required this.roomId,
  });

  @override
  State<RoomChatScreen> createState() => _RoomChatScreenState();
}

class _RoomChatScreenState extends State<RoomChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late dynamic _room;
  List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _loadRoom();
    _loadMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadRoom() {
    _room = MockData.rooms.firstWhere(
      (room) => room.id == widget.roomId,
      orElse: () => MockData.rooms.first,
    );
  }

  void _loadMessages() {
    // Mock messages for the room
    _messages = [
      {
        'id': '1',
        'userId': 'user1',
        'userName': 'Ahmed Hassan',
        'userAvatar': 'https://i.pravatar.cc/150?img=1',
        'message': 'Hey everyone! Just discovered this amazing café in Gueliz with 40% off until 6 PM!',
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoomChatAppBar(
        room: _room,
        onShowRoomInfo: _showRoomInfo,
        onShowRoomMenu: _showRoomMenu,
        getCategoryColor: (category) => _getCategoryColor(category),
      ),
      body: Column(
        children: [
          // Room info banner
          const RoomInfoBanner(),

          // Messages list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),

          // Typing indicator
          if (_isTyping) _buildTypingIndicator(),

          // Message input
          _buildMessageInput(),
        ],
      ),
    );
  }

  

  Widget _buildRoomInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.info_outline,
            size: 16,
            color: AppTheme.moroccoGreen,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Share deals, form groups, and discover amazing places together!',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.moroccoGreen,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    final isCurrentUser = message['userId'] == MockData.currentUser.id;

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
              crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
                _buildMessageBubble(message, isCurrentUser),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    _formatTime(message['timestamp']),
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
              backgroundImage: NetworkImage(MockData.currentUser.profilePicture),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message, bool isCurrentUser) {
    switch (message['type']) {
      case 'deal_alert':
        return _buildDealAlertBubble(message, isCurrentUser);
      case 'group_formation':
        return _buildGroupFormationBubble(message, isCurrentUser);
      default:
        return _buildTextBubble(message, isCurrentUser);
    }
  }

  Widget _buildTextBubble(Map<String, dynamic> message, bool isCurrentUser) {
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

  Widget _buildDealAlertBubble(Map<String, dynamic> message, bool isCurrentUser) {
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
                  onPressed: () => _bookDeal(dealInfo),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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

  Widget _buildGroupFormationBubble(Map<String, dynamic> message, bool isCurrentUser) {
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
                  onPressed: () => _joinGroup(groupInfo),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.info,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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

  Widget _buildTypingIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const SizedBox(width: 40), // Avatar space
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(0),
                const SizedBox(width: 4),
                _buildTypingDot(1),
                const SizedBox(width: 4),
                _buildTypingDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      width: 6,
      height: 6,
      decoration: const BoxDecoration(
        color: AppTheme.lightText,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildMessageInput() {
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
              onPressed: _showMessageOptions,
              icon: const Icon(Icons.add_circle_outline),
              color: AppTheme.moroccoGreen,
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
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
                onChanged: (text) {
                  // Simulate typing indicator
                  if (text.isNotEmpty && !_isTyping) {
                    setState(() => _isTyping = true);
                    Future.delayed(const Duration(seconds: 3), () {
                      if (mounted) setState(() => _isTyping = false);
                    });
                  }
                },
                onSubmitted: (text) => _sendMessage(text),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => _sendMessage(_messageController.text),
              icon: const Icon(Icons.send),
              color: AppTheme.moroccoGreen,
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'food':
        return AppColors.foodCategory;
      case 'entertainment':
        return AppColors.entertainmentCategory;
      case 'wellness':
        return AppColors.wellnessCategory;
      case 'sports':
        return AppColors.sportsCategory;
      case 'tourism':
        return AppColors.tourismCategory;
      case 'family':
        return AppColors.familyCategory;
      default:
        return AppTheme.moroccoGreen;
    }
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

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final newMessage = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'userId': MockData.currentUser.id,
      'userName': MockData.currentUser.name,
      'userAvatar': MockData.currentUser.profilePicture,
      'message': text.trim(),
      'type': 'text',
      'timestamp': DateTime.now(),
    };

    setState(() {
      _messages.add(newMessage);
      _messageController.clear();
    });

    // Auto-scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _showMessageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Share Content',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.local_fire_department, color: AppColors.error),
              title: const Text('Share Deal'),
              subtitle: const Text('Alert the room about a great deal'),
              onTap: () {
                Navigator.pop(context);
                _showShareDealDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.people, color: AppColors.info),
              title: const Text('Form Group'),
              subtitle: const Text('Create a group for better discounts'),
              onTap: () {
                Navigator.pop(context);
                _showFormGroupDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: AppColors.success),
              title: const Text('Share Location'),
              subtitle: const Text('Share a venue or meeting point'),
              onTap: () {
                Navigator.pop(context);
                _showShareLocationDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showShareDealDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Deal'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Venue Name',
                hintText: 'e.g., Café Atlas',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Discount',
                hintText: 'e.g., 40% off',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Valid Until',
                hintText: 'e.g., 6 PM today',
              ),
            ),
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
                  content: Text('Deal shared with the room!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Share'),
          ),
        ],
      ),
    );
  }

  void _showFormGroupDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Form Group'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Group Size Needed',
                hintText: 'e.g., 4 people',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Meeting Time',
                hintText: 'e.g., 3 PM today',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Additional Info',
                hintText: 'Any special requirements?',
              ),
              maxLines: 2,
            ),
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
                  content: Text('Group formation request sent!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showShareLocationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Location'),
        content: const Text('Location sharing not implemented in mockup'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showRoomInfo() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _getCategoryColor().withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          _room.categoryIcon,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _room.displayName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${_room.categoryName} • ${_room.city}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppTheme.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  _room.description,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildInfoStat(Icons.people, '${_room.memberCount}', 'Members'),
                    const SizedBox(width: 24),
                    _buildInfoStat(Icons.circle, '${_room.onlineCount}', 'Online'),
                    const SizedBox(width: 24),
                    _buildInfoStat(Icons.schedule, _room.lastActivityDisplay, 'Last Activity'),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 20, color: AppTheme.secondaryText),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.secondaryText,
          ),
        ),
      ],
    );
  }

  void _showRoomMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Room Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              subtitle: const Text('Manage room notifications'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Report Room'),
              subtitle: const Text('Report inappropriate content'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: AppColors.error),
              title: const Text('Leave Room'),
              subtitle: const Text('Leave this room'),
              onTap: () {
                Navigator.pop(context);
                _leaveRoom();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _bookDeal(Map<String, dynamic> dealInfo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Book Deal'),
        content: Text('Book deal at ${dealInfo['venueName']}?'),
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
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Book'),
          ),
        ],
      ),
    );
  }

  void _joinGroup(Map<String, dynamic> groupInfo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Join Group'),
        content: Text('Join this group for additional ${groupInfo['additionalDiscount']} discount?'),
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
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }

  void _leaveRoom() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Leave Room'),
        content: const Text('Are you sure you want to leave this room?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }
}
