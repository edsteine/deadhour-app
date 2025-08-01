import '../deals/widgets/deal_card.dart';
import '../venues/widgets/venue_card.dart';
import '../widgets/offline_status_widget.dart';
import '../../utils/app_routes.dart';
import '../../utils/offline_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../utils/app_theme.dart';
import '../../utils/mock_data.dart';
import '../../utils/error_handler.dart';
import '../../utils/performance_utils.dart';

import '../profile/widgets/prayer_times_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  // final String _selectedCity = 'Casablanca'; // TODO: Implement city selection
  String _selectedCategory = 'all';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
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

            // Category filter
            SliverToBoxAdapter(
              child: ErrorHandler.safeBuild(
                () => _buildCategoryFilter(),
                errorMessage: 'Unable to load category filter',
              ),
            ),

            // Active deals section
            SliverToBoxAdapter(
              child: _buildSectionHeader(
                title: 'Active Deals',
                subtitle: 'Limited time offers ending soon',
                onViewAll: () => context.go('/deals'),
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
      venues =
          venues.where((venue) => venue.category == _selectedCategory).toList();
    }

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
      showSnackBar: true,
    );
  }

  // TODO: Implement search dialog
  /*
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
  */


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

  // TODO: Implement create deal alert
  /*
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
              context.go('/business');
            },
            child: const Text('Go to Business'),
          ),
        ],
      ),
    );
  }
  */
}
