import 'package:flutter/material.dart';

class BusinessNotificationsModal extends StatelessWidget {
  const BusinessNotificationsModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const BusinessNotificationsModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.notifications, size: 24),
                  const SizedBox(width: 12),
                  const Text(
                    'Business Notifications',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 8, // Mock data
                  itemBuilder: (context, index) {
                    return _buildNotificationItem(index);
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        debugPrint('Mark all as read');
                      },
                      child: const Text('Mark All Read'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        debugPrint('Navigate to full notifications');
                      },
                      child: const Text('View All'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNotificationItem(int index) {
    final notifications = [
      {
        'title': 'New booking received',
        'message': 'Table for 4 at 19:30 tonight',
        'time': '2 minutes ago',
        'icon': Icons.book_online,
        'color': Colors.green,
        'unread': true,
      },
      {
        'title': 'Deal performance update',
        'message': 'Your lunch special is trending',
        'time': '1 hour ago',
        'icon': Icons.trending_up,
        'color': Colors.blue,
        'unread': true,
      },
      {
        'title': 'Customer review',
        'message': '5-star review from Ahmed K.',
        'time': '3 hours ago',
        'icon': Icons.star,
        'color': Colors.amber,
        'unread': false,
      },
      {
        'title': 'Payment received',
        'message': 'MAD 156 from recent booking',
        'time': '5 hours ago',
        'icon': Icons.payment,
        'color': Colors.green,
        'unread': false,
      },
    ];

    final notification = notifications[index % notifications.length];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: (notification['color'] as Color).withValues(alpha: 0.1),
          child: Icon(
            notification['icon'] as IconData,
            color: notification['color'] as Color,
          ),
        ),
        title: Text(
          notification['title'] as String,
          style: TextStyle(
            fontWeight: (notification['unread'] as bool) ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification['message'] as String),
            const SizedBox(height: 4),
            Text(
              notification['time'] as String,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        trailing: (notification['unread'] as bool)
            ? Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              )
            : null,
        onTap: () {
          debugPrint('Notification tapped: ${notification['title']}');
        },
      ),
    );
  }
}