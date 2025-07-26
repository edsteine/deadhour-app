import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../utils/mock_data.dart';
import '../../widgets/common/room_card.dart';
import '../../models/user.dart';
import '../../models/room.dart';
import 'package:deadhour/screens/community/widgets/community_app_bar.dart';
import 'package:deadhour/screens/community/widgets/community_health_indicator.dart';
import 'package:deadhour/screens/community/widgets/category_filter.dart';
import 'package:deadhour/screens/community/widgets/cultural_filters.dart';
import 'package:deadhour/screens/community/widgets/create_room_sheet.dart';

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
        onCitySelectorPressed: _showCitySelector,
        onRoomSearchPressed: _showRoomSearch,
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
        onPressed: _showCreateRoomDialog,
        backgroundColor: AppTheme.moroccoGreen,
        icon: const Icon(Icons.add),
        label: const Text('Create Room'),
      ),
    );
  }

  

  Widget _buildAllRoomsTab() {
    final rooms = _getFilteredRooms();

    if (rooms.isEmpty) {
      return _buildEmptyState(
        icon: Icons.forum_outlined,
        title: 'No rooms found',
        subtitle: 'Try adjusting your filters or create a new room',
      );
    }

    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          return RoomCard(
            room: rooms[index],
            onTap: () => _joinRoom(rooms[index]),
          );
        },
      ),
    );
  }

  Widget _buildMyRoomsTab() {
    // Mock user's joined rooms
    final myRooms = MockData.rooms.take(2).toList();

    if (myRooms.isEmpty) {
      return _buildEmptyState(
        icon: Icons.person_outline,
        title: 'No joined rooms',
        subtitle: 'Join rooms to start discovering and connecting with the community',
        actionText: 'Browse Rooms',
        onAction: () => _tabController.animateTo(0),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: myRooms.length,
      itemBuilder: (context, index) {
        return RoomCard(
          room: myRooms[index],
          onTap: () => _openRoom(myRooms[index]),
        );
      },
    );
  }

  Widget _buildPopularRoomsTab() {
    final popularRooms = MockData.rooms.where((room) => room.memberCount > 100).toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: popularRooms.length,
      itemBuilder: (context, index) {
        return RoomCard(
          room: popularRooms[index],
          onTap: () => _joinRoom(popularRooms[index]),
        );
      },
    );
  }

  Widget _buildPremiumRoomsTab() {
    final premiumRooms = MockData.rooms.where((room) => room.isPremiumOnly).toList();

    if (premiumRooms.isEmpty) {
      return _buildEmptyState(
        icon: Icons.workspace_premium,
        title: 'Premium Rooms',
        subtitle: 'Exclusive rooms for premium members with local experts and curated experiences',
        actionText: 'Upgrade to Premium',
        onAction: _showPremiumUpgrade,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: premiumRooms.length,
      itemBuilder: (context, index) {
        return RoomCard(
          room: premiumRooms[index],
          onTap: () => _joinPremiumRoom(premiumRooms[index]),
        );
      },
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    String? actionText,
    VoidCallback? onAction,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: AppTheme.lightText,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.secondaryText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.lightText,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionText != null && onAction != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onAction,
                child: Text(actionText),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<dynamic> _getFilteredRooms() {
    var rooms = MockData.rooms;

    if (_selectedCategory != 'all') {
      rooms = rooms.where((room) => room.category == _selectedCategory).toList();
    }

    // Filter by city
    rooms = rooms.where((room) => room.city == _selectedCity).toList();

    // Apply cultural filters
    if (_showPrayerTimeAware) {
      rooms = rooms.where((room) => room.isPrayerTimeAware).toList();
    }
    if (_showHalalOnly) {
      rooms = rooms.where((room) => room.isHalalOnly).toList();
    }

    return rooms;
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  void _showCitySelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select City',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...['Casablanca', 'Rabat', 'Marrakech', 'Fez'].map((city) {
              return ListTile(
                leading: const Icon(Icons.location_city),
                title: Text(city),
                trailing: _selectedCity == city ? const Icon(Icons.check) : null,
                onTap: () {
                  setState(() {
                    _selectedCity = city;
                  });
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showRoomSearch() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Rooms'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Search for rooms, topics, or categories...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  void _showCreateRoomDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => CreateRoomSheet(
          scrollController: scrollController,
          selectedCity: _selectedCity,
        ),
      ),
    );
  }

  void _joinRoom(dynamic room) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Join ${room.displayName}?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(room.description),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.people, size: 16, color: AppTheme.secondaryText),
                const SizedBox(width: 4),
                Text('${room.memberCount} members'),
                const SizedBox(width: 16),
                const Icon(Icons.circle, size: 8, color: AppColors.success),
                const SizedBox(width: 4),
                Text('${room.onlineCount} online'),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _openRoom(room);
            },
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }

  void _openRoom(dynamic room) {
    context.go('/community/room/${room.id}');
  }

  void _joinPremiumRoom(dynamic room) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Premium Room'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.workspace_premium,
              size: 48,
              color: AppTheme.moroccoGold,
            ),
            const SizedBox(height: 16),
            Text(
              room.displayName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This is a premium room with exclusive features and local expert access.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showPremiumUpgrade();
            },
            child: const Text('Upgrade to Premium'),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTabViews() {
    List<Widget> views = [
      _buildAllRoomsTab(),
      _buildMyRoomsTab(),
      _buildPopularRoomsTab(),
    ];
    
    // Add Role-specific tab views
    if (widget.user?.hasRole('business') == true) {
      views.add(_buildBusinessRoomsTab());
    }
    if (widget.user?.hasRole('guide') == true) {
      views.add(_buildGuideRoomsTab());
    }
    if (widget.user?.hasRole('premium') == true) {
      views.add(_buildPremiumRoomsTab());
    }
    
    return views;
  }

  Widget _buildBusinessRoomsTab() {
    // Role-enhanced rooms for business owners
    final businessRooms = [
      {'id': 'business-owners-lounge', 'name': 'Business Owners Lounge', 'category': 'business', 'members': 234},
      {'id': 'revenue-optimization', 'name': 'Revenue Optimization', 'category': 'business', 'members': 156},
      {'id': 'dead-hours-strategies', 'name': 'Dead Hours Strategies', 'category': 'business', 'members': 89},
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: businessRooms.length,
      itemBuilder: (context, index) {
        final room = businessRooms[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.moroccoGreen.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.moroccoGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.business, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room['name']! as String,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${room['members']} business owners',
                      style: const TextStyle(fontSize: 12, color: AppTheme.secondaryText),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.secondaryText),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGuideRoomsTab() {
    // Role-enhanced rooms for guide network
    final guideRooms = [
      {'id': 'guide-network', 'name': 'Guide Network Hub', 'category': 'guide', 'members': 189},
      {'id': 'cultural-insights', 'name': 'Cultural Insights', 'category': 'guide', 'members': 267},
      {'id': 'local-secrets', 'name': 'Local Secrets Exchange', 'category': 'guide', 'members': 134},
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: guideRooms.length,
      itemBuilder: (context, index) {
        final room = guideRooms[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.moroccoGreen.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.moroccoGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.explore, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room['name']! as String,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${room['members']} local guides',
                      style: const TextStyle(fontSize: 12, color: AppTheme.secondaryText),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.secondaryText),
            ],
          ),
        );
      },
    );
  }

  void _showPremiumUpgrade() {
    context.push('/roles');
  }
}


