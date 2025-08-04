import '../community/rooms_screen.dart';
import '../deals/deals_screen.dart';
import '../deals/filters/deals_filters.dart';
import 'custom_bottom_navigation.dart';
import 'dev_menu_screen.dart';
import 'navigation_app_bars.dart';
import 'navigation_controller.dart';
import 'navigation_dialogs.dart';
import '../notifications/notifications_screen.dart';
import '../profile/profile_screen.dart';
import '../tourism/tourism_screen.dart';
import '../venues/venues_screen.dart';
import '../widgets/performance_monitor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


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
  late NavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = NavigationController();
    _navigationController.initialize(this);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigationController.setTabFromRoute(context);
    });
  }

  @override
  void dispose() {
    _navigationController.dispose();
    super.dispose();
  }

  List<Widget> get _tabViews {
    return [
      const DealsScreen(),
      VenueDiscoveryScreen(
        key: ValueKey(_navigationController.selectedVenueView),
        selectedView: _navigationController.selectedVenueView,
      ),
      const RoomsScreen(),
      const TourismScreen(),
      const NotificationsScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PerformanceMonitorWidget(
      screenName: 'MainNavigation',
      child: ListenableBuilder(
        listenable: _navigationController,
        builder: (context, child) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) async {
              if (didPop) return;
              
              if (_navigationController.currentIndex != 0) {
                _navigationController.onItemTapped(0);
              } else {
                NavigationDialogs.showExitConfirmation(context);
              }
            },
            child: Scaffold(
              drawer: const DevMenuDrawer(),
              appBar: NavigationAppBars.buildAppBarForTab(
                currentIndex: _navigationController.currentIndex,
                context: context,
                showDealsFilters: () => DealsFilters.show(context),
                showVenueFilters: () {}, // TODO: Implement
                showCommunityFilters: () {}, // TODO: Implement  
                showTourismFilters: () {}, // TODO: Implement
                markAllAsRead: () => NavigationDialogs.markAllAsRead(context),
                showNotificationSettings: () => NavigationDialogs.showNotificationSettings(context),
                showProfileSettings: () => context.go('/settings'),
                updateNotificationFilter: (filter) => _updateNotificationFilter(filter),
                notificationSubtitle: _getNotificationSubtitle(),
              ),
              body: PageView(
                controller: _navigationController.pageController,
                onPageChanged: _navigationController.onPageChanged,
                children: _tabViews,
              ),
              bottomNavigationBar: CustomBottomNavigation(
                currentIndex: _navigationController.currentIndex,
                onItemTapped: (index, route) => _navigationController.onItemTapped(index),
              ),
            ),
          );
        },
      ),
    );
  }

  String? _getNotificationSubtitle() {
    // TODO: Get actual unread count from NotificationService
    return null;
  }

  void _updateNotificationFilter(String filter) {
    // TODO: Communicate with NotificationsScreen to update filter
  }
}