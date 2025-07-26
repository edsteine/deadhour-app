import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../utils/theme.dart';
import 'package:deadhour/screens/community/widgets/community_app_bar.dart';
import 'package:deadhour/screens/community/widgets/community_health_indicator.dart';
import 'package:deadhour/screens/community/widgets/category_filter.dart';
import 'package:deadhour/screens/community/widgets/cultural_filters.dart';
import 'package:deadhour/screens/community/widgets/all_rooms_tab.dart';
import 'package:deadhour/screens/community/widgets/my_rooms_tab.dart';
import 'package:deadhour/screens/community/widgets/popular_rooms_tab.dart';
import 'package:deadhour/screens/community/widgets/premium_rooms_tab.dart';
import 'package:deadhour/screens/community/widgets/room_interaction_helpers.dart';
import 'package:deadhour/screens/community/widgets/business_rooms_tab.dart';
import 'package:deadhour/screens/community/widgets/guide_rooms_tab.dart';
import 'package:deadhour/screens/community/widgets/premium_upgrade_helper.dart';








class RoomsScreen extends StatefulWidget {
  final DeadHourUser? user;
  
  const RoomsScreen({super.key, this.user});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCity = 'Casablanca';
  String _selectedCategory = 'all';
  bool _showPrayerTimeAware = false;
  bool _showHalalOnly = false;

  List<Tab> get _tabs {
    List<Tab> baseTabs = [
      const Tab(text: 'All Rooms'),
      const Tab(text: 'My Rooms'),
      const Tab(text: 'Popular'),
    ];
    
    // Add Role-specific tabs
    if (widget.user?.hasRole('business') == true) {
      baseTabs.add(const Tab(text: 'Business'));
    }
    if (widget.user?.hasRole('guide') == true) {
      baseTabs.add(const Tab(text: 'Guide Network'));
    }
    if (widget.user?.hasRole('premium') == true) {
      baseTabs.add(const Tab(text: 'Premium'));
    }
    
    return baseTabs;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }
  
  @override
  void didUpdateWidget(RoomsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.user?.activeRoles != widget.user?.activeRoles) {
      _tabController.dispose();
      _tabController = TabController(length: _tabs.length, vsync: this);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommunityAppBar(
        selectedCity: _selectedCity,
        onCitySelectorPressed: () => RoomInteractionHelpers.showCitySelector(context, _selectedCity, (city) {
          setState(() {
            _selectedCity = city;
          });
        }),
        onRoomSearchPressed: () => RoomInteractionHelpers.showRoomSearch(context),
      ),
      body: Column(
        children: [
          // Community health indicator
          CommunityHealthIndicator(),

          // Category filter
          CategoryFilter(
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                _selectedCategory = category;
              });
            },
          ),

          // Cultural filters
          CulturalFilters(
            showPrayerTimeAware: _showPrayerTimeAware,
            showHalalOnly: _showHalalOnly,
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
          ),

          // Tab bar
          TabBar(
            controller: _tabController,
            labelColor: AppTheme.moroccoGreen,
            unselectedLabelColor: AppTheme.secondaryText,
            indicatorColor: AppTheme.moroccoGreen,
            isScrollable: true,
            tabs: _tabs,
          ),

          // Tab views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _buildTabViews(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "roomsCreateRoomFAB",
        onPressed: () => RoomInteractionHelpers.showCreateRoomDialog(context, _selectedCity),
        backgroundColor: AppTheme.moroccoGreen,
        icon: const Icon(Icons.add),
        label: const Text('Create Room'),
      ),
    );
  }

  

  

  

  

  

  

  

  

  

  

  List<Widget> _buildTabViews() {
    List<Widget> views = [
      AllRoomsTab(
        selectedCategory: _selectedCategory,
        showPrayerTimeAware: _showPrayerTimeAware,
        showHalalOnly: _showHalalOnly,
        onRefresh: () => RoomInteractionHelpers.handleRefresh(() => setState(() {})),
        onJoinRoom: (room) => RoomInteractionHelpers.joinRoom(context, room, (r) => RoomInteractionHelpers.openRoom(context, r)),
      ),
      MyRoomsTab(
        tabController: _tabController,
        onOpenRoom: (room) => RoomInteractionHelpers.openRoom(context, room),
      ),
      PopularRoomsTab(
        onJoinRoom: (room) => RoomInteractionHelpers.joinRoom(context, room, (r) => RoomInteractionHelpers.openRoom(context, r)),
      ),
    ];
    
    // Add Role-specific tab views
    if (widget.user?.hasRole('business') == true) {
      views.add(const BusinessRoomsTab());
    }
    if (widget.user?.hasRole('guide') == true) {
      views.add(const GuideRoomsTab());
    }
    if (widget.user?.hasRole('premium') == true) {
      views.add(PremiumRoomsTab(
        onJoinPremiumRoom: (room) => RoomInteractionHelpers.joinPremiumRoom(context, room, () => showPremiumUpgrade(context)),
        onShowPremiumUpgrade: () => showPremiumUpgrade(context),
      ));
    }
    
    return views;
  }
}

  


