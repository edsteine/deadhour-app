import '../../deals/models/deal.dart';
import 'maps/models/map_location.dart';
import 'maps/services/map_data_service.dart';
import 'maps/widgets/map_background.dart';
import 'maps/widgets/map_controls.dart';
import 'maps/widgets/map_filter_chips.dart';
import 'maps/widgets/map_location_details.dart';
import 'maps/widgets/map_markers.dart';
import 'maps/widgets/map_style_selector.dart';
import '../../venues/models/venue.dart';
import '../../../utils/performance_utils.dart';
import 'package:flutter/material.dart';

// Map View Widget for DeadHour App
// Note: This is a mockup implementation. In production, you would use
// google_maps_flutter or similar package for real map functionality.

class MapViewWidget extends StatefulWidget {
  final List<Deal>? deals;
  final List<Venue>? venues;
  final String? selectedCategory;
  final Function(Deal)? onDealTap;
  final Function(Venue)? onVenueTap;
  final bool showDeals;
  final bool showVenues;
  final bool showUserLocation;

  const MapViewWidget({
    super.key,
    this.deals,
    this.venues,
    this.selectedCategory,
    this.onDealTap,
    this.onVenueTap,
    this.showDeals = true,
    this.showVenues = true,
    this.showUserLocation = true,
  });

  @override
  State<MapViewWidget> createState() => _MapViewWidgetState();
}

class _MapViewWidgetState extends State<MapViewWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String _mapStyle = 'normal';
  double _zoomLevel = 1.0;
  bool _showTraffic = false;
  String _selectedFilter = 'all';

  final MapDataService _mapDataService = MapDataService();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<MapLocation> get _filteredLocations {
    return _mapDataService.getFilteredLocations(_selectedFilter);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Mock map background
        MapBackground(mapStyle: _mapStyle),

        // Map markers
        MapMarkers(
          locations: _filteredLocations,
          zoomLevel: _zoomLevel,
          onLocationTap: _showLocationDetails,
        ),

        // Map controls
        MapControls(
          zoomLevel: _zoomLevel,
          showTraffic: _showTraffic,
          onZoomIn: () => setState(() {
            _zoomLevel = (_zoomLevel * 1.2).clamp(0.5, 3.0);
          }),
          onZoomOut: () => setState(() {
            _zoomLevel = (_zoomLevel / 1.2).clamp(0.5, 3.0);
          }),
          onCenterLocation: () {
            PerformanceUtils.hapticFeedback(HapticFeedbackType.medium);
            setState(() => _zoomLevel = 1.0);
          },
          onToggleTraffic: () => setState(() {
            _showTraffic = !_showTraffic;
          }),
        ),

        // Filter chips
        MapFilterChips(
          selectedFilter: _selectedFilter,
          onFilterChanged: (filter) => setState(() {
            _selectedFilter = filter;
          }),
        ),

        // Map style selector
        MapStyleSelector(
          currentStyle: _mapStyle,
          onStyleChanged: (style) => setState(() {
            _mapStyle = style;
          }),
        ),
      ],
    );
  }

  void _showLocationDetails(MapLocation location) {
    MapLocationDetails.show(
      context,
      location,
      onDirections: () => Navigator.pop(context),
      onView: () {
        Navigator.pop(context);
        if (location.hasDeals == true && widget.onVenueTap != null) {
          // Navigate to venue details
        }
      },
    );
  }
}