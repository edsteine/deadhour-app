import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user.dart';
import 'widgets/rooms_scaffold.dart';
import 'package:deadhour/screens/community/widgets/room_interaction_helpers.dart';
import 'package:deadhour/screens/community/widgets/all_rooms_tab.dart';
import 'package:deadhour/screens/community/widgets/my_rooms_tab.dart';
import 'package:deadhour/screens/community/widgets/popular_rooms_tab.dart';
import 'package:deadhour/screens/community/widgets/premium_rooms_tab.dart';
import 'package:deadhour/screens/community/widgets/business_rooms_tab.dart';
import 'package:deadhour/screens/community/widgets/guide_rooms_tab.dart';
import 'package:deadhour/screens/community/widgets/premium_upgrade_helper.dart';
import '../../utils/mock_data.dart';

class RoomsScreen extends ConsumerStatefulWidget {
  const RoomsScreen({super.key});

  @override
  ConsumerState<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends ConsumerState<RoomsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCity = 'Casablanca';
  String _selectedCategory = 'all';
  bool _showPrayerTimeAware = false;
  bool _showHalalOnly = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void didUpdateWidget(covariant RoomsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.key != widget.key) {
      _tabController.dispose();
      _tabController = TabController(length: _tabs.length, vsync: this);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Tab> get _tabs {
    final user = ref.watch(userProvider);
    List<Tab> baseTabs = [
      const Tab(text: 'All Rooms'),
      const Tab(text: 'My Rooms'),
      const Tab(text: 'Popular'),
    ];

    if (user?.hasRole('business') == true) {
      baseTabs.add(const Tab(text: 'Business'));
    }
    if (user?.hasRole('guide') == true) {
      baseTabs.add(const Tab(text: 'Guide Network'));
    }
    if (user?.hasRole('premium') == true) {
      baseTabs.add(const Tab(text: 'Premium'));
    }

    return baseTabs;
  }

  List<Widget> _buildTabViews() {
    final user = ref.watch(userProvider);
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

    if (user?.hasRole('business') == true) {
      views.add(const BusinessRoomsTab());
    }
    if (user?.hasRole('guide') == true) {
      views.add(const GuideRoomsTab());
    }
    if (user?.hasRole('premium') == true) {
      views.add(PremiumRoomsTab(
        onJoinPremiumRoom: (room) => RoomInteractionHelpers.joinPremiumRoom(context, room, () => showPremiumUpgrade(context)),
        onShowPremiumUpgrade: () => showPremiumUpgrade(context),
      ));
    }

    return views;
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return RoomsScaffold(
      user: user,
      tabController: _tabController,
      selectedCity: _selectedCity,
      selectedCategory: _selectedCategory,
      showPrayerTimeAware: _showPrayerTimeAware,
      showHalalOnly: _showHalalOnly,
      onCitySelectorPressed: () => RoomInteractionHelpers.showCitySelector(context, _selectedCity, (city) {
        setState(() {
          _selectedCity = city;
        });
      }),
      onRoomSearchPressed: () => RoomInteractionHelpers.showRoomSearch(context),
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
      onCreateRoomPressed: () => RoomInteractionHelpers.showCreateRoomDialog(context, _selectedCity),
      tabs: _tabs,
      tabViews: _buildTabViews(),
    );
  }
}

final userProvider = Provider<DeadHourUser?>((ref) {
  // In a real app, you would get the user from your authentication provider.
  // For now, we'll use the mock user.
  return MockData.currentUser;
});