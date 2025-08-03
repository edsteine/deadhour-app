import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../utils/theme.dart';
import '../../utils/performance_utils.dart';
import '../../models/navigation_item.dart';
import '../../widgets/common/dev_menu_drawer.dart';
import '../../widgets/common/dead_hour_app_bar.dart';
import 'deals_screen.dart';
import 'venue_discovery_screen.dart';
import '../community/rooms_screen.dart';
import '../tourism/tourism_screen.dart';
import '../notifications/notifications_screen.dart';
import '../profile/profile_screen.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  final Widget? child;

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
  late PageController _pageController;
  int _currentIndex = 0;
  
  // Filter states for various screens
  final String _notificationFilter = 'all';
  String _selectedVenueView = 'list_view';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _pageController = PageController(initialPage: _currentIndex);
    
    _tabController.addListener(() {
      if (_tabController.indexIsChanging ||
          _currentIndex != _tabController.index) {
        setState(() {
          _currentIndex = _tabController.index;
        });
        PerformanceUtils.hapticFeedback(HapticFeedbackType.selection);
      }
    });
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setTabFromRoute();
    });
  }

  void _setTabFromRoute() {
    final location = GoRouter.of(context).routerDelegate.currentConfiguration.last.matchedLocation;
    int tabIndex = 0;
    
    switch (location) {
      case '/deals':
        tabIndex = 0;
        break;
      case '/venues':
        tabIndex = 1;
        break;
      case '/community':
        tabIndex = 2;
        break;
      case '/tourism':
        tabIndex = 3;
        break;
      case '/notifications':
        tabIndex = 4;
        break;
      case '/profile':
        tabIndex = 5;
        break;
      default:
        tabIndex = 0;
    }
    
    if (tabIndex != _currentIndex) {
      setState(() {
        _currentIndex = tabIndex;
      });
      _pageController.animateToPage(
        tabIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  List<NavigationItem> get _navigationItems {
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

  List<Widget> get _tabViews {
    return [
      const DealsScreen(),
      VenueDiscoveryScreen(key: ValueKey(_selectedVenueView), selectedView: _selectedVenueView),
      const RoomsScreen(),
      const TourismScreen(),
      NotificationsScreen(key: ValueKey(_notificationFilter)),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        
        if (_currentIndex != 0) {
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          _showExitConfirmation(context);
        }
      },
      child: Scaffold(
        drawer: const DevMenuDrawer(),
        appBar: _buildAppBarForCurrentTab(),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
              _tabController.animateTo(index);
            });
            PerformanceUtils.hapticFeedback(HapticFeedbackType.selection);
          },
          children: _tabViews,
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBarForCurrentTab() {
    switch (_currentIndex) {
      case 0: // Deals
        return const DeadHourAppBar(
          title: 'Dead Hour Deals',
          subtitle: 'Best off-peak deals in Morocco',
          showSearch: true,
          showNotifications: true,
        );
      case 1: // Venues
        return DeadHourAppBar(
          title: 'Discover Venues',
          subtitle: 'Find your next favorite place',
          showSearch: true,
          customActions: [
            IconButton(
              icon: Icon(_selectedVenueView == 'list_view' ? Icons.map : Icons.list),
              onPressed: () {
                setState(() {
                  _selectedVenueView = _selectedVenueView == 'list_view' ? 'map_view' : 'list_view';
                });
              },
              tooltip: _selectedVenueView == 'list_view' ? 'Map View' : 'List View',
            ),
          ],
        );
      case 2: // Community
        return const DeadHourAppBar(
          title: 'Community Rooms',
          subtitle: 'Connect with locals & tourists',
          showSearch: true,
        );
      case 3: // Tourism
        return const DeadHourAppBar(
          title: 'Morocco Explorer',
          subtitle: 'Authentic cultural experiences',
          showSearch: true,
          showTourismActions: true,
        );
      case 4: // Notifications
        return const DeadHourAppBar(
          title: 'Notifications',
          showSearch: true,
        );
      case 5: // Profile
        return const DeadHourAppBar(
          title: 'Profile',
          showNotifications: true,
        );
      default:
        return const DeadHourAppBar(title: 'DeadHour');
    }
  }

  Widget _buildBottomNavigationBar() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _navigationItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isActive = _currentIndex == index;
              
              return GestureDetector(
                onTap: () {
                  if (index != _currentIndex) {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    context.go(item.route);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isActive ? AppTheme.moroccoGreen.withValues(alpha: 0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isActive ? item.activeIcon : item.icon,
                        color: isActive ? AppTheme.moroccoGreen : Colors.grey.shade600,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: TextStyle(
                          color: isActive ? AppTheme.moroccoGreen : Colors.grey.shade600,
                          fontSize: 12,
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _showExitConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit DeadHour?'),
        content: const Text('Are you sure you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Exit app logic would go here
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}