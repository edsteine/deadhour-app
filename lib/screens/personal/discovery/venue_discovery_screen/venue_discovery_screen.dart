import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../models/venue.dart';
import '../../routes/app_routes.dart';
import '../../services/social_validation_service.dart';
import '../../services/advanced_search_service.dart';
import 'widgets/venue_card_widget.dart';
import 'widgets/venue_map_view.dart';
import 'widgets/venue_nearby_view.dart';
import 'widgets/venue_results_header.dart';
import 'widgets/venue_empty_state.dart';
import 'widgets/booking_dialogs.dart';

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
  final _advancedSearch = AdvancedSearchService();
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
    // Use advanced search service for comprehensive filtering (search handled by AppBar)
    return _advancedSearch.multiFilterSearch(
      category: _selectedCategory != 'all' ? _selectedCategory : null,
      city: _selectedCity != 'all' ? _selectedCity : null,
      maxDistance: _maxDistance,
      features: [
        if (_halalOnly) 'halal',
        if (_prayerFriendly) 'prayer_friendly',
      ],
      priceRange: _priceRange != 'all' ? _priceRange : null,
      openNow: _openNowOnly ? true : null,
      sortBy: _sortBy,
      limit: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      // App bar removed - handled by MainNavigationScreen
      body: Column(
        children: [
          // Results summary header only (filters moved to AppBar)
          VenueResultsHeader(
            venueCount: _filteredVenues.length,
            hasActiveFilters: _hasActiveFilters,
            onClearFilters: _clearAllFilters,
          ),
          // Results content based on selected view (controlled by AppBar filter)
          Expanded(
            child: _buildSelectedView(),
          ),
        ],
      ),
    );
  }

  bool get _hasActiveFilters {
    return _selectedCategory != 'all' || 
           _selectedCity != 'all' || 
           _openNowOnly || 
           _halalOnly || 
           _prayerFriendly;
  }

  Widget _buildSelectedView() {
    switch (_selectedView) {
      case 'map_view':
        return const VenueMapView();
      case 'nearby':
        return VenueNearbyView(venues: _filteredVenues);
      case 'list_view':
      default:
        return _buildVenuesList();
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
      // Search clearing handled by AppBar filters
    });
  }

  Widget _buildVenuesList() {
    final venues = _filteredVenues;

    if (venues.isEmpty) {
      return const VenueEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: venues.length,
      itemBuilder: (context, index) {
        final venue = venues[index];
        return VenueCardWidget(
          venue: venue,
          showCommunityActivity: _showCommunityActivity,
          socialValidation: _socialValidation,
          onViewDetails: () => _viewVenueDetails(venue),
          onBook: () => _bookVenue(venue),
          onShowGroupBooking: () => _showGroupBookingInfo(venue),
        );
      },
    );
  }

  void _viewVenueDetails(Venue venue) {
    AppNavigation.goToVenueDetail(context, venue.id);
  }

  void _showGroupBookingInfo(Venue venue) {
    BookingDialogs.showGroupBookingInfo(
      context, 
      venue, 
      () => _bookGroupVenue(venue),
    );
  }

  void _bookGroupVenue(Venue venue) {
    BookingDialogs.showGroupBookingForm(context, venue);
  }

  void _bookVenue(Venue venue) {
    BookingDialogs.showVenueBooking(context, venue);
  }
}