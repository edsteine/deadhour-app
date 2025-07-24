import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../utils/mock_data.dart';
import '../../widgets/common/room_card.dart';
import '../../models/user.dart';

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

  List<Tab> get _tabs {
    List<Tab> baseTabs = [
      const Tab(text: 'All Rooms'),
      const Tab(text: 'My Rooms'),
      const Tab(text: 'Popular'),
    ];
    
    // Add ADDON-specific tabs
    if (widget.user?.hasAddon('business') == true) {
      baseTabs.add(const Tab(text: 'Business'));
    }
    if (widget.user?.hasAddon('guide') == true) {
      baseTabs.add(const Tab(text: 'Guide Network'));
    }
    if (widget.user?.hasAddon('premium') == true) {
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
    if (oldWidget.user?.activeAddons != widget.user?.activeAddons) {
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
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Community health indicator
          _buildCommunityHealthIndicator(),

          // Category filter
          _buildCategoryFilter(),

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

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Community Rooms',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              const Icon(Icons.location_on, size: 14),
              const SizedBox(width: 4),
              Text(
                _selectedCity,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: _showCitySelector,
          icon: const Icon(Icons.tune),
        ),
        IconButton(
          onPressed: _showRoomSearch,
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  Widget _buildCommunityHealthIndicator() {
    final healthData = MockData.communityHealth;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.moroccoGreen, Color(0xFF006B3F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.people_alt,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Dual Problem Network Effects',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'ACTIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('🏢', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 4),
                        Text(
                          '${healthData['dailyActiveUsers'] ~/ 3} businesses posting deals',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text('🌟', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 4),
                        Text(
                          '${healthData['dailyActiveUsers']} discovering experiences',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final categories = [
      {'id': 'all', 'name': 'All Rooms', 'icon': '🏷️'},
      {'id': 'food', 'name': 'Food & Dining', 'icon': '🍕', 'color': AppColors.foodCategory},
      {'id': 'entertainment', 'name': 'Entertainment', 'icon': '🎮', 'color': AppColors.entertainmentCategory},
      {'id': 'wellness', 'name': 'Wellness & Spa', 'icon': '💆', 'color': AppColors.wellnessCategory},
      {'id': 'tourism', 'name': 'Tourism & Culture', 'icon': '🌍', 'color': AppColors.tourismCategory},
      {'id': 'sports', 'name': 'Sports & Fitness', 'icon': '⚽', 'color': AppColors.sportsCategory},
      {'id': 'family', 'name': 'Family Fun', 'icon': '👨‍👩‍👧‍👦', 'color': AppColors.familyCategory},
    ];

    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category['id'];

          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(category['icon']! as String, style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 4),
                  Text(category['name']! as String),
                ],
              ),
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category['id']! as String;
                });
              },
              selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
              checkmarkColor: AppTheme.moroccoGreen,
            ),
          );
        },
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
        builder: (context, scrollController) => _CreateRoomSheet(
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
    
    // Add ADDON-specific tab views
    if (widget.user?.hasAddon('business') == true) {
      views.add(_buildBusinessRoomsTab());
    }
    if (widget.user?.hasAddon('guide') == true) {
      views.add(_buildGuideRoomsTab());
    }
    if (widget.user?.hasAddon('premium') == true) {
      views.add(_buildPremiumRoomsTab());
    }
    
    return views;
  }

  Widget _buildBusinessRoomsTab() {
    // ADDON-enhanced rooms for business owners
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
    // ADDON-enhanced rooms for guide network
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
    context.push('/addon-marketplace');
  }
}

class _CreateRoomSheet extends StatefulWidget {
  final ScrollController scrollController;
  final String selectedCity;

  const _CreateRoomSheet({
    required this.scrollController,
    required this.selectedCity,
  });

  @override
  State<_CreateRoomSheet> createState() => _CreateRoomSheetState();
}

class _CreateRoomSheetState extends State<_CreateRoomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedCategory = 'food';
  String _selectedCity = 'Casablanca';
  bool _isPublic = true;
  bool _allowDeals = true;
  bool _isPrayerTimeAware = false;
  bool _isHalalOnly = false;
  bool _isPremiumOnly = false;

  final List<Map<String, dynamic>> _categories = [
    {
      'id': 'food',
      'name': 'Food & Dining',
      'icon': '🍕',
      'description': 'Restaurants, cafés, and culinary experiences',
      'examples': ['Coffee meetups', 'Restaurant deals', 'Food tours', 'Cooking classes']
    },
    {
      'id': 'entertainment',
      'name': 'Entertainment',
      'icon': '🎮',
      'description': 'Movies, games, and fun activities',
      'examples': ['Gaming tournaments', 'Cinema groups', 'Escape rooms', 'Comedy shows']
    },
    {
      'id': 'wellness',
      'name': 'Wellness & Spa',
      'icon': '💆',
      'description': 'Health, fitness, and relaxation',
      'examples': ['Spa deals', 'Hammam sessions', 'Fitness groups', 'Yoga classes']
    },
    {
      'id': 'sports',
      'name': 'Sports & Fitness',
      'icon': '⚽',
      'description': 'Sports activities and fitness',
      'examples': ['Padel matches', 'Football teams', 'Gym buddies', 'Running groups']
    },
    {
      'id': 'tourism',
      'name': 'Tourism & Culture',
      'icon': '🌍',
      'description': 'Local experiences and cultural activities',
      'examples': ['City tours', 'Cultural events', 'Local guides', 'Historical sites']
    },
    {
      'id': 'family',
      'name': 'Family Fun',
      'icon': '👨‍👩‍👧‍👦',
      'description': 'Family-friendly activities and events',
      'examples': ['Kids activities', 'Family outings', 'Parent groups', 'Children events']
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedCity = widget.selectedCity;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategoryData = _categories.firstWhere(
      (cat) => cat['id'] == _selectedCategory,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          controller: widget.scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    selectedCategoryData['icon'] as String,
                    style: const TextStyle(fontSize: 32),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Create New Room',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Build a community around ${selectedCategoryData['name']}',
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Category',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final isSelected = _selectedCategory == category['id'];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = category['id'] as String;
                        });
                      },
                      child: Container(
                        width: 100,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? AppTheme.moroccoGreen : Colors.grey[300]!,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: isSelected ? AppTheme.moroccoGreen.withValues(alpha: 0.1) : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              category['icon'] as String,
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category['name'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? AppTheme.moroccoGreen : null,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedCategoryData['description'] as String,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Popular room types:',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: (selectedCategoryData['examples'] as List<String>).map((example) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Text(
                            example,
                            style: const TextStyle(fontSize: 11),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Room Details',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Room Name *',
                  hintText: 'e.g., Coffee Lovers Casablanca',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a room name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCity,
                decoration: const InputDecoration(
                  labelText: 'City *',
                  border: OutlineInputBorder(),
                ),
                items: ['Casablanca', 'Marrakech', 'Rabat', 'Fez', 'Tangier', 'Agadir']
                    .map((city) => DropdownMenuItem(value: city, child: Text(city)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description *',
                  hintText: 'What will members do in this room?',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Room Settings',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: const Text('Public Room'),
                subtitle: const Text('Anyone can find and join this room'),
                value: _isPublic,
                onChanged: (value) {
                  setState(() {
                    _isPublic = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Allow Deal Sharing'),
                subtitle: const Text('Members can share venue deals and offers'),
                value: _allowDeals,
                onChanged: (value) {
                  setState(() {
                    _allowDeals = value;
                  });
                },
              ),
              if (_selectedCategory == 'food' || _selectedCategory == 'wellness')
                SwitchListTile(
                  title: const Text('Halal Only'),
                  subtitle: const Text('Focus on halal venues and activities'),
                  value: _isHalalOnly,
                  onChanged: (value) {
                    setState(() {
                      _isHalalOnly = value;
                    });
                  },
                ),
              SwitchListTile(
                title: const Text('Prayer Time Aware'),
                subtitle: const Text('Consider prayer times when scheduling activities'),
                value: _isPrayerTimeAware,
                onChanged: (value) {
                  setState(() {
                    _isPrayerTimeAware = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Premium Room'),
                subtitle: const Text('Only premium members can join'),
                value: _isPremiumOnly,
                onChanged: (value) {
                  setState(() {
                    _isPremiumOnly = value;
                  });
                },
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _createRoom,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.moroccoGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Create Room'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _createRoom() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${_nameController.text} room created successfully!'),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'View',
            onPressed: () {},
          ),
        ),
      );
    }
  }
}
