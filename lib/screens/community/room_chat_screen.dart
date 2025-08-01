import '../profile/services/auth_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/room_chat_app_bar.dart';
import 'widgets/room_info_banner.dart';
import 'widgets/typing_indicator.dart';
import 'widgets/message_input.dart';
import 'utils/room_chat_bottom_sheet_helpers.dart';
import '../../utils/app_theme.dart';
import '../../utils/mock_data.dart';
import 'widgets/chat_message_filters.dart';
import 'widgets/chat_messages_list.dart';
import 'widgets/chat_typing_indicator.dart';
import 'widgets/chat_action_buttons.dart';
import 'services/chat_real_time_service.dart';
import 'services/chat_message_service.dart';

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

  late ChatRealTimeService _realTimeService;
  late ChatMessageService _messageService;

  @override
  void initState() {
    super.initState();
    _loadRoom();
    _loadMessages();
    _scrollController.addListener(_onScroll);

    // Initialize services
    _realTimeService = ChatRealTimeService(
      onTypingUsersChanged: (users) => setState(() => _typingUsers
        ..clear()
        ..addAll(users)),
      onNewMessage: _addIncomingMessage,
    );
    
    _messageService = ChatMessageService();

    // Start real-time updates
    _realTimeService.startRealTimeUpdates();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _realTimeService.dispose();
    super.dispose();
  }

  void _onScroll() {
    final shouldShow =
        _scrollController.hasClients && _scrollController.offset > 100;
    if (shouldShow != _showScrollToBottom) {
      setState(() {
        _showScrollToBottom = shouldShow;
      });
    }
  }

  void _addIncomingMessage(Map<String, dynamic> message) {
    setState(() {
      _messages.add(message);
    });

    // Auto-scroll if user is near bottom
    if (_scrollController.hasClients &&
        _scrollController.offset >
            _scrollController.position.maxScrollExtent - 200) {
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
    _messages = _messageService.getInitialMessages();
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

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    // Check if user is authenticated before allowing message sending
    if (!AuthHelpers.requireAuthForCommunity(context, ref)) {
      return; // User not authenticated, helper will show login prompt
    }

    final newMessage = _messageService.createUserMessage(text.trim());

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

  void _reactToMessage(String messageId, String emoji) {
    setState(() {
      _messageService.toggleMessageReaction(_messages, messageId, emoji);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoomChatAppBar(
        room: _room,
        onShowRoomInfo: () => RoomChatBottomSheetHelpers.showRoomInfo(
            context, _room, _getCategoryColor, _buildInfoStat),
        onShowRoomMenu: () =>
            RoomChatBottomSheetHelpers.showRoomMenu(context, _leaveRoom),
        getCategoryColor: (category) => _getCategoryColor(category),
      ),
      body: Column(
        children: [
          // Room info banner
          const RoomInfoBanner(),

          // Message filter tabs
          ChatMessageFilters(
            currentFilter: _messageFilter,
            onFilterChanged: (filter) => setState(() => _messageFilter = filter),
          ),

          // Messages list
          ChatMessagesList(
            scrollController: _scrollController,
            messages: _messageService.getFilteredMessages(_messages, _messageFilter),
            onReactToMessage: _reactToMessage,
          ),

          // Typing indicator
          if (_typingUsers.isNotEmpty)
            ChatTypingIndicator(typingUsers: _typingUsers),
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
      floatingActionButton: _showScrollToBottom
          ? FloatingActionButton.small(
              heroTag: "room_chat_scroll_fab",
              onPressed: _scrollToBottom,
              backgroundColor: AppTheme.moroccoGreen,
              child: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
    ChatActionButtons.showLeaveRoomDialog(context, _room);
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

  void _showMessageOptions() {
    ChatActionButtons.showMessageOptions(context);
  }
}