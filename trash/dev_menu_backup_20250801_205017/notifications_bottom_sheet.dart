import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'dev_menu_prayer_times_widget.dart';

class NotificationsBottomSheet extends StatefulWidget {
  const NotificationsBottomSheet({super.key});
  
  @override
  State<NotificationsBottomSheet> createState() =>
      _NotificationsBottomSheetState();
}

class _NotificationsBottomSheetState extends State<NotificationsBottomSheet>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 24,
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
          ),

          // Prayer times widget
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: DevMenuPrayerTimesWidget(isVisible: true),
          ),
          const SizedBox(height: 16),

          // Tab bar
          TabBar(
            controller: _tabController,
            labelColor: AppTheme.moroccoGreen,
            unselectedLabelColor: AppTheme.secondaryText,
            indicatorColor: AppTheme.moroccoGreen,
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Deals'),
              Tab(text: 'Community'),
              Tab(text: 'Tourism'),
            ],
          ),

          // Tab views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAllNotifications(),
                _buildDealsNotifications(),
                _buildCommunityNotifications(),
                _buildTourismNotifications(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllNotifications() {
    final notifications = [
      {
        'title': 'New Flash Deal!',
        'subtitle': '50% off at Café Atlas - 2 hours left',
        'icon': Icons.local_fire_department,
        'color': AppColors.error,
        'time': '5m ago',
        'type': 'deal'
      },
      {
        'title': 'Room Activity',
        'subtitle': 'New message in Coffee Afternoon Deals',
        'icon': Icons.people,
        'color': AppColors.info,
        'time': '15m ago',
        'type': 'community'
      },
      {
        'title': 'Expert Request',
        'subtitle': 'New tourist needs local guide assistance',
        'icon': Icons.star,
        'color': AppColors.warning,
        'time': '1h ago',
        'type': 'tourism'
      },
      {
        'title': 'Booking Confirmed',
        'subtitle': 'Your table at Restaurant Al-Fassia is ready',
        'icon': Icons.check_circle,
        'color': AppColors.success,
        'time': '2h ago',
        'type': 'deal'
      },
      {
        'title': 'Prayer Time Reminder',
        'subtitle': 'Maghrib prayer in 10 minutes',
        'icon': Icons.access_time,
        'color': AppColors.prayerTime,
        'time': '10m ago',
        'type': 'cultural'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (notification['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                notification['icon'] as IconData,
                color: notification['color'] as Color,
              ),
            ),
            title: Text(notification['title'] as String),
            subtitle: Text(notification['subtitle'] as String),
            trailing: Text(
              notification['time'] as String,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              _handleNotificationTap(notification['type'] as String);
            },
          ),
        );
      },
    );
  }

  Widget _buildDealsNotifications() {
    final dealNotifications = [
      {
        'title': 'Flash Deal Alert!',
        'subtitle': '50% off at Café Atlas - Limited time',
        'icon': Icons.local_fire_department,
        'time': '5m ago',
        'venue': 'Café Atlas',
        'discount': '50%'
      },
      {
        'title': 'Booking Confirmed',
        'subtitle': 'Table for 2 at Restaurant Al-Fassia',
        'icon': Icons.check_circle,
        'time': '2h ago',
        'venue': 'Restaurant Al-Fassia',
        'discount': '25%'
      },
      {
        'title': 'Deal Ending Soon',
        'subtitle': 'Happy hour at Café Central expires in 30 min',
        'icon': Icons.timer,
        'time': '30m ago',
        'venue': 'Café Central',
        'discount': '30%'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: dealNotifications.length,
      itemBuilder: (context, index) {
        final notification = dealNotifications[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                notification['icon'] as IconData,
                color: AppTheme.moroccoGreen,
              ),
            ),
            title: Text(notification['title'] as String),
            subtitle: Text(notification['subtitle'] as String),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    notification['discount'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  notification['time'] as String,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              // Navigate to deals screen
            },
          ),
        );
      },
    );
  }

  Widget _buildCommunityNotifications() {
    final communityNotifications = [
      {
        'title': 'New Message',
        'subtitle': 'Coffee Afternoon Deals room',
        'icon': Icons.chat_bubble,
        'time': '15m ago',
        'room': 'Coffee Afternoon Deals',
        'members': '42 members'
      },
      {
        'title': 'Room Joined',
        'subtitle': 'Welcome to Food Lovers Morocco!',
        'icon': Icons.group_add,
        'time': '1h ago',
        'room': 'Food Lovers Morocco',
        'members': '156 members'
      },
      {
        'title': 'Group Deal',
        'subtitle': 'Form a group for Tajine cooking class',
        'icon': Icons.group,
        'time': '3h ago',
        'room': 'Cultural Experiences',
        'members': '89 members'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: communityNotifications.length,
      itemBuilder: (context, index) {
        final notification = communityNotifications[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                notification['icon'] as IconData,
                color: AppColors.info,
              ),
            ),
            title: Text(notification['title'] as String),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification['subtitle'] as String),
                Text(
                  notification['members'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            trailing: Text(
              notification['time'] as String,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              // Navigate to community screen
            },
          ),
        );
      },
    );
  }

  Widget _buildTourismNotifications() {
    final tourismNotifications = [
      {
        'title': 'Expert Request',
        'subtitle': 'Tourist needs guide for Marrakech medina',
        'icon': Icons.person_pin,
        'time': '1h ago',
        'location': 'Marrakech',
        'earnings': '€25'
      },
      {
        'title': 'Cultural Event',
        'subtitle': 'Gnawa Festival starting tomorrow',
        'icon': Icons.event,
        'time': '4h ago',
        'location': 'Essaouira',
        'earnings': null
      },
      {
        'title': 'New Experience',
        'subtitle': 'Traditional henna workshop available',
        'icon': Icons.palette,
        'time': '6h ago',
        'location': 'Fes',
        'earnings': '€15'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: tourismNotifications.length,
      itemBuilder: (context, index) {
        final notification = tourismNotifications[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.tourismCategory.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                notification['icon'] as IconData,
                color: AppColors.tourismCategory,
              ),
            ),
            title: Text(notification['title'] as String),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification['subtitle'] as String),
                Text(
                  notification['location'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (notification['earnings'] != null)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.tourismCategory,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      notification['earnings'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const SizedBox(height: 2),
                Text(
                  notification['time'] as String,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              // Navigate to tourism screen
            },
          ),
        );
      },
    );
  }

  void _handleNotificationTap(String type) {
    switch (type) {
      case 'deal':
        // Navigate to deals screen
        break;
      case 'community':
        // Navigate to community screen
        break;
      case 'tourism':
        // Navigate to tourism screen
        break;
      case 'cultural':
        // Stay on current screen but show cultural info
        break;
    }
  }
}