import 'package:deadhour/backup/widgets/performance_monitor_widget.dart';
import 'package:deadhour/backup/widgets/ramadan_banner_widget.dart';
import 'package:deadhour/utils/app_theme.dart';



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deadhour/utils/mock_data.dart';


// Import new modular components





class DealsScreen extends ConsumerStatefulWidget {
  const DealsScreen({super.key});

  @override
  ConsumerState<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends ConsumerState<DealsScreen> {
  String _selectedFilter = 'all';
  final String _sortBy = 'ending_soon';
  bool _showMap = false;
  bool _autoApplyEnabled = false;
  
  // Services
  late final DealInteractionService _dealInteractionService;
  final AutomaticDealService _automaticDealService = AutomaticDealService();
  final CashbackService _cashbackService = CashbackService();
  final RamadanBusinessService _ramadanService = RamadanBusinessService();

  @override
  void initState() {
    super.initState();
    _dealInteractionService = DealInteractionService(
      cashbackService: _cashbackService,
      automaticDealService: _automaticDealService,
      ramadanService: _ramadanService,
    );
    _cashbackService.initializeSampleData();
  }

  @override
  void dispose() {
    _dealInteractionService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PerformanceMonitorWidget(
      screenName: 'Deals',
      child: Scaffold(
        body: Column(
          children: [
            // Ramadan seasonal banner (when active)
            if (_ramadanService.isRamadanSeason())
              RamadanBannerWidget(
                ramadanService: _ramadanService,
                onViewDeals: () => _dealInteractionService.showRamadanDeals(context),
              ),

            // Header with results and controls
            DealsHeaderWidget(
              dealCount: _getFilteredDeals().length,
              selectedFilter: _selectedFilter,
              showMap: _showMap,
              autoApplyEnabled: _autoApplyEnabled,
              onMapToggle: _toggleMapView,
              onAutoApplyToggle: _toggleAutoApply,
              onFiltersClear: _clearFilters,
              onShowCashbackDetails: () => _dealInteractionService.showCashbackDetails(context),
              cashbackService: _cashbackService,
            ),

            // Main content: deals list or map
            Expanded(
              child: _showMap 
                ? DealsMapView(
                    deals: _getFilteredAndSortedDeals(),
                    selectedCategory: _selectedFilter,
                    onDealTap: (deal) => _dealInteractionService.showDealDetails(context, deal),
                  )
                : DealsListView(
                    deals: _getFilteredAndSortedDeals(),
                    onDealTap: (deal) => _dealInteractionService.showDealDetails(context, deal),
                    onRefresh: _handleRefresh,
                    autoApplyEnabled: _autoApplyEnabled,
                    onPriceTrackingStart: _startPriceTracking,
                  ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          heroTag: 'dealsCreateDealFAB',
          onPressed: () => _dealInteractionService.showCreateDealAlert(context),
          backgroundColor: AppTheme.moroccoGreen,
          icon: const Icon(Icons.add),
          label: const Text('Create Deal'),
        ),
      ),
    );
  }

  // Private methods for state management and data filtering
  void _toggleMapView() {
    setState(() {
      _showMap = !_showMap;
    });
  }

  void _toggleAutoApply(bool value) {
    setState(() {
      _autoApplyEnabled = value;
    });
    if (value) {
      _showAutoApplyEnabledMessage();
    }
  }

  void _clearFilters() {
    setState(() {
      _selectedFilter = 'all';
    });
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  void _startPriceTracking(String dealId) {
    _automaticDealService.trackPriceDrops(dealId).listen((update) {
      if (mounted) {
        _showPriceDropAlert(update);
      }
    });
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
        deals.sort((a, b) => a.id.compareTo(b.id));
        break;
      case 'rating':
        deals.sort((a, b) => b.id.compareTo(a.id));
        break;
    }

    return deals;
  }

  void _showAutoApplyEnabledMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.auto_mode, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Auto-Apply enabled! We\'ll automatically find the best deals for you.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.moroccoGreen,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Learn More',
          textColor: Colors.white,
          onPressed: _showAutoApplyInfo,
        ),
      ),
    );
  }

  void _showAutoApplyInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.auto_mode, color: AppTheme.moroccoGreen),
            SizedBox(width: 8),
            Text('Auto-Apply Best Deals'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How it works:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('• Automatically scans all available deals'),
            Text('• Finds the highest discount for each venue'),
            Text('• Applies the best deal when you book'),
            Text('• Tracks price drops and notifies you'),
            SizedBox(height: 16),
            Text(
              'Just like Honey for coupons, but for Morocco\'s dead hour deals!',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: AppTheme.moroccoGreen,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }

  void _showPriceDropAlert(Map<String, dynamic> update) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.trending_down, color: AppTheme.moroccoGreen),
            SizedBox(width: 8),
            Text('Price Drop Alert!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Better deal found!'),
            const SizedBox(height: 8),
            Text('Old discount: ${update['oldDiscount']}%'),
            Text('New discount: ${update['newDiscount']}%'),
            Text('Extra savings: ${update['savings'].toStringAsFixed(0)} MAD'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Maybe Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _dealInteractionService.showDealDetails(context, update['deal']);
            },
            child: const Text('View Deal'),
          ),
        ],
      ),
    );
  }
}