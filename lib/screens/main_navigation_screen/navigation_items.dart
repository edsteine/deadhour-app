import 'package:flutter/material.dart';



/// Navigation items configuration
class NavigationItems {
  static List<NavigationItem> get items {
    return [
      NavigationItem(
        route: '/deals',
        icon: Icons.local_offer_outlined,
        activeIcon: Icons.local_offer,
        label: 'Deals',
      ),
      NavigationItem(
        route: '/venues',
        icon: Icons.location_on_outlined,
        activeIcon: Icons.location_on,
        label: 'Venues',
      ),
      NavigationItem(
        route: '/community',
        icon: Icons.people_outlined,
        activeIcon: Icons.people,
        label: 'Community',
      ),
      NavigationItem(
        route: '/tourism',
        icon: Icons.explore_outlined,
        activeIcon: Icons.explore,
        label: 'Explore',
      ),
      NavigationItem(
        route: '/notifications',
        icon: Icons.notifications_outlined,
        activeIcon: Icons.notifications,
        label: 'Notifications',
      ),
      NavigationItem(
        route: '/profile',
        icon: Icons.person_outline,
        activeIcon: Icons.person,
        label: 'Profile',
      ),
    ];
  }
}