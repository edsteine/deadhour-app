import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/theme.dart';
import '../../utils/performance_utils.dart';
import '../../widgets/common/dev_menu_drawer.dart';
import '../../widgets/common/dead_hour_app_bar.dart';
import '../home/home_screen.dart';
import '../community/rooms_screen.dart';
import '../tourism/tourism_screen.dart';
import '../profile/profile_screen.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  final Widget? child; // Made optional since we'll use TabBarView

  const MainNavigationScreen({
    super.key,
    this.child,
  });

  @override
  ConsumerState<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging ||
          _currentIndex != _tabController.index) {
        setState(() {
          _currentIndex = _tabController.index;
        });
        PerformanceUtils.hapticFeedback(HapticFeedbackType.selection);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<NavigationItem> get _navigationItems {
    // Core navigation - same for ALL users (guest and logged in)
    return [
      NavigationItem(
        route: '/home',
        icon: Icons.home_outlined,
        activeIcon: Icons.home,
        label: 'Discover',
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
        route: '/profile',
        icon: Icons.person_outline,
        activeIcon: Icons.person,
        label: 'Profile',
      ),
    ];
  }

  List<Widget> get _tabViews {
    return [
      const HomeScreen(),
      const RoomsScreen(),
      const TourismScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DevMenuDrawer(), // Development menu drawer
      appBar: _buildAppBarForCurrentTab(),
      body: TabBarView(
        controller: _tabController,
        physics: const OptimizedScrollPhysics(),
        children: _tabViews,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing8,
            vertical: AppTheme.spacing8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _navigationItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isActive = index == _currentIndex;

              return _buildNavigationItem(
                item: item,
                isActive: isActive,
                onTap: () => _onItemTapped(index, item.route),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItem({
    required NavigationItem item,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing12,
          vertical: AppTheme.spacing8,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.moroccoGreen.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? item.activeIcon : item.icon,
              color: isActive ? AppTheme.moroccoGreen : AppTheme.secondaryText,
              size: 24,
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color:
                    isActive ? AppTheme.moroccoGreen : AppTheme.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index, String route) {
    if (_currentIndex != index) {
      _tabController.animateTo(index);
      PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
    }
  }

  PreferredSizeWidget _buildAppBarForCurrentTab() {
    switch (_currentIndex) {
      case 0: // Home
        return const DeadHourAppBar(
          title: 'DeadHour',
          showMenuDrawer: true,
          showLocationSelector: true,
          showNotifications: true,
          showBusinessActions: true,
          showSearch: true,
        );
      case 1: // Community
        return const DeadHourAppBar(
          title: 'Community Rooms',
          showMenuDrawer: true,
          showLocationSelector: true,
          showNotifications: true,
          showSearch: true,
        );
      case 2: // Tourism
        return const DeadHourAppBar(
          title: 'Explore Morocco',
          showMenuDrawer: true,
          showLocationSelector: true,
          showNotifications: true,
          showTourismActions: true,
          showSearch: true,
        );
      case 3: // Profile
        return const DeadHourAppBar(
          title: 'Profile',
          showMenuDrawer: true,
          showNotifications: true,
        );
      default:
        return const DeadHourAppBar(
          title: 'DeadHour',
          showMenuDrawer: true,
        );
    }
  }
}

// Navigation Item Model
class NavigationItem {
  final String route;
  final IconData icon;
  final IconData activeIcon;
  final String label;

  NavigationItem({
    required this.route,
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class PrayerTimeIndicator extends StatelessWidget {
  final bool isVisible;

  const PrayerTimeIndicator({
    super.key,
    this.isVisible = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.prayerTime,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.access_time,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            'Prayer time - Community rooms paused',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
