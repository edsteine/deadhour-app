import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../utils/mock_data.dart';
import '../../widgets/common/deal_card.dart';
import '../home/main_navigation_screen.dart';

class DealsScreen extends StatefulWidget {
  const DealsScreen({super.key});

  @override
  State<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends State<DealsScreen> {
  String _selectedFilter = 'all'; // 'all', 'active', 'ending_soon', 'category'
  String _selectedCategory = 'all';
  String _sortBy = 'ending_soon'; // 'ending_soon', 'discount', 'distance', 'rating'
  bool _showMap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeadHourAppBar(
        title: 'All Deals',
        showBackButton: true,
        actions: [
          IconButton(
            onPressed: () => setState(() => _showMap = !_showMap),
            icon: Icon(_showMap ? Icons.list : Icons.map),
          ),
          IconButton(
            onPressed: _showFilterBottomSheet,
            icon: const Icon(Icons.tune),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          _buildFilterChips(),

          // Sort and view options
          _buildSortAndViewOptions(),

          // Deals list or map
          Expanded(
            child: _showMap ? _buildMapView() : _buildDealsListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "dealsCreateDealFAB",
        onPressed: _showCreateDealAlert,
        backgroundColor: AppTheme.moroccoGreen,
        icon: const Icon(Icons.add),
        label: const Text('Create Deal'),
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = [
      {'id': 'all', 'name': 'All Deals', 'icon': '🏷️'},
      {'id': 'active', 'name': 'Active', 'icon': '✅'},
      {'id': 'ending_soon', 'name': 'Ending Soon', 'icon': '⏰'},
      {'id': 'food', 'name': 'Food', 'icon': '🍕'},
      {'id': 'entertainment', 'name': 'Entertainment', 'icon': '🎮'},
      {'id': 'wellness', 'name': 'Wellness', 'icon': '💆'},
    ];

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = _selectedFilter == filter['id'];

          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(filter['icon']!, style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 4),
                  Text(filter['name']!),
                ],
              ),
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = filter['id']!;
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

  Widget _buildSortAndViewOptions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          // Results count
          Text(
            '${_getFilteredDeals().length} deals found',
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.secondaryText,
            ),
          ),
          const Spacer(),

          // Sort dropdown
          DropdownButton<String>(
            value: _sortBy,
            underline: const SizedBox.shrink(),
            items: const [
              DropdownMenuItem(
                value: 'ending_soon',
                child: Text('Ending Soon'),
              ),
              DropdownMenuItem(
                value: 'discount',
                child: Text('Best Discount'),
              ),
              DropdownMenuItem(
                value: 'distance',
                child: Text('Nearest'),
              ),
              DropdownMenuItem(
                value: 'rating',
                child: Text('Highest Rated'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _sortBy = value!;
              });
            },
          ),
        ],
      ),
    );
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
    return Container(
      color: AppTheme.surfaceColor,
      child: const Center(
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
                  _selectedCategory = 'all';
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
        deals = deals.where((deal) => deal.isValid && deal.urgencyLevel == 'urgent').toList();
        break;
      case 'food':
      case 'entertainment':
      case 'wellness':
        final venues = MockData.venues.where((venue) => venue.category == _selectedFilter).map((venue) => venue.id).toList();
        deals = deals.where((deal) => venues.contains(deal.venueId)).toList();
        break;
    }

    return deals;
  }

  List<dynamic> _getFilteredAndSortedDeals() {
    var deals = _getFilteredDeals();

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

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        builder: (context, scrollController) {
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

                // Title
                const Text(
                  'Filter & Sort',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),

                // Filter options
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFilterSection('Deal Status', [
                          {'id': 'all', 'name': 'All Deals'},
                          {'id': 'active', 'name': 'Active Only'},
                          {'id': 'ending_soon', 'name': 'Ending Soon'},
                        ]),
                        const SizedBox(height: 24),
                        _buildFilterSection('Category', [
                          {'id': 'all', 'name': 'All Categories'},
                          {'id': 'food', 'name': 'Food & Dining'},
                          {'id': 'entertainment', 'name': 'Entertainment'},
                          {'id': 'wellness', 'name': 'Wellness & Spa'},
                          {'id': 'sports', 'name': 'Sports & Fitness'},
                        ]),
                        const SizedBox(height: 24),
                        _buildFilterSection('Sort By', [
                          {'id': 'ending_soon', 'name': 'Ending Soon'},
                          {'id': 'discount', 'name': 'Best Discount'},
                          {'id': 'distance', 'name': 'Nearest'},
                          {'id': 'rating', 'name': 'Highest Rated'},
                        ]),
                      ],
                    ),
                  ),
                ),

                // Apply button
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Apply Filters'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterSection(String title, List<Map<String, String>> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        ...options.map((option) {
          final isSelected = (title == 'Deal Status' && _selectedFilter == option['id']) ||
              (title == 'Category' && _selectedCategory == option['id']) ||
              (title == 'Sort By' && _sortBy == option['id']);

          return Container(
            decoration: isSelected ? BoxDecoration(
              color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ) : null,
            child: RadioListTile<String>(
              title: Text(option['name']!),
              value: option['id']!,
            groupValue: title == 'Deal Status'
                ? _selectedFilter
                : title == 'Category'
                    ? _selectedCategory
                    : _sortBy,
            onChanged: (value) {
              setState(() {
                if (title == 'Deal Status') {
                  _selectedFilter = value!;
                } else if (title == 'Category') {
                  _selectedCategory = value!;
                } else {
                  _sortBy = value!;
                }
              });
            },
            activeColor: AppTheme.moroccoGreen,
            dense: true,
            ),
          );
        }),
      ],
    );
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
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  content: Text('Booking confirmed! Check your email for details.'),
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
