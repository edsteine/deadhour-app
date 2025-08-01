import 'package:deadhour/utils/app_navigation.dart';




import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

// Import modular widgets






class VenueDiscoveryScreen extends StatefulWidget {
  final String? selectedView; // View passed from AppBar filter
  
  const VenueDiscoveryScreen({super.key, this.selectedView});

  @override
  State<VenueDiscoveryScreen> createState() => _VenueDiscoveryScreenState();
}

class _VenueDiscoveryScreenState extends State<VenueDiscoveryScreen> {
  String _selectedCategory = 'all';
  String _selectedCity = 'all';
  String _sortBy = 'rating';
  String _selectedView = 'list'; // list, map, nearby
  final _socialValidation = SocialValidationService();
  final _visualContent = VisualContentService();
  final _discoveryService = VenueDiscoveryService();
  double _maxDistance = 10.0;
  bool _openNowOnly = false;
  String _priceRange = 'all';
  bool _halalOnly = false;
  bool _prayerFriendly = false;
  bool _showCommunityActivity = true;

  @override
  void initState() {
    super.initState();
    // Initialize with view from AppBar filter, default to 'list'
    _selectedView = widget.selectedView ?? 'list_view';
    // Initialize visual content
    _visualContent.initializeSampleContent();
  }

  @override
  void didUpdateWidget(VenueDiscoveryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update view when filter changes from AppBar
    if (widget.selectedView != oldWidget.selectedView && widget.selectedView != null) {
      setState(() {
        _selectedView = widget.selectedView!;
      });
    }
  }

  List<Venue> get _filteredVenues {
    return _discoveryService.getFilteredVenues(
      category: _selectedCategory,
      city: _selectedCity,
      maxDistance: _maxDistance,
      features: [
        if (_halalOnly) 'halal',
        if (_prayerFriendly) 'prayer_friendly',
      ],
      priceRange: _priceRange,
      openNow: _openNowOnly ? true : null,
      sortBy: _sortBy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          // Filters section
          VenueDiscoveryFiltersWidget(
            selectedCategory: _selectedCategory,
            selectedCity: _selectedCity,
            sortBy: _sortBy,
            maxDistance: _maxDistance,
            openNowOnly: _openNowOnly,
            priceRange: _priceRange,
            halalOnly: _halalOnly,
            prayerFriendly: _prayerFriendly,
            showCommunityActivity: _showCommunityActivity,
            onCategoryChanged: (value) => setState(() => _selectedCategory = value),
            onCityChanged: (value) => setState(() => _selectedCity = value),
            onSortByChanged: (value) => setState(() => _sortBy = value),
            onMaxDistanceChanged: (value) => setState(() => _maxDistance = value),
            onOpenNowChanged: (value) => setState(() => _openNowOnly = value),
            onPriceRangeChanged: (value) => setState(() => _priceRange = value),
            onHalalOnlyChanged: (value) => setState(() => _halalOnly = value),
            onPrayerFriendlyChanged: (value) => setState(() => _prayerFriendly = value),
            onShowCommunityActivityChanged: (value) => setState(() => _showCommunityActivity = value),
            onClearAll: _clearAllFilters,
          ),
          
          // Results summary header
          _buildResultsHeader(),
          
          // Results content based on selected view
          Expanded(
            child: _buildSelectedView(),
          ),
        ],
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
            '${_filteredVenues.length} venues found',
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.primaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          // Show active filters indicator if any are applied
          if (_hasActiveFilters())
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Filters Active',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.moroccoGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => _clearAllFilters(),
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

  Widget _buildSelectedView() {
    switch (_selectedView) {
      case 'map_view':
        return VenueDiscoveryMapWidget(
          venues: _filteredVenues,
          selectedCategory: _selectedCategory != 'all' ? _selectedCategory : null,
          onVenueTap: (venue) => AppNavigation.goToVenueDetail(context, venue.id),
          onDealTap: (deal) => AppNavigation.goToVenueDetail(context, deal.venueId),
        );
      case 'nearby':
        return VenueNearbyViewWidget(
          venues: _filteredVenues,
          onVenueTap: (venue) => AppNavigation.goToVenueDetail(context, venue.id),
        );
      case 'list_view':
      default:
        return VenueListViewWidget(
          venues: _filteredVenues,
          showCommunityActivity: _showCommunityActivity,
          socialValidation: _socialValidation,
          visualContent: _visualContent,
        );
    }
  }

  // Method to update view from external source (MainNavigationScreen filter)
  void updateView(String view) {
    setState(() {
      _selectedView = view;
    });
  }

  void _clearAllFilters() {
    setState(() {
      _selectedCategory = 'all';
      _selectedCity = 'all';
      _sortBy = 'rating';
      _maxDistance = 10.0;
      _openNowOnly = false;
      _priceRange = 'all';
      _halalOnly = false;
      _prayerFriendly = false;
      _showCommunityActivity = true;
    });
  }

  bool _hasActiveFilters() {
    return _selectedCategory != 'all' ||
        _selectedCity != 'all' ||
        _openNowOnly ||
        _halalOnly ||
        _prayerFriendly ||
        _priceRange != 'all' ||
        _maxDistance != 10.0;
  }
}