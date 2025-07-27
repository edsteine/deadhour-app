import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deadhour/screens/community/widgets/room_chat_app_bar.dart';
import 'package:deadhour/screens/community/widgets/room_info_banner.dart';
import 'package:deadhour/screens/community/widgets/chat_message_bubble.dart';
import 'package:deadhour/screens/community/widgets/typing_indicator.dart';
import 'package:deadhour/screens/community/widgets/message_input.dart';
import 'package:deadhour/screens/community/utils/room_chat_dialog_helpers.dart';
import 'package:deadhour/screens/community/utils/room_chat_bottom_sheet_helpers.dart';
import '../../utils/theme.dart';
import '../../utils/mock_data.dart';
import '../../utils/auth_helpers.dart';

class RoomChatScreen extends ConsumerStatefulWidget {
  final String roomId;

  const RoomChatScreen({
    super.key,
    required this.roomId,
  });

  @override
  ConsumerState<RoomChatScreen> createState() => _RoomChatScreenState();
}

class _RoomChatScreenState extends ConsumerState<RoomChatScreen> {
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
        onShowRoomInfo: () => RoomChatBottomSheetHelpers.showRoomInfo(context, _room, _getCategoryColor, _buildInfoStat),
        onShowRoomMenu: () => RoomChatBottomSheetHelpers.showRoomMenu(context, _leaveRoom),
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
                return ChatMessageBubble(
                  message: _messages[index],
                  isCurrentUser: _messages[index]['userId'] == MockData.currentUser.id,
                  formatTime: _formatTime,
                  bookDeal: _bookDeal,
                  joinGroup: _joinGroup,
                );
              },
            ),
          ),

          // Typing indicator
          if (_isTyping) TypingIndicator(isTyping: _isTyping),

          // Message input
          MessageInput(
            messageController: _messageController,
            onShowMessageOptions: _showMessageOptions,
            onSendMessage: _sendMessage,
            onChanged: (text) {
              if (text.isNotEmpty && !_isTyping) {
                setState(() => _isTyping = true);
                Future.delayed(const Duration(seconds: 3), () {
                  if (mounted) setState(() => _isTyping = false);
                });
              }
            },
          ),
        ],
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

  void _leaveRoom() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Leave Room'),
        content: Text('Are you sure you want to leave ${_room.displayName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Left ${_room.displayName}'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }

  void _bookDeal(Map<String, dynamic> dealInfo) {
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
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Book Now'),
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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Group size: ${groupInfo['currentSize']}/${groupInfo['minSize']}'),
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
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Join Group'),
          ),
        ],
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
    
    // Check if user is authenticated before allowing message sending
    if (!AuthHelpers.requireAuthForCommunity(context, ref)) {
      return; // User not authenticated, helper will show login prompt
    }

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
                RoomChatDialogHelpers.showShareDealDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people, color: AppColors.info),
              title: const Text('Form Group'),
              subtitle: const Text('Create a group for better discounts'),
              onTap: () {
                Navigator.pop(context);
                RoomChatDialogHelpers.showFormGroupDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: AppColors.success),
              title: const Text('Share Location'),
              subtitle: const Text('Share a venue or meeting point'),
              onTap: () {
                Navigator.pop(context);
                RoomChatDialogHelpers.showShareLocationDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  

  
}
