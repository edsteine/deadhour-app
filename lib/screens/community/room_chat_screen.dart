import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deadhour/screens/community/widgets/room_chat_app_bar.dart';
import 'package:deadhour/screens/community/widgets/room_info_banner.dart';
import 'package:deadhour/screens/community/widgets/typing_indicator.dart';
import 'package:deadhour/screens/community/widgets/message_input.dart';
import 'package:deadhour/screens/community/utils/room_chat_dialog_helpers.dart';
import 'package:deadhour/screens/community/utils/room_chat_bottom_sheet_helpers.dart';
import 'package:deadhour/utils/mock_data.dart';
import 'package:deadhour/utils/auth_helpers.dart';

import 'package:deadhour/screens/community/room_chat_screen/widgets/room_chat_message_filters.dart';
import 'package:deadhour/screens/community/room_chat_screen/widgets/room_chat_messages_list.dart';
import 'package:deadhour/screens/community/room_chat_screen/widgets/room_chat_typing_indicator.dart';
import 'package:deadhour/screens/community/room_chat_screen/widgets/room_chat_scroll_fab.dart';
import 'package:deadhour/screens/community/room_chat_screen/widgets/room_chat_message_reactions.dart';
import 'package:deadhour/screens/community/room_chat_screen/widgets/room_chat_helpers.dart';

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
  final List<String> _typingUsers = [];
  bool _isTyping = false;
  String _messageFilter = 'all';
  bool _showScrollToBottom = false;

  @override
  void initState() {
    super.initState();
    _loadRoom();
    _loadMessages();
    _scrollController.addListener(_onScroll);
    _startRealTimeUpdates();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final shouldShow = _scrollController.hasClients && _scrollController.offset > 100;
    if (shouldShow != _showScrollToBottom) {
      setState(() {
        _showScrollToBottom = shouldShow;
      });
    }
  }

  void _startRealTimeUpdates() {
    // Simulate typing indicators
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          _typingUsers.add('Fatima_Rbat');
        });
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _typingUsers.clear();
            });
            _addIncomingMessage();
          }
        });
      }
    });
  }

  void _addIncomingMessage() {
    final incomingMessage = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'userId': 'user2',
      'userName': 'Fatima Zahra',
      'userAvatar': 'https://i.pravatar.cc/150?img=2',
      'message': 'Just booked the Café Atlas deal! The atmosphere is amazing 😍',
      'type': 'text',
      'timestamp': DateTime.now(),
    };

    setState(() {
      _messages.add(incomingMessage);
    });

    // Auto-scroll if user is near bottom
    if (_scrollController.hasClients &&
        _scrollController.offset > _scrollController.position.maxScrollExtent - 200) {
      _scrollToBottom();
    }
  }

  void _loadRoom() {
    _room = MockData.rooms.firstWhere(
      (room) => room.id == widget.roomId,
      orElse: () => MockData.rooms.first,
    );
  }

  void _loadMessages() {
    // Load initial mock messages
    _messages = _getMockMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoomChatAppBar(
        room: _room,
        onShowRoomInfo: () => RoomChatBottomSheetHelpers.showRoomInfo(
            context, _room, RoomChatHelpers.getCategoryColor, RoomChatHelpers.buildInfoStat),
        onShowRoomMenu: () => RoomChatBottomSheetHelpers.showRoomMenu(
            context, () => RoomChatHelpers.leaveRoom(context, _room)),
        getCategoryColor: RoomChatHelpers.getCategoryColor,
      ),
      body: Column(
        children: [
          // Room info banner
          const RoomInfoBanner(),

          // Message filter tabs
          RoomChatMessageFilters(
            selectedFilter: _messageFilter,
            onFilterChanged: (filter) => setState(() => _messageFilter = filter),
          ),

          // Messages list
          RoomChatMessagesList(
            scrollController: _scrollController,
            messages: _messages,
            messageFilter: _messageFilter,
            formatTime: RoomChatHelpers.formatTime,
            bookDeal: (dealInfo) => RoomChatHelpers.bookDeal(context, dealInfo),
            joinGroup: (groupInfo) => RoomChatHelpers.joinGroup(context, groupInfo),
            buildMessageReactions: _buildMessageReactions,
          ),

          // Typing indicators
          RoomChatTypingIndicator(typingUsers: _typingUsers),
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
      // Scroll to bottom FAB
      floatingActionButton: RoomChatScrollFab(
        showScrollToBottom: _showScrollToBottom,
        onScrollToBottom: _scrollToBottom,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildMessageReactions(Map<String, dynamic> message) {
    return RoomChatMessageReactions(
      message: message,
      onReactToMessage: _reactToMessage,
    );
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _reactToMessage(String messageId, String emoji) {
    setState(() {
      final messageIndex = _messages.indexWhere((msg) => msg['id'] == messageId);
      if (messageIndex != -1) {
        final message = _messages[messageIndex];
        final reactions = Map<String, List<String>>.from(message['reactions'] ?? {});

        if (reactions[emoji] == null) {
          reactions[emoji] = [];
        }

        final currentUserId = MockData.currentUser.id;
        if (reactions[emoji]!.contains(currentUserId)) {
          reactions[emoji]!.remove(currentUserId);
          if (reactions[emoji]!.isEmpty) {
            reactions.remove(emoji);
          }
        } else {
          reactions[emoji]!.add(currentUserId);
        }

        _messages[messageIndex]['reactions'] = reactions;
      }
    });
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
      'message': text,
      'type': 'text',
      'timestamp': DateTime.now(),
    };

    setState(() {
      _messages.add(newMessage);
    });

    _messageController.clear();
    _scrollToBottom();
  }

  void _showMessageOptions() {
    RoomChatDialogHelpers.showMessageOptions(
      context,
      onDealShare: () => RoomChatDialogHelpers.showShareDeal(context),
      onGroupForm: () => RoomChatDialogHelpers.showFormGroup(context),
      onLocationShare: () => RoomChatDialogHelpers.showShareLocation(context),
    );
  }

  List<Map<String, dynamic>> _getMockMessages() {
    return [
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
      // Add more mock messages as needed...
    ];
  }
}