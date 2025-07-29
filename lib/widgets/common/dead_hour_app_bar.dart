import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../utils/performance_utils.dart';
import '../../widgets/cultural/prayer_times_widget.dart';

// Unified App Bar for consistent styling and functionality across all tabs
class DeadHourAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? customActions;
  final Widget? leading;
  final bool showBackButton;
  final bool showMenuDrawer;
  final bool showLocationSelector;
  final bool showNotifications;
  final bool showSearch;
  final bool showBusinessActions;
  final bool showTourismActions;
  final String? selectedCity;
  final VoidCallback? onCityChanged;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onNotificationsPressed;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onCreateDealPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;

  const DeadHourAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.customActions,
    this.leading,
    this.showBackButton = false,
    this.showMenuDrawer = true,
    this.showLocationSelector = true,
    this.showNotifications = false,
    this.showSearch = false,
    this.showBusinessActions = false,
    this.showTourismActions = false,
    this.selectedCity,
    this.onCityChanged,
    this.onSearchPressed,
    this.onNotificationsPressed,
    this.onMenuPressed,
    this.onCreateDealPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
  });

  @override
  ConsumerState<DeadHourAppBar> createState() => _DeadHourAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DeadHourAppBarState extends ConsumerState<DeadHourAppBar> {
  String _selectedCity = 'Casablanca';

  @override
  void initState() {
    super.initState();
    _selectedCity = widget.selectedCity ?? 'Casablanca';
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _buildTitle(),
      backgroundColor: widget.backgroundColor ?? AppTheme.moroccoGreen,
      foregroundColor: widget.foregroundColor ?? Colors.white,
      elevation: widget.elevation,
      centerTitle: false,
      leading: _buildLeading(),
      actions: _buildActions(),
    );
  }

  Widget _buildTitle() {
    if (widget.subtitle != null || widget.showLocationSelector) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: widget.foregroundColor ?? Colors.white,
            ),
          ),
          if (widget.subtitle != null)
            Text(
              widget.subtitle!,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: (widget.foregroundColor ?? Colors.white)
                    .withValues(alpha: 0.8),
              ),
            ),
          if (widget.showLocationSelector)
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 14,
                    color: widget.foregroundColor ?? Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      _selectedCity,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: widget.foregroundColor ?? Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    }

    return Text(
      widget.title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: widget.foregroundColor ?? Colors.white,
      ),
    );
  }

  Widget? _buildLeading() {
    if (widget.leading != null) return widget.leading;
    if (widget.showBackButton) return const BackButton();
    if (widget.showMenuDrawer) {
      return Builder(
        builder: (context) => IconButton(
          onPressed: () {
            PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
          tooltip: 'Dev Menu',
        ),
      );
    }
    return null;
  }

  List<Widget> _buildActions() {
    List<Widget> actions = [];

    // Custom actions first
    if (widget.customActions != null) {
      actions.addAll(widget.customActions!);
    }

    // Location selector removed - now integrated into filter bottom sheets

    // Business actions
    if (widget.showBusinessActions) {
      actions.add(
        IconButton(
          onPressed: () {
            PerformanceUtils.hapticFeedback(HapticFeedbackType.medium);
            if (widget.onCreateDealPressed != null) {
              widget.onCreateDealPressed!();
            } else {
              _showCreateDealAlert();
            }
          },
          icon: const Icon(Icons.add_business),
          tooltip: 'Create Deal',
        ),
      );
    }

    // Tourism actions
    if (widget.showTourismActions) {
      actions.add(
        IconButton(
          onPressed: () {
            PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
            if (widget.onMenuPressed != null) {
              widget.onMenuPressed!();
            } else {
              _showTourismMenu();
            }
          },
          icon: const Icon(Icons.more_vert),
          tooltip: 'Tourism Menu',
        ),
      );
    }

    // Search action
    if (widget.showSearch) {
      actions.add(
        IconButton(
          onPressed: () {
            PerformanceUtils.hapticFeedback(HapticFeedbackType.medium);
            if (widget.onSearchPressed != null) {
              widget.onSearchPressed!();
            } else {
              _showSearchDialog();
            }
          },
          icon: const Icon(Icons.search),
          tooltip: 'Search',
        ),
      );
    }

    // Notifications action
    if (widget.showNotifications) {
      actions.add(
        IconButton(
          onPressed: () {
            PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
            if (widget.onNotificationsPressed != null) {
              widget.onNotificationsPressed!();
            } else {
              _showNotifications();
            }
          },
          icon: Stack(
            children: [
              const Icon(Icons.notifications_outlined),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          tooltip: 'Notifications',
        ),
      );
    }

    return actions;
  }


  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _NotificationsBottomSheet(),
    );
  }

  void _showSearchDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _SearchBottomSheet(),
    );
  }

  void _showCreateDealAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Deal'),
        content: const Text(
          'Are you a business owner? Switch to business mode to create deals for your venue.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to business role or profile
            },
            child: const Text('Go to Business'),
          ),
        ],
      ),
    );
  }

  void _showTourismMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Tourism Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              subtitle: const Text('العربية • Français • English'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Premium Features'),
              subtitle: const Text('Unlock expert connections'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Tourist Guide'),
              subtitle: const Text('How to use DeadHour in Morocco'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

// Comprehensive Search Bottom Sheet
class _SearchBottomSheet extends StatefulWidget {
  @override
  State<_SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<_SearchBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'all';
  String _selectedLocation = 'all';

  final List<Map<String, String>> _categories = [
    {'id': 'all', 'name': 'All', 'icon': '🔍'},
    {'id': 'deals', 'name': 'Deals', 'icon': '🏷️'},
    {'id': 'venues', 'name': 'Venues', 'icon': '🏪'},
    {'id': 'experiences', 'name': 'Experiences', 'icon': '🎯'},
    {'id': 'experts', 'name': 'Local Experts', 'icon': '👨‍🏫'},
    {'id': 'rooms', 'name': 'Community Rooms', 'icon': '👥'},
  ];

  final List<Map<String, String>> _locations = [
    {'id': 'all', 'name': 'All Morocco'},
    {'id': 'casablanca', 'name': 'Casablanca'},
    {'id': 'rabat', 'name': 'Rabat'},
    {'id': 'marrakech', 'name': 'Marrakech'},
    {'id': 'fes', 'name': 'Fes'},
    {'id': 'tangier', 'name': 'Tangier'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Search header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search DeadHour...',
                      prefixIcon: const Icon(Icons.search,
                          color: AppTheme.moroccoGreen),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                              icon: const Icon(Icons.clear),
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            const BorderSide(color: AppTheme.moroccoGreen),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Filters
          _buildFilters(),
          const SizedBox(height: 16),

          // Search results
          Expanded(
            child: _searchQuery.isEmpty
                ? _buildQuickActions()
                : _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      children: [
        // Category filters
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = _selectedCategory == category['id'];

              return Container(
                margin: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  selected: isSelected,
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(category['icon']!,
                          style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 4),
                      Text(category['name']!),
                    ],
                  ),
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = category['id']!;
                    });
                  },
                  selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
                  checkmarkColor: AppTheme.moroccoGreen,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),

        // Location filter
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: DropdownButtonFormField<String>(
            value: _selectedLocation,
            decoration: InputDecoration(
              labelText: 'Location',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.location_on),
            ),
            items: _locations.map((location) {
              return DropdownMenuItem(
                value: location['id'],
                child: Text(location['name']!),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedLocation = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    final quickActions = [
      {
        'title': 'Trending Deals',
        'subtitle': 'Hot deals ending soon',
        'icon': Icons.trending_up,
        'color': Colors.orange
      },
      {
        'title': 'Nearby Venues',
        'subtitle': 'Discover places around you',
        'icon': Icons.location_on,
        'color': Colors.blue
      },
      {
        'title': 'Active Rooms',
        'subtitle': 'Join ongoing conversations',
        'icon': Icons.people,
        'color': Colors.green
      },
      {
        'title': 'Local Experts',
        'subtitle': 'Connect with Moroccan guides',
        'icon': Icons.person_pin,
        'color': Colors.purple
      },
      {
        'title': 'Cultural Events',
        'subtitle': 'Traditional festivals & events',
        'icon': Icons.event,
        'color': Colors.red
      },
      {
        'title': 'Food & Dining',
        'subtitle': 'Best Moroccan cuisine deals',
        'icon': Icons.restaurant,
        'color': Colors.amber
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: quickActions.length,
      itemBuilder: (context, index) {
        final action = quickActions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (action['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                action['icon'] as IconData,
                color: action['color'] as Color,
              ),
            ),
            title: Text(action['title'] as String),
            subtitle: Text(action['subtitle'] as String),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to relevant screen based on action
              Navigator.pop(context);
              _handleQuickAction(action['title'] as String);
            },
          ),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    // Mock search results based on query and filters
    final results = _getSearchResults();

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search or filters',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppTheme.moroccoGreen.withValues(alpha: 0.1),
              child: Text(
                result['icon'] as String,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            title: Text(result['title'] as String),
            subtitle: Text(result['subtitle'] as String),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                result['type'] as String,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.moroccoGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              _handleSearchResult(result);
            },
          ),
        );
      },
    );
  }

  List<Map<String, String>> _getSearchResults() {
    if (_searchQuery.length < 2) return [];

    // Mock search results - in real app, this would call an API
    final allResults = [
      {
        'title': 'Pizza Corner',
        'subtitle': '30% off during 3-5 PM',
        'type': 'Deal',
        'icon': '🍕',
        'category': 'deals'
      },
      {
        'title': 'Café Central',
        'subtitle': 'Best coffee in Casablanca',
        'type': 'Venue',
        'icon': '☕',
        'category': 'venues'
      },
      {
        'title': 'Hassan II Mosque Tour',
        'subtitle': 'Guided cultural experience',
        'type': 'Experience',
        'icon': '🕌',
        'category': 'experiences'
      },
      {
        'title': 'Food Lovers Room',
        'subtitle': '152 members talking about food',
        'type': 'Room',
        'icon': '🍽️',
        'category': 'rooms'
      },
      {
        'title': 'Ahmed - Local Guide',
        'subtitle': 'Expert in Marrakech medina',
        'type': 'Expert',
        'icon': '👨‍🏫',
        'category': 'experts'
      },
      {
        'title': 'Tajine Workshop',
        'subtitle': 'Learn traditional cooking',
        'type': 'Experience',
        'icon': '🍲',
        'category': 'experiences'
      },
    ];

    return allResults.where((result) {
      final matchesQuery =
          result['title']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              result['subtitle']!
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == 'all' || result['category'] == _selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case 'Trending Deals':
        context.go('/deals');
        break;
      case 'Nearby Venues':
        context.go('/venues');
        break;
      case 'Active Rooms':
        context.go('/community');
        break;
      case 'Local Experts':
        context.go('/local-expert');
        break;
      case 'Cultural Events':
        context.go('/tourism');
        break;
      case 'Food & Dining':
        context.go('/deals');
        break;
    }
  }

  void _handleSearchResult(Map<String, String> result) {
    switch (result['type']) {
      case 'Deal':
        context.go('/deals');
        break;
      case 'Venue':
        context.go('/venues');
        break;
      case 'Experience':
        context.go('/tourism');
        break;
      case 'Room':
        context.go('/community');
        break;
      case 'Expert':
        context.go('/local-expert');
        break;
    }
  }
}

// Comprehensive Notifications Bottom Sheet
class _NotificationsBottomSheet extends StatefulWidget {
  @override
  State<_NotificationsBottomSheet> createState() =>
      _NotificationsBottomSheetState();
}

class _NotificationsBottomSheetState extends State<_NotificationsBottomSheet>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),

          // Prayer times widget
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: PrayerTimesWidget(isVisible: true),
          ),
          const SizedBox(height: 16),

          // Tab bar
          TabBar(
            controller: _tabController,
            labelColor: AppTheme.moroccoGreen,
            unselectedLabelColor: AppTheme.secondaryText,
            indicatorColor: AppTheme.moroccoGreen,
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Deals'),
              Tab(text: 'Community'),
              Tab(text: 'Tourism'),
            ],
          ),

          // Tab views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAllNotifications(),
                _buildDealsNotifications(),
                _buildCommunityNotifications(),
                _buildTourismNotifications(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllNotifications() {
    final notifications = [
      {
        'title': 'New Flash Deal!',
        'subtitle': '50% off at Café Atlas - 2 hours left',
        'icon': Icons.local_fire_department,
        'color': AppColors.error,
        'time': '5m ago',
        'type': 'deal'
      },
      {
        'title': 'Room Activity',
        'subtitle': 'New message in Coffee Afternoon Deals',
        'icon': Icons.people,
        'color': AppColors.info,
        'time': '15m ago',
        'type': 'community'
      },
      {
        'title': 'Expert Request',
        'subtitle': 'New tourist needs local guide assistance',
        'icon': Icons.star,
        'color': AppColors.warning,
        'time': '1h ago',
        'type': 'tourism'
      },
      {
        'title': 'Booking Confirmed',
        'subtitle': 'Your table at Restaurant Al-Fassia is ready',
        'icon': Icons.check_circle,
        'color': AppColors.success,
        'time': '2h ago',
        'type': 'deal'
      },
      {
        'title': 'Prayer Time Reminder',
        'subtitle': 'Maghrib prayer in 10 minutes',
        'icon': Icons.access_time,
        'color': AppColors.prayerTime,
        'time': '10m ago',
        'type': 'cultural'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (notification['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                notification['icon'] as IconData,
                color: notification['color'] as Color,
              ),
            ),
            title: Text(notification['title'] as String),
            subtitle: Text(notification['subtitle'] as String),
            trailing: Text(
              notification['time'] as String,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              _handleNotificationTap(notification['type'] as String);
            },
          ),
        );
      },
    );
  }

  Widget _buildDealsNotifications() {
    final dealNotifications = [
      {
        'title': 'Flash Deal Alert!',
        'subtitle': '50% off at Café Atlas - Limited time',
        'icon': Icons.local_fire_department,
        'time': '5m ago',
        'venue': 'Café Atlas',
        'discount': '50%'
      },
      {
        'title': 'Booking Confirmed',
        'subtitle': 'Table for 2 at Restaurant Al-Fassia',
        'icon': Icons.check_circle,
        'time': '2h ago',
        'venue': 'Restaurant Al-Fassia',
        'discount': '25%'
      },
      {
        'title': 'Deal Ending Soon',
        'subtitle': 'Happy hour at Café Central expires in 30 min',
        'icon': Icons.timer,
        'time': '30m ago',
        'venue': 'Café Central',
        'discount': '30%'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: dealNotifications.length,
      itemBuilder: (context, index) {
        final notification = dealNotifications[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                notification['icon'] as IconData,
                color: AppTheme.moroccoGreen,
              ),
            ),
            title: Text(notification['title'] as String),
            subtitle: Text(notification['subtitle'] as String),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    notification['discount'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  notification['time'] as String,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              context.go('/deals');
            },
          ),
        );
      },
    );
  }

  Widget _buildCommunityNotifications() {
    final communityNotifications = [
      {
        'title': 'New Message',
        'subtitle': 'Coffee Afternoon Deals room',
        'icon': Icons.chat_bubble,
        'time': '15m ago',
        'room': 'Coffee Afternoon Deals',
        'members': '42 members'
      },
      {
        'title': 'Room Joined',
        'subtitle': 'Welcome to Food Lovers Morocco!',
        'icon': Icons.group_add,
        'time': '1h ago',
        'room': 'Food Lovers Morocco',
        'members': '156 members'
      },
      {
        'title': 'Group Deal',
        'subtitle': 'Form a group for Tajine cooking class',
        'icon': Icons.group,
        'time': '3h ago',
        'room': 'Cultural Experiences',
        'members': '89 members'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: communityNotifications.length,
      itemBuilder: (context, index) {
        final notification = communityNotifications[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                notification['icon'] as IconData,
                color: AppColors.info,
              ),
            ),
            title: Text(notification['title'] as String),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification['subtitle'] as String),
                Text(
                  notification['members'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            trailing: Text(
              notification['time'] as String,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              context.go('/community');
            },
          ),
        );
      },
    );
  }

  Widget _buildTourismNotifications() {
    final tourismNotifications = [
      {
        'title': 'Expert Request',
        'subtitle': 'Tourist needs guide for Marrakech medina',
        'icon': Icons.person_pin,
        'time': '1h ago',
        'location': 'Marrakech',
        'earnings': '€25'
      },
      {
        'title': 'Cultural Event',
        'subtitle': 'Gnawa Festival starting tomorrow',
        'icon': Icons.event,
        'time': '4h ago',
        'location': 'Essaouira',
        'earnings': null
      },
      {
        'title': 'New Experience',
        'subtitle': 'Traditional henna workshop available',
        'icon': Icons.palette,
        'time': '6h ago',
        'location': 'Fes',
        'earnings': '€15'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: tourismNotifications.length,
      itemBuilder: (context, index) {
        final notification = tourismNotifications[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.tourismCategory.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                notification['icon'] as IconData,
                color: AppColors.tourismCategory,
              ),
            ),
            title: Text(notification['title'] as String),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification['subtitle'] as String),
                Text(
                  notification['location'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (notification['earnings'] != null)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.tourismCategory,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      notification['earnings'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const SizedBox(height: 2),
                Text(
                  notification['time'] as String,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              context.go('/tourism');
            },
          ),
        );
      },
    );
  }

  void _handleNotificationTap(String type) {
    switch (type) {
      case 'deal':
        context.go('/deals');
        break;
      case 'community':
        context.go('/community');
        break;
      case 'tourism':
        context.go('/tourism');
        break;
      case 'cultural':
        // Stay on current screen but show cultural info
        break;
    }
  }
}
