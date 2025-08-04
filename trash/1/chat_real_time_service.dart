import 'dart:async';

/// Service for handling real-time chat updates like typing indicators and new messages
class ChatRealTimeService {
  final Function(List<String>) onTypingUsersChanged;
  final Function(Map<String, dynamic>) onNewMessage;
  
  Timer? _updateTimer;

  ChatRealTimeService({
    required this.onTypingUsersChanged,
    required this.onNewMessage,
  });

  /// Start real-time updates simulation
  void startRealTimeUpdates() {
    // Simulate typing indicators and incoming messages
    Future.delayed(const Duration(seconds: 10), () {
      onTypingUsersChanged(['Fatima_Rbat']);
      
      Future.delayed(const Duration(seconds: 3), () {
        onTypingUsersChanged([]);
        _addSimulatedMessage();
      });
    });
  }

  /// Add a simulated incoming message
  void _addSimulatedMessage() {
    final incomingMessage = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'userId': 'user2',
      'userName': 'Fatima Zahra',
      'userAvatar': 'https://i.pravatar.cc/150?img=2',
      'message': 'Just booked the Café Atlas deal! The atmosphere is amazing 😍',
      'type': 'text',
      'timestamp': DateTime.now(),
    };

    onNewMessage(incomingMessage);
  }

  /// Clean up resources
  void dispose() {
    _updateTimer?.cancel();
  }
}