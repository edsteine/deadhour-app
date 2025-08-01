import '../profile/models/user.dart';
import '../profile/providers/role_toggle_provider.dart';
import '../../utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/app_theme.dart';
import 'widgets/room_interaction_helpers.dart';
import 'widgets/premium_upgrade_helper.dart';
import 'widgets/rooms_scaffold.dart';
import 'widgets/rooms_tabs/my_rooms_tab_view.dart';
import 'widgets/rooms_tabs/business_rooms_tab_view.dart';
import 'widgets/rooms_tabs/guide_rooms_tab_view.dart';
import 'widgets/rooms_tabs/premium_rooms_tab_view.dart';
import 'widgets/rooms_tabs/popular_rooms_tab_view.dart';
import 'widgets/rooms_tabs/all_rooms_tab_view.dart';
import '../../utils/mock_data.dart';

class RoomsScreen extends ConsumerStatefulWidget {
  const RoomsScreen({super.key});

  @override
  ConsumerState<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends ConsumerState<RoomsScreen>
    with TickerProviderStateMixin {
  final String _selectedCity = 'Casablanca';
  String _selectedCategory = 'all';
  bool _showPrayerTimeAware = false;
  bool _showHalalOnly = false;
  late TabController _tabController;
  
  // Role-based tab system for community enhancement
  List<Tab> _getRoleBasedTabs() {
    final user = ref.watch(userProvider);
    final currentRole = ref.watch(roleToggleProvider);
    
    List<Tab> tabs = [
      const Tab(text: 'My Rooms'),
      const Tab(text: 'All Rooms'),
      const Tab(text: 'Popular'),
    ];
    
    // Add role-specific tabs based on user's active roles
    if (user?.hasBusinessRole == true) {
      tabs.add(const Tab(text: 'Business'));
    }
    
    if (user?.hasGuideRole == true) {
      tabs.add(const Tab(text: 'Guide'));
    }
    
    // Premium tab - key revenue driver (€15/month)
    if (user?.hasPremiumRole == true) {
      tabs.add(const Tab(text: 'Premium'));
    } else {
      // Show premium upgrade opportunity
      tabs.add(const Tab(text: 'Premium ⭐'));
    }
    
    return tabs;
  }
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> _getRoleBasedTabViews() {
    final user = ref.watch(userProvider);
    
    List<Widget> tabViews = [
      // My Rooms - Personal community spaces
      MyRoomsTabView(
        onOpenRoom: (room) => RoomInteractionHelpers.openRoom(context, room),
      ),
      
      // All Rooms - General community access
      AllRoomsTabView(
        selectedCategory: _selectedCategory,
        showPrayerTimeAware: _showPrayerTimeAware,
        showHalalOnly: _showHalalOnly,
        onRefresh: () => RoomInteractionHelpers.handleRefresh(() => setState(() {})),
        onJoinRoom: (room) => RoomInteractionHelpers.joinRoom(context, ref,
            room, (r) => RoomInteractionHelpers.openRoom(context, r)),
      ),
      
      // Popular Rooms - Community-driven discovery
      PopularRoomsTabView(
        onJoinRoom: (room) => RoomInteractionHelpers.joinRoom(context, ref,
            room, (r) => RoomInteractionHelpers.openRoom(context, r)),
      ),
    ];
    
    // Add role-specific tab views
    if (user?.hasBusinessRole == true) {
      tabViews.add(
        const BusinessRoomsTabView(),
      );
    }
    
    if (user?.hasGuideRole == true) {
      tabViews.add(
        const GuideRoomsTabView(),
      );
    }
    
    // Premium rooms - €15/month revenue driver
    if (user?.hasPremiumRole == true) {
      tabViews.add(
        PremiumRoomsTabView(
          onJoinPremiumRoom: (room) => RoomInteractionHelpers.joinRoom(context, ref,
              room, (r) => RoomInteractionHelpers.openRoom(context, r)),
          onShowPremiumUpgrade: () => showPremiumUpgrade(context),
        ),
      );
    } else {
      // Show premium upgrade opportunity
      tabViews.add(
        _buildPremiumUpgradeView(),
      );
    }
    
    return tabViews;
  }
  
  Widget _buildPremiumUpgradeView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.workspace_premium,
              size: 80,
              color: AppTheme.moroccoGold,
            ),
            const SizedBox(height: 24),
            const Text(
              'Unlock Premium Rooms',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryText,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Join exclusive rooms with local experts, curated experiences, and premium community features.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.secondaryText,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => showPremiumUpgrade(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.moroccoGold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Upgrade to Premium - €15/month',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => showPremiumUpgrade(context),
              child: const Text(
                'Learn More About Premium Features',
                style: TextStyle(
                  color: AppTheme.moroccoGold,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final tabs = _getRoleBasedTabs();
    final tabViews = _getRoleBasedTabViews();
    
    // Update tab controller length when roles change
    if (_tabController.length != tabs.length) {
      _tabController.dispose();
      _tabController = TabController(length: tabs.length, vsync: this);
    }
    
    return ErrorBoundary(
      errorMessage: 'Unable to load community rooms',
      child: RoomsScaffold(
        user: user,
        tabController: _tabController,
        selectedCategory: _selectedCategory,
        showPrayerTimeAware: _showPrayerTimeAware,
        showHalalOnly: _showHalalOnly,
        onCategorySelected: (category) {
          setState(() {
            _selectedCategory = category;
          });
        },
        onPrayerTimeAwareChanged: (value) {
          setState(() {
            _showPrayerTimeAware = value;
          });
        },
        onHalalOnlyChanged: (value) {
          setState(() {
            _showHalalOnly = value;
          });
        },
        onCreateRoomPressed: () => RoomInteractionHelpers.showCreateRoomDialog(
            context, ref, _selectedCity),
        tabs: tabs,
        tabViews: tabViews,
      ),
    );
  }


}

final userProvider = Provider<DeadHourUser?>((ref) {
  // In a real app, you would get the user from your authentication provider.
  // For now, we'll use the mock user.
  return MockData.currentUser;
});
