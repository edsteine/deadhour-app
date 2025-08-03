// DeadHourAppBar removed - handled by MainNavigationScreen
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../utils/mock_data.dart';
import '../../utils/auth_helpers.dart';
import '../../widgets/common/deal_card.dart';

class DealsScreen extends ConsumerStatefulWidget {
  const DealsScreen({super.key});

  @override
  ConsumerState<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends ConsumerState<DealsScreen> {
  String _selectedFilter = 'all'; // 'all', 'active', 'ending_soon', 'category'
  final String _sortBy =
      'ending_soon'; // 'ending_soon', 'discount', 'distance', 'rating'
  final bool _showMap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar removed - handled by MainNavigationScreen
      // Simple approach - filters moved to app bar, content focuses on deals
      body: Column(
        children: [
          // Simple results indicator
          _buildResultsHeader(),

          // Deals list or map (main focus)
          Expanded(
            child: _showMap ? _buildMapView() : _buildDealsListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'dealsCreateDealFAB',
        onPressed: _showCreateDealAlert,
        backgroundColor: AppTheme.moroccoGreen,
        icon: const Icon(Icons.add),
        label: const Text('Create Deal'),
      ),
    );
  }

  Widget _buildResultsHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          Text(
            '${_getFilteredDeals().length} deals found',
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.primaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          if (_selectedFilter != 'all')
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _getFilterDisplayName(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.moroccoGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => setState(() => _selectedFilter = 'all'),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: AppTheme.moroccoGreen,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _getFilterDisplayName() {
    switch (_selectedFilter) {
      case 'active':
        return 'Active Only';
      case 'ending_soon':
        return 'Ending Soon';
      case 'food':
        return 'Food';
      case 'entertainment':
        return 'Entertainment';  
      case 'wellness':
        return 'Wellness';
      default:
        return 'All Deals';
    }
  }

  Widget _buildDealsListView() {
    final deals = _getFilteredAndSortedDeals();

    if (deals.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: deals.length,
        itemBuilder: (context, index) {
          return DealCard(
            deal: deals[index],
            onTap: () => _showDealDetails(deals[index]),
          );
        },
      ),
    );
  }

  Widget _buildMapView() {
    return const ColoredBox(
      color: AppTheme.surfaceColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map_outlined,
              size: 64,
              color: AppTheme.lightText,
            ),
            SizedBox(height: 16),
            Text(
              'Map View',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.secondaryText,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Interactive map showing deals near you',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.lightText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off,
              size: 64,
              color: AppTheme.lightText,
            ),
            const SizedBox(height: 16),
            const Text(
              'No deals found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.secondaryText,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try adjusting your filters or check back later for new deals',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.lightText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedFilter = 'all';
                });
              },
              child: const Text('Clear Filters'),
            ),
          ],
        ),
      ),
    );
  }

  List<dynamic> _getFilteredDeals() {
    var deals = MockData.deals;

    switch (_selectedFilter) {
      case 'active':
        deals = deals.where((deal) => deal.isValid).toList();
        break;
      case 'ending_soon':
        deals = deals
            .where((deal) => deal.isValid && deal.urgencyLevel == 'urgent')
            .toList();
        break;
      case 'food':
      case 'entertainment':
      case 'wellness':
        final venues = MockData.venues
            .where((venue) => venue.category == _selectedFilter)
            .map((venue) => venue.id)
            .toList();
        deals = deals.where((deal) => venues.contains(deal.venueId)).toList();
        break;
    }

    return deals;
  }

  List<dynamic> _getFilteredAndSortedDeals() {
    final deals = _getFilteredDeals();

    switch (_sortBy) {
      case 'ending_soon':
        deals.sort((a, b) => a.validUntil.compareTo(b.validUntil));
        break;
      case 'discount':
        deals.sort((a, b) => b.discountValue.compareTo(a.discountValue));
        break;
      case 'distance':
        // Mock sorting by distance
        deals.sort((a, b) => a.id.compareTo(b.id));
        break;
      case 'rating':
        // Mock sorting by venue rating
        deals.sort((a, b) => b.id.compareTo(a.id));
        break;
    }

    return deals;
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }


  void _showDealDetails(dynamic deal) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          final venue = MockData.venues.firstWhere(
            (v) => v.id == deal.venueId,
            orElse: () => MockData.venues.first,
          );

          return Container(
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

                // Deal header
                Row(
                  children: [
                    Text(deal.statusIcon, style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            deal.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            venue.name,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppTheme.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.moroccoGreen,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        deal.discountDisplay,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Description
                Text(
                  deal.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),

                // Price and availability
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${deal.discountedPrice.toInt()} MAD',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.moroccoGreen,
                          ),
                        ),
                        Text(
                          '${deal.originalPrice.toInt()} MAD',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppTheme.lightText,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${deal.availableSpots} spots left',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          deal.timeLeftDisplay,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Book button
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
                const SizedBox(height: 16),

                // Share and save buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _shareDeal(deal),
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _saveDeal(deal),
                        icon: const Icon(Icons.bookmark_border),
                        label: const Text('Save'),
                      ),
                    ),
                  ],
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

    // Check if user is authenticated before allowing booking
    if (!AuthHelpers.requireAuthForBooking(context, ref)) {
      return; // User not authenticated, helper will show login prompt
    }

    // User is authenticated, proceed with booking
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
}
