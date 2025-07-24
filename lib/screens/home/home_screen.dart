import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../utils/mock_data.dart';
import '../../widgets/common/deal_card.dart';
import '../../widgets/common/venue_card.dart';
import '../home/main_navigation_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  String _selectedCity = 'Casablanca';
  String _selectedCategory = 'all';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Prayer time indicator
            const SliverToBoxAdapter(
              child: PrayerTimeIndicator(isVisible: false),
            ),

            // Welcome section
            SliverToBoxAdapter(
              child: _buildWelcomeSection(),
            ),

            // Quick stats
            SliverToBoxAdapter(
              child: _buildQuickStats(),
            ),

            // Category filter
            SliverToBoxAdapter(
              child: _buildCategoryFilter(),
            ),

            // Active deals section
            SliverToBoxAdapter(
              child: _buildSectionHeader(
                title: 'Active Deals',
                subtitle: 'Limited time offers ending soon',
                onViewAll: () => context.go('/home/deals'),
              ),
            ),

            // Active deals list
            SliverToBoxAdapter(
              child: _buildActiveDeals(),
            ),

            // Nearby venues section
            SliverToBoxAdapter(
              child: _buildSectionHeader(
                title: 'Nearby Venues',
                subtitle: 'Discover amazing places around you',
              ),
            ),

            // Nearby venues list
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final venues = _getFilteredVenues();
                  if (index >= venues.length) return null;

                  return VenueCard(
                    venue: venues[index],
                    showDistance: true,
                    distance: 1.2 + (index * 0.3), // Mock distance
                    onTap: () => _showVenueDetails(venues[index]),
                  );
                },
                childCount: _getFilteredVenues().length,
              ),
            ),

            // Bottom padding
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
      floatingActionButton: QuickActionFAB(
        icon: Icons.search,
        tooltip: 'Search Deals',
        onPressed: () => _showSearchDialog(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DeadHour',
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
          onPressed: () => _showCitySelector(),
          icon: const Icon(Icons.tune),
        ),
        IconButton(
          onPressed: () => _showNotifications(),
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
        ),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.moroccoGreen, AppTheme.darkGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '🇲🇦',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome to DeadHour',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Discover amazing deals during off-peak hours',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildWelcomeStatItem('47', 'Deals Used'),
              const SizedBox(width: 24),
              _buildWelcomeStatItem('1,847', 'MAD Saved'),
              const SizedBox(width: 24),
              _buildWelcomeStatItem('4.8', 'Rating'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeStatItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              icon: Icons.local_fire_department,
              title: '23',
              subtitle: 'Active Deals',
              color: AppColors.error,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              icon: Icons.people,
              title: '1.2K',
              subtitle: 'Community',
              color: AppColors.info,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              icon: Icons.schedule,
              title: '2h 15m',
              subtitle: 'Time Left',
              color: AppColors.warning,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.secondaryText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final categories = [
      {'id': 'all', 'name': 'All', 'icon': '🏷️'},
      {'id': 'food', 'name': 'Food', 'icon': '🍕'},
      {'id': 'entertainment', 'name': 'Fun', 'icon': '🎮'},
      {'id': 'wellness', 'name': 'Spa', 'icon': '💆'},
      {'id': 'sports', 'name': 'Sports', 'icon': '⚽'},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category['id'];

          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: FilterChip(
              selected: isSelected,
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(category['icon']!, style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 6),
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
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String subtitle,
    VoidCallback? onViewAll,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          if (onViewAll != null)
            TextButton(
              onPressed: onViewAll,
              child: const Text('View All'),
            ),
        ],
      ),
    );
  }

  Widget _buildActiveDeals() {
    final activeDeals = MockData.deals.where((deal) => deal.isValid).toList();

    if (activeDeals.isEmpty) {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Column(
          children: [
            Icon(
              Icons.search_off,
              size: 48,
              color: AppTheme.lightText,
            ),
            SizedBox(height: 16),
            Text(
              'No active deals right now',
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.secondaryText,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Check back later for amazing offers',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.lightText,
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: activeDeals.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 320,
            child: DealCard(
              deal: activeDeals[index],
              onTap: () => _showDealDetails(activeDeals[index]),
            ),
          );
        },
      ),
    );
  }

  List<dynamic> _getFilteredVenues() {
    var venues = MockData.venues;

    if (_selectedCategory != 'all') {
      venues = venues.where((venue) => venue.category == _selectedCategory).toList();
    }

    return venues;
  }

  Future<void> _handleRefresh() async {
    // Simulate refresh
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

  void _showNotifications() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notifications'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.local_fire_department, color: AppColors.error),
              title: Text('New Flash Deal!'),
              subtitle: Text('50% off at Café Atlas - 2 hours left'),
              dense: true,
            ),
            ListTile(
              leading: Icon(Icons.people, color: AppColors.info),
              title: Text('Room Activity'),
              subtitle: Text('New message in Coffee Afternoon Deals'),
              dense: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Deals'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Search for venues, deals, or categories...',
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

  void _showVenueDetails(dynamic venue) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Text(
                  venue.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  venue.type,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppTheme.secondaryText,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  venue.description,
                  style: const TextStyle(fontSize: 14),
                ),
                // Add more venue details here
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDealDetails(dynamic deal) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.8,
        minChildSize: 0.4,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Text(
                  deal.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  deal.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppTheme.secondaryText,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      '${deal.discountedPrice.toInt()} MAD',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.moroccoGreen,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${deal.originalPrice.toInt()} MAD',
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppTheme.lightText,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Booking confirmed! Check your email for details.'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    },
                    child: const Text('Book Now'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
