import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../utils/theme.dart';
import '../../utils/performance_utils.dart';
import '../../widgets/common/dev_menu_drawer.dart';
import '../../widgets/common/dead_hour_app_bar.dart';
import '../home/deals_screen.dart';
import '../home/venue_discovery_screen.dart';
import '../community/rooms_screen.dart';
import '../tourism/tourism_screen.dart';
import '../notifications/notifications_screen.dart';
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
  late PageController _pageController;
  int _currentIndex = 0;
  
  // Community filter state
  String _selectedRoomType = 'all_rooms';
  
  // Tourism filter state
  String _selectedTourismTab = 'discover';
  
  // Venue filter state
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
    
    // Set initial tab based on current route
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
        tabIndex = 0; // Default to deals tab
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
    // Better mobile UX - separate tabs for distinct content types
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
      const NotificationsScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent default back navigation
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        
        // Custom back button behavior
        if (_currentIndex != 0) {
          // If not on deals tab, go to deals tab first
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          // If on deals tab, show exit confirmation
          _showExitConfirmation(context);
        }
      },
      child: Scaffold(
        drawer: const DevMenuDrawer(), // Development menu drawer
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



  void _showRoomCreation() {
    PerformanceUtils.hapticFeedback(HapticFeedbackType.medium);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Community Room'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Room Name',
                hintText: 'e.g., Coffee Lovers Casablanca',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'What is this room about?',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Room creation feature coming soon!'),
                  backgroundColor: AppColors.info,
                ),
              );
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _markAllAsRead() {
    PerformanceUtils.hapticFeedback(HapticFeedbackType.selection);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _showProfileSettings() {
    PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
    context.go('/settings');
  }


  void _showDealsFilters() {
    PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Deal Filters',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Location Selection
                    const Text('Location', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.location_on, color: AppTheme.moroccoGreen),
                        title: const Text('Casablanca'),
                        subtitle: const Text('Current location'),
                        trailing: const Icon(Icons.keyboard_arrow_down),
                        onTap: () {
                          // Show location picker
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Select City'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...['Casablanca', 'Rabat', 'Marrakech', 'Fes', 'Tangier', 'Agadir'].map(
                                    (city) => ListTile(
                                      title: Text(city),
                                      onTap: () => Navigator.pop(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Quick Filters
                    const Text('Quick Filters', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        FilterChip(label: const Text('All Deals'), onSelected: (selected) {}),
                        FilterChip(label: const Text('Ending Soon'), onSelected: (selected) {}),
                        FilterChip(label: const Text('Active Only'), onSelected: (selected) {}),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Categories
                    const Text('Categories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ...['🍕 Food', '🎮 Entertainment', '💆 Wellness', '⚽ Sports'].map(
                      (category) => CheckboxListTile(
                        title: Text(category),
                        value: false,
                        onChanged: (value) {},
                        dense: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Sort Options
                    const Text('Sort By', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ...['Ending Soon', 'Best Discount', 'Nearest', 'Highest Rated'].map(
                      (sort) => RadioListTile<String>(
                        title: Text(sort),
                        value: sort.toLowerCase().replaceAll(' ', '_'),
                        groupValue: 'ending_soon',
                        onChanged: (value) {},
                        dense: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Price Range
                    const Text('Price Range', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ...['Any Price', 'Under 50 MAD', '50-100 MAD', 'Over 100 MAD'].map(
                      (price) => CheckboxListTile(
                        title: Text(price),
                        value: false,
                        onChanged: (value) {},
                        dense: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Deal Type
                    const Text('Deal Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ...['Flash Deals', 'Group Discounts', 'Happy Hour', 'Weekend Specials'].map(
                      (type) => CheckboxListTile(
                        title: Text(type),
                        value: false,
                        onChanged: (value) {},
                        dense: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Clear All'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Apply Filters'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showVenueFilters() {
    PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Venue Filters',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Location Selection
                    const Text('Location', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.location_on, color: AppTheme.moroccoGreen),
                        title: const Text('Casablanca'),
                        subtitle: const Text('Current location'),
                        trailing: const Icon(Icons.keyboard_arrow_down),
                        onTap: () {
                          // Show location picker
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Select City'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...['All Cities', 'Casablanca', 'Marrakech', 'Rabat', 'Fes', 'Tangier', 'Agadir'].map(
                                    (city) => ListTile(
                                      title: Text(city),
                                      onTap: () => Navigator.pop(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // View Options (replaces TabBar functionality)
                    const Text('View Options', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ...['List View', 'Map View', 'Nearby'].map(
                      (viewType) => RadioListTile<String>(
                        title: Row(
                          children: [
                            Icon(
                              viewType == 'List View' ? Icons.list :
                              viewType == 'Map View' ? Icons.map : Icons.near_me,
                              size: 20,
                              color: AppTheme.moroccoGreen,
                            ),
                            const SizedBox(width: 8),
                            Text(viewType),
                          ],
                        ),
                        value: viewType.toLowerCase().replaceAll(' ', '_'),
                        groupValue: _selectedVenueView,
                        onChanged: (value) {
                          setState(() {
                            _selectedVenueView = value!;
                          });
                          Navigator.pop(context);
                          _applyVenueViewFilter(value!);
                        },
                        dense: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Categories
                    const Text('Categories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ...['🏢 All Venues', '🍕 Food & Dining', '🎮 Entertainment', '💆 Wellness', '⚽ Sports', '🌍 Tourism', '👨‍👩‍👧‍👦 Family'].map(
                      (category) => CheckboxListTile(
                        title: Text(category),
                        value: false,
                        onChanged: (value) {},
                        dense: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Sort By
                    const Text('Sort By', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ...['Rating', 'Distance', 'Newest', 'Best Deals'].map(
                      (sort) => RadioListTile<String>(
                        title: Text(sort),
                        value: sort.toLowerCase(),
                        groupValue: 'rating',
                        onChanged: (value) {},
                        dense: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Distance
                    const Text('Distance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Slider(
                      value: 10,
                      min: 1,
                      max: 50,
                      divisions: 49,
                      label: '10 km',
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 16),
                    
                    // Price Range
                    const Text('Price Range', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ...['All Prices', '€ - Budget', '€€ - Moderate', '€€€ - Premium'].map(
                      (price) => CheckboxListTile(
                        title: Text(price),
                        value: false,
                        onChanged: (value) {},
                        dense: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Cultural & Accessibility Filters
                    const Text('Cultural & Accessibility', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      title: const Text('🥘 Halal Only'),
                      subtitle: const Text('Certified halal food'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('🕌 Prayer Friendly'),
                      subtitle: const Text('Prayer room available'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('Open Now'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    const SizedBox(height: 16),
                    
                    // Amenities
                    const Text('Amenities', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      title: const Text('WiFi Available'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('Card Payment'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('Verified Venue'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    const SizedBox(height: 16),
                    
                    // Social Features
                    const Text('Social Features', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      title: const Text('👥 Community Activity'),
                      subtitle: const Text('Show social proof'),
                      value: true,
                      onChanged: (value) {},
                      dense: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Clear All'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Apply Filters'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCommunityFilters() {
    PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Community Filters',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Location Selection
                    const Text('Location', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.location_on, color: AppTheme.moroccoGreen),
                        title: const Text('Casablanca'),
                        subtitle: const Text('Current location'),
                        trailing: const Icon(Icons.keyboard_arrow_down),
                        onTap: () {
                          // Show location picker
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Select City'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...['Casablanca', 'Rabat', 'Marrakech', 'Fes', 'Tangier', 'Agadir'].map(
                                    (city) => ListTile(
                                      title: Text(city),
                                      onTap: () => Navigator.pop(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Room Actions
                    const Text('Room Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showRoomCreation();
                        },
                        icon: const Icon(Icons.add_comment),
                        label: const Text('Create Room'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Room Categories (from CategoryFilter widget)
                    const Text('Room Categories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      title: const Text('🏷️ All Rooms'),
                      value: true,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('🍕 Food & Dining'),
                      subtitle: const Text('Restaurants, cafés, traditional dining'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('🎮 Entertainment'),
                      subtitle: const Text('Gaming, movies, nightlife'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('💆 Wellness & Spa'),
                      subtitle: const Text('Hammams, spas, fitness'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('🌍 Tourism & Culture'),
                      subtitle: const Text('Sights, guides, cultural experiences'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('⚽ Sports & Fitness'),
                      subtitle: const Text('Padel, football, gyms'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('👨‍👩‍👧‍👦 Family Fun'),
                      subtitle: const Text('Kids activities, family entertainment'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    const SizedBox(height: 16),
                    
                    // Cultural Filters (from CulturalFilters widget)
                    const Text('Cultural Filters', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      title: const Text('Prayer Time Aware'),
                      subtitle: const Text('Show rooms that consider prayer times'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    SwitchListTile(
                      title: const Text('Halal Only'),
                      subtitle: const Text('Show rooms focused on halal activities'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    const SizedBox(height: 16),
                    
                    // Room Type Selection (replaces TabBar functionality)
                    const Text('Room Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ...['All Rooms', 'My Rooms', 'Popular', 'Business', 'Guide Network'].map(
                      (roomType) => RadioListTile<String>(
                        title: Text(roomType),
                        value: roomType.toLowerCase().replaceAll(' ', '_'),
                        groupValue: _selectedRoomType,
                        onChanged: (value) {
                          setState(() {
                            _selectedRoomType = value!;
                          });
                          Navigator.pop(context);
                          _applyRoomTypeFilter(value!);
                        },
                        dense: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Activity Level & Sorting
                    const Text('Activity Level', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ...['Most Active', 'Recently Active', 'Newest Rooms', 'Most Members'].map(
                      (level) => RadioListTile<String>(
                        title: Text(level),
                        value: level.toLowerCase().replaceAll(' ', '_'),
                        groupValue: 'most_active',
                        onChanged: (value) {},
                        dense: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Clear All'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Apply Filters'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _applyRoomTypeFilter(String roomType) {
    // This will communicate with the RoomsScreen to change the active tab
    // For now, we can use a simple callback or state management
    // The RoomsScreen will listen to this state change
  }

  void _applyVenueViewFilter(String viewType) {
    // Communicate with the VenueDiscoveryScreen to change the view
    // Get reference to the current VenueDiscoveryScreen and update its view
    if (_currentIndex == 1) { // Venues tab
      final venueScreen = _tabViews[1] as VenueDiscoveryScreen;
      // We need to access the state, but we'll use a different approach
      // For now, store the state and let the screen rebuild with the new view
      setState(() {
        _selectedVenueView = viewType;
      });
    }
  }

  void _showTourismFilters() {
    PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Explore Morocco Filters',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Location Selection
                    const Text('Location', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.location_on, color: AppTheme.moroccoGreen),
                        title: const Text('Casablanca'),
                        subtitle: const Text('Current location'),
                        trailing: const Icon(Icons.keyboard_arrow_down),
                        onTap: () {
                          // Show location picker
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Select City'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...['All Morocco', 'Casablanca', 'Marrakech', 'Rabat', 'Fes', 'Tangier', 'Agadir', 'Chefchaouen'].map(
                                    (city) => ListTile(
                                      title: Text(city),
                                      onTap: () => Navigator.pop(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Content Type (replaces TabBar functionality)
                    const Text('Content Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ...['Discover', 'Local Experts', 'Experiences', 'Cultural'].map(
                      (contentType) => RadioListTile<String>(
                        title: Text(contentType),
                        value: contentType.toLowerCase().replaceAll(' ', '_'),
                        groupValue: _selectedTourismTab,
                        onChanged: (value) {
                          setState(() {
                            _selectedTourismTab = value!;
                          });
                          Navigator.pop(context);
                          _applyTourismFilter(value!);
                        },
                        dense: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Discovery Categories (from QuickDiscoveryGrid)
                    const Text('Discovery Categories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      title: const Text('🏛️ Historic Sites'),
                      subtitle: const Text('45 locations'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('🍽️ Food Tours'),
                      subtitle: const Text('28 experiences'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('🛒 Souks & Markets'),
                      subtitle: const Text('12 locations'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('🎨 Art & Crafts'),
                      subtitle: const Text('34 workshops'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('🌊 Beach & Coast'),
                      subtitle: const Text('18 locations'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('🏔️ Mountains'),
                      subtitle: const Text('22 locations'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    const SizedBox(height: 16),
                    
                    // Expert Specialties
                    const Text('Expert Specialties', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      title: const Text('📚 History & Culture'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('🍽️ Food & Markets'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('🎨 Art & Architecture'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('🏔️ Outdoor Adventures'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    const SizedBox(height: 16),
                    
                    // Experience Types
                    const Text('Experience Types', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      title: const Text('🏺 Traditional Crafts'),
                      subtitle: const Text('Pottery, weaving, metalwork'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('🏠 Home Cooking'),
                      subtitle: const Text('Authentic family meals'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('🕌 Spiritual & Cultural'),
                      subtitle: const Text('Respectful religious experiences'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('🛒 Shopping & Markets'),
                      subtitle: const Text('Souk navigation and bargaining'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    const SizedBox(height: 16),
                    
                    // Cultural & Language Preferences
                    const Text('Cultural Preferences', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      title: const Text('Prayer Time Aware'),
                      subtitle: const Text('Experiences that respect prayer times'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    SwitchListTile(
                      title: const Text('Halal Experiences Only'),
                      subtitle: const Text('Food and activities follow halal guidelines'),
                      value: false,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    SwitchListTile(
                      title: const Text('Tourist-Friendly'),
                      subtitle: const Text('English/French speaking guides'),
                      value: true,
                      onChanged: (value) {},
                      dense: true,
                    ),
                    const SizedBox(height: 16),
                    
                    // Price Range
                    const Text('Price Range', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ...['Free Beta Experiences', 'Under 100 MAD', '100-300 MAD', '300+ MAD Premium'].map(
                      (price) => CheckboxListTile(
                        title: Text(price),
                        value: false,
                        onChanged: (value) {},
                        dense: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Duration
                    const Text('Duration', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ...['Under 2 hours', '2-4 hours', 'Half day (4-6 hours)', 'Full day (6+ hours)'].map(
                      (duration) => CheckboxListTile(
                        title: Text(duration),
                        value: false,
                        onChanged: (value) {},
                        dense: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Sort Options
                    const Text('Sort By', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ...['Most Popular', 'Newest', 'Best Rated', 'Nearest', 'Price: Low to High', 'Price: High to Low'].map(
                      (sort) => RadioListTile<String>(
                        title: Text(sort),
                        value: sort.toLowerCase().replaceAll(' ', '_').replaceAll(':', ''),
                        groupValue: 'most_popular',
                        onChanged: (value) {},
                        dense: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Clear All'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Apply Filters'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _applyTourismFilter(String contentType) {
    // This will communicate with the TourismScreen to change the active tab
    // For now, we can use a simple callback or state management
    // The TourismScreen will listen to this state change
  }


  String? _getNotificationSubtitle() {
    // TODO: Get actual unread count from NotificationService
    // For now, returning null - subtitle will be handled by NotificationService
    return null;
  }

  void _updateNotificationFilter(String filter) {
    PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
    // TODO: Communicate with NotificationsScreen to update filter
    // This could be done through a state management solution or callback
  }

  void _showNotificationSettings() {
    PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
    // TODO: Navigate to notification settings or show bottom sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Notification Settings',
                  style: TextStyle(
                    fontSize: 20,
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
            const SizedBox(height: 16),
            const Text('Configure your notification preferences here.'),
            // TODO: Add actual settings UI
          ],
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
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Force exit the app
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text('Exit'),
          ),
        ],
      ),
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
        padding: const EdgeInsets.all(AppTheme.spacing12),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.moroccoGreen.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
        child: Icon(
          isActive ? item.activeIcon : item.icon,
          color: isActive ? AppTheme.moroccoGreen : AppTheme.secondaryText,
          size: 28, // Slightly larger since no text
        ),
      ),
    );
  }

  void _onItemTapped(int index, String route) {
    if (_currentIndex != index) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
    }
  }

  PreferredSizeWidget _buildAppBarForCurrentTab() {
    switch (_currentIndex) {
      case 0: // Deals
        return DeadHourAppBar(
          title: 'Active Deals',
          showMenuDrawer: true,
          showSearch: true,
          customActions: [
            // Single unified filter button
            IconButton(
              onPressed: _showDealsFilters,
              icon: const Icon(Icons.filter_list),
              tooltip: 'Filters',
            ),
          ],
        );
      case 1: // Venues
        return DeadHourAppBar(
          title: 'Nearby Venues',
          showMenuDrawer: true,
          showSearch: true,
          customActions: [
            // Single venue filter button
            IconButton(
              onPressed: _showVenueFilters,
              icon: const Icon(Icons.filter_list),
              tooltip: 'Filters',
            ),
          ],
        );
      case 2: // Community
        return DeadHourAppBar(
          title: 'Community Rooms',
          showMenuDrawer: true,
          showSearch: true,
          customActions: [
            // Single community filter button
            IconButton(
              onPressed: _showCommunityFilters,
              icon: const Icon(Icons.filter_list),
              tooltip: 'Filters',
            ),
          ],
        );
      case 3: // Tourism
        return DeadHourAppBar(
          title: 'Explore Morocco',
          showMenuDrawer: true,
          showSearch: true,
          customActions: [
            // Single tourism filter button
            IconButton(
              onPressed: _showTourismFilters,
              icon: const Icon(Icons.filter_list),
              tooltip: 'Filters',
            ),
          ],
        );
      case 4: // Notifications
        return DeadHourAppBar(
          title: 'Notifications',
          subtitle: _getNotificationSubtitle(),
          showMenuDrawer: true,
          customActions: [
            // Filter button with dropdown
            PopupMenuButton<String>(
              icon: const Icon(Icons.filter_list, color: Colors.white),
              tooltip: 'Filter Notifications',
              onSelected: (value) => _updateNotificationFilter(value),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'all',
                  child: Row(
                    children: [
                      Text('📱', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Text('All'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'deals',
                  child: Row(
                    children: [
                      Text('🔥', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Text('Deals'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'community',
                  child: Row(
                    children: [
                      Text('👥', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Text('Community'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'social',
                  child: Row(
                    children: [
                      Text('🎉', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Text('Social'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'cultural',
                  child: Row(
                    children: [
                      Text('🕌', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Text('Cultural'),
                    ],
                  ),
                ),
              ],
            ),
            // Mark all read button
            IconButton(
              onPressed: _markAllAsRead,
              icon: const Icon(Icons.done_all, color: Colors.white),
              tooltip: 'Mark All Read',
            ),
            // Settings button
            IconButton(
              onPressed: _showNotificationSettings,
              icon: const Icon(Icons.settings, color: Colors.white),
              tooltip: 'Settings',
            ),
          ],
        );
      case 5: // Profile
        return DeadHourAppBar(
          title: 'Profile',
          showMenuDrawer: true,
          customActions: [
            IconButton(
              onPressed: () => _showProfileSettings(),
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
            ),
          ],
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
