import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:deadhour/routes/app_routes.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/utils/mock_data.dart';
import 'package:deadhour/utils/error_handler.dart';
import 'package:deadhour/utils/performance_utils.dart';
import 'package:deadhour/widgets/common/deal_card.dart';
import 'package:deadhour/widgets/common/venue_card.dart';
import 'package:deadhour/widgets/common/offline_status_widget.dart';
import 'package:deadhour/widgets/cultural/prayer_times_widget.dart';
import 'package:deadhour/services/offline_service.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
      body: ErrorBoundary(
        errorMessage: 'Unable to load home screen content',
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: CustomScrollView(
            controller: _scrollController,
            physics: const OptimizedScrollPhysics(),
            slivers: [
            // Offline status indicator
            const SliverToBoxAdapter(
              child: OfflineStatusWidget(),
            ),

            // Prayer times widget
            const SliverToBoxAdapter(
              child: PrayerTimesWidget(showCompact: true),
            ),
            
            // City selector
            SliverToBoxAdapter(
              child: _buildCitySelector(),
            ),

            // Category filter
            SliverToBoxAdapter(
              child: ErrorHandler.safeBuild(
                () => _buildCategoryFilter(),
                errorMessage: 'Unable to load category filter',
              ),
            ),

            // Active deals section
            SliverToBoxAdapter(
              child: _buildSectionHeaderWithSearch(
                title: 'Active Deals',
                subtitle: 'Limited time offers ending soon',
                onViewAll: () => context.go('/deals'),
                onSearch: _showSearchDialog,
              ),
            ),

            // Active deals list
            SliverToBoxAdapter(
              child: ErrorHandler.safeBuild(
                () => _buildActiveDeals(),
                errorMessage: 'Unable to load active deals',
              ),
            ),

            // Nearby venues section
            SliverToBoxAdapter(
              child: _buildSectionHeader(
                title: 'Nearby Venues',
                subtitle: 'Discover amazing places around you',
                onViewAll: () => context.go('/venues'),
              ),
            ),

            // Nearby venues list
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final venues = _getFilteredVenues();
                  if (index >= venues.length) return null;

                  return RepaintBoundary(
                    child: VenueCard(
                      venue: venues[index],
                      showDistance: true,
                      distance: 1.2 + (index * 0.3), // Mock distance
                      onTap: () => AppNavigation.goToVenueDetail(context, venues[index].id),
                    ),
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateDealAlert,
        backgroundColor: AppTheme.moroccoGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_business),
        label: const Text('Create Deal'),
        tooltip: 'Switch to business mode to create deals',
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
                PerformanceUtils.debounce(
                  const Duration(milliseconds: 200),
                  () => setState(() {
                    _selectedCategory = category['id']!;
                  }),
                );
                PerformanceUtils.hapticFeedback(HapticFeedbackType.selection);
              },
              selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
              checkmarkColor: AppTheme.moroccoGreen,
            ),
          );
        },
      ),
    );
  }

  Widget _buildCitySelector() {
    final cities = ['Casablanca', 'Marrakech', 'Fes', 'Rabat', 'Tangier', 'Agadir'];
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_city, color: AppTheme.moroccoGreen, size: 20),
          const SizedBox(width: 12),
          const Text(
            'Location:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryText,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCity,
                icon: const Icon(Icons.arrow_drop_down, size: 20),
                isExpanded: true,
                style: const TextStyle(
                  color: AppTheme.primaryText,
                  fontSize: 14,
                ),
                items: cities.map((String city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedCity = newValue;
                    });
                    // Filter deals and venues by selected city
                    debugPrint('Selected city: $_selectedCity');
                    
                    // Show feedback to user
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Location changed to $_selectedCity'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.my_location, size: 18),
            color: AppTheme.moroccoGreen,
            onPressed: () {
              setState(() {
                _selectedCity = 'Casablanca'; // Default/detected location
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Location updated to current position'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            tooltip: 'Use current location',
          ),
        ],
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

  Widget _buildSectionHeaderWithSearch({
    required String title,
    required String subtitle,
    VoidCallback? onViewAll,
    VoidCallback? onSearch,
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
          if (onSearch != null)
            IconButton(
              onPressed: onSearch,
              icon: const Icon(Icons.search),
              tooltip: 'Search',
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
    var activeDeals = MockData.deals.where((deal) => deal.isValid).toList();
    
    // Filter deals by selected city (check venue city)
    activeDeals = activeDeals.where((deal) {
      try {
        final venue = MockData.venues.firstWhere((v) => v.id == deal.venueId);
        return venue.city == _selectedCity || _selectedCity == 'Casablanca';
      } catch (e) {
        // If venue not found, show deal for all cities
        return true;
      }
    }).toList();

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
      venues =
          venues.where((venue) => venue.category == _selectedCategory).toList();
    }

    // Filter by selected city
    venues = venues.where((venue) {
      return venue.city == _selectedCity || _selectedCity == 'Casablanca';
    }).toList();

    return venues;
  }

  Future<void> _handleRefresh() async {
    return ErrorHandler.safeExecute(
      () async {
        final offlineService = OfflineService();

        if (offlineService.isOnline) {
          // Force refresh from server when online
          await offlineService.forceRefresh();
        } else {
          // Simulate refresh with cached data when offline
          await Future.delayed(const Duration(milliseconds: 500));
        }

        if (mounted) {
          setState(() {
            // Trigger rebuild to show refreshed data
          });
        }
      },
      context: context,
      errorMessage: 'Failed to refresh content',
    );
  }

  void _showSearchDialog() {
    final searchController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Deals'),
        content: TextField(
          controller: searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search for venues, deals, or categories...', 
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final query = searchController.text.trim();
              if (query.isNotEmpty) {
                // Implement search functionality
                debugPrint('Searching for: $query');
                Navigator.pop(context);
                // Navigate to deals screen with search context
                context.go('/deals');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Searching for "$query" in deals...'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
            child: const Text('Search'),
          ),
        ],
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
                const SizedBox(height: 16),
                // Action buttons row
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _saveDeal(deal),
                        icon: const Icon(Icons.bookmark_outline, size: 18),
                        label: const Text('Save'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _shareDeal(deal),
                        icon: const Icon(Icons.share_outlined, size: 18),
                        label: const Text('Share'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: deal.isValid ? () => _bookDeal(deal) : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      deal.isValid ? 'Book Now' : 'Deal Expired',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _bookDeal(dynamic deal) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Booking'),
        content: Text('Book this deal at ${deal.discountedPrice.toInt()} MAD?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text('Booking confirmed! Check your email for details.'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _shareDeal(dynamic deal) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Deal shared successfully!'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _saveDeal(dynamic deal) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Deal saved to your favorites!'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _showCreateDealAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.business, color: AppTheme.moroccoGreen),
            SizedBox(width: 12),
            Text('Create Deal'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Want to create deals for your business?',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const Text(
              'Switch to business mode to:',
            ),
            const SizedBox(height: 8),
            const Text('• Create and manage deals'),
            const Text('• Track performance analytics'),
            const Text('• Connect with customers'),
            const Text('• Optimize revenue during dead hours'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info, size: 16, color: AppTheme.moroccoGreen),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Business subscription: MAD 299/month',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Maybe Later'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.moroccoGreen,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              // Navigate to business onboarding or role switching
              debugPrint('Navigate to business mode');
              context.go('/roles/switching');
            },
            child: const Text('Start Business Account'),
          ),
        ],
      ),
    );
  }
}
