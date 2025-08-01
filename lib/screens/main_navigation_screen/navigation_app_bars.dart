

import 'package:flutter/material.dart';

/// Handles app bar creation for different navigation tabs
class NavigationAppBars {
  static PreferredSizeWidget buildAppBarForTab({
    required int currentIndex,
    required BuildContext context,
    required VoidCallback showDealsFilters,
    required VoidCallback showVenueFilters,
    required VoidCallback showCommunityFilters,
    required VoidCallback showTourismFilters,
    required VoidCallback markAllAsRead,
    required VoidCallback showNotificationSettings,
    required VoidCallback showProfileSettings,
    required Function(String) updateNotificationFilter,
    String? notificationSubtitle,
  }) {
    switch (currentIndex) {
      case 0: // Deals
        return DeadHourAppBar(
          title: 'Active Deals',
          showSearch: true,
          customActions: [
            const RoleSwitcher(),
            IconButton(
              onPressed: showDealsFilters,
              icon: const Icon(Icons.filter_list),
              tooltip: 'Filters',
            ),
          ],
        );
      case 1: // Venues
        return DeadHourAppBar(
          title: 'Nearby Venues',
          showSearch: true,
          customActions: [
            IconButton(
              onPressed: showVenueFilters,
              icon: const Icon(Icons.filter_list),
              tooltip: 'Filters',
            ),
          ],
        );
      case 2: // Community
        return DeadHourAppBar(
          title: 'Community Rooms',
          showSearch: true,
          customActions: [
            IconButton(
              onPressed: showCommunityFilters,
              icon: const Icon(Icons.filter_list),
              tooltip: 'Filters',
            ),
          ],
        );
      case 3: // Tourism
        return DeadHourAppBar(
          title: 'Explore Morocco',
          showSearch: true,
          customActions: [
            IconButton(
              onPressed: showTourismFilters,
              icon: const Icon(Icons.filter_list),
              tooltip: 'Filters',
            ),
          ],
        );
      case 4: // Notifications
        return DeadHourAppBar(
          title: 'Notifications',
          subtitle: notificationSubtitle,
          customActions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.filter_list, color: Colors.white),
              tooltip: 'Filter Notifications',
              onSelected: (value) => updateNotificationFilter(value),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'all',
                  child: Row(
                    children: [
                      Text('📱', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Text('All'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'deals',
                  child: Row(
                    children: [
                      Text('🔥', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Text('Deals'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'community',
                  child: Row(
                    children: [
                      Text('👥', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Text('Community'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'social',
                  child: Row(
                    children: [
                      Text('🎉', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Text('Social'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'cultural',
                  child: Row(
                    children: [
                      Text('🕌', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Text('Cultural'),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: markAllAsRead,
              icon: const Icon(Icons.done_all, color: Colors.white),
              tooltip: 'Mark All Read',
            ),
            IconButton(
              onPressed: showNotificationSettings,
              icon: const Icon(Icons.settings, color: Colors.white),
              tooltip: 'Settings',
            ),
          ],
        );
      case 5: // Profile
        return DeadHourAppBar(
          title: 'Profile',
          customActions: [
            IconButton(
              onPressed: showProfileSettings,
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
            ),
          ],
        );
      default:
        return const DeadHourAppBar(
          title: 'DeadHour',
        );
    }
  }
}