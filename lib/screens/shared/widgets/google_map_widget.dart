import 'dart:async';
import 'package:deadhour/screens/shared/deals/models/deal.dart';
import 'package:deadhour/screens/shared/venues/models/venue.dart';
import 'package:deadhour/screens/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Real Google Maps integration for DeadHour deals
class GoogleMapDealsWidget extends StatefulWidget {
  final List<Deal>? deals;
  final List<Venue>? venues;
  final String? selectedCategory;
  final Function(Deal)? onDealTap;
  final Function(Venue)? onVenueTap;
  final bool showDeals;
  final bool showVenues;
  final bool showUserLocation;

  const GoogleMapDealsWidget({
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
  State<GoogleMapDealsWidget> createState() => _GoogleMapDealsWidgetState();
}

class _GoogleMapDealsWidgetState extends State<GoogleMapDealsWidget> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  String _mapStyle = 'normal';
  bool _showTraffic = false;

  // Casablanca coordinates
  static const CameraPosition _casablanca = CameraPosition(
    target: LatLng(33.5731, -7.5898),
    zoom: 13.0,
  );

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  @override
  void didUpdateWidget(GoogleMapDealsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.deals != widget.deals ||
        oldWidget.venues != widget.venues ||
        oldWidget.selectedCategory != widget.selectedCategory) {
      _createMarkers();
    }
  }

  void _createMarkers() {
    final Set<Marker> markers = {};

    // Add user location marker
    if (widget.showUserLocation) {
      markers.add(
        Marker(
          markerId: const MarkerId('user_location'),
          position: const LatLng(33.5731, -7.5898),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: const InfoWindow(
            title: 'Your Location',
            snippet: 'You are here',
          ),
        ),
      );
    }

    // Add venue markers with deals
    if (widget.showVenues && widget.venues != null) {
      for (final venue in widget.venues!) {
        // Filter by category if selected
        if (widget.selectedCategory != null && 
            widget.selectedCategory != 'all' &&
            venue.category != widget.selectedCategory) {
          continue;
        }

        // Get deals for this venue
        final venueDeals = widget.deals?.where((deal) => 
          deal.venueId == venue.id && deal.isValid
        ).toList() ?? [];

        // Create marker for venue
        markers.add(
          Marker(
            markerId: MarkerId('venue_${venue.id}'),
            position: _getVenuePosition(venue),
            icon: _getVenueMarkerIcon(venue, venueDeals.isNotEmpty),
            infoWindow: InfoWindow(
              title: venue.name,
              snippet: venueDeals.isNotEmpty 
                  ? '${venueDeals.length} deal${venueDeals.length > 1 ? 's' : ''} available'
                  : venue.type,
            ),
            onTap: () {
              if (venueDeals.isNotEmpty && widget.onDealTap != null) {
                widget.onDealTap!(venueDeals.first);
              } else if (widget.onVenueTap != null) {
                widget.onVenueTap!(venue);
              }
            },
          ),
        );
      }
    }

    setState(() {
      _markers = markers;
    });
  }

  LatLng _getVenuePosition(Venue venue) {
    // In real app, venues would have lat/lng coordinates
    // For now, create positions around Casablanca
    final baseLatLng = const LatLng(33.5731, -7.5898);
    final hash = venue.id.hashCode;
    final latOffset = (hash % 1000 - 500) / 10000.0; // ±0.05 degrees
    final lngOffset = ((hash ~/ 1000) % 1000 - 500) / 10000.0; // ±0.05 degrees
    
    return LatLng(
      baseLatLng.latitude + latOffset,
      baseLatLng.longitude + lngOffset,
    );
  }

  BitmapDescriptor _getVenueMarkerIcon(Venue venue, bool hasDeals) {
    if (hasDeals) {
      // Red markers for venues with deals
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
    
    // Category-based colors for venues without deals
    switch (venue.category) {
      case 'food':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
      case 'entertainment':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      case 'wellness':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta);
      default:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: _getMapType(),
          initialCameraPosition: _casablanca,
          markers: _markers,
          trafficEnabled: _showTraffic,
          myLocationEnabled: widget.showUserLocation,
          myLocationButtonEnabled: false, // We'll use custom button
          zoomControlsEnabled: false, // We'll use custom controls
          mapToolbarEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onTap: (LatLng position) {
            // Handle map tap if needed
          },
        ),
        
        // Custom map controls
        _buildMapControls(),
        
        // Filter chips
        _buildFilterChips(),
        
        // Map style selector
        _buildMapStyleSelector(),
        
        // Legend
        _buildMapLegend(),
      ],
    );
  }

  MapType _getMapType() {
    switch (_mapStyle) {
      case 'satellite':
        return MapType.satellite;
      case 'hybrid':
        return MapType.hybrid;
      case 'terrain':
        return MapType.terrain;
      default:
        return MapType.normal;
    }
  }

  Widget _buildMapControls() {
    return Positioned(
      right: 16,
      top: MediaQuery.of(context).padding.top + 60,
      child: Column(
        children: [
          // Zoom to user location
          _buildControlButton(
            icon: Icons.my_location,
            onPressed: _goToUserLocation,
            tooltip: 'My Location',
          ),
          const SizedBox(height: 8),
          
          // Toggle traffic
          _buildControlButton(
            icon: Icons.traffic,
            isActive: _showTraffic,
            onPressed: () {
              setState(() {
                _showTraffic = !_showTraffic;
              });
            },
            tooltip: 'Traffic',
          ),
          const SizedBox(height: 8),
          
          // Zoom to fit all markers
          _buildControlButton(
            icon: Icons.center_focus_strong,
            onPressed: _zoomToFitMarkers,
            tooltip: 'Fit All Deals',
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String tooltip,
    bool isActive = false,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.moroccoGreen : Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: isActive ? Colors.white : AppTheme.primaryText,
          size: 20,
        ),
        onPressed: onPressed,
        tooltip: tooltip,
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = [
      {'id': 'all', 'name': 'All', 'icon': '🗺️'},
      {'id': 'deals', 'name': 'Deals', 'icon': '🏷️'},
      {'id': 'food', 'name': 'Food', 'icon': '🍕'},
      {'id': 'entertainment', 'name': 'Fun', 'icon': '🎮'},
      {'id': 'wellness', 'name': 'Spa', 'icon': '💆'},
    ];

    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 16,
      right: 80,
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          itemBuilder: (context, index) {
            final filter = filters[index];
            final isSelected = widget.selectedCategory == filter['id'] ||
                (widget.selectedCategory == null && filter['id'] == 'all');

            return Container(
              margin: const EdgeInsets.only(right: 8),
              child: FilterChip(
                selected: isSelected,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(filter['icon']!, style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    Text(filter['name']!),
                  ],
                ),
                onSelected: (selected) {
                  // This would be handled by parent widget
                },
                selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
                checkmarkColor: AppTheme.moroccoGreen,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMapStyleSelector() {
    return Positioned(
      left: 16,
      bottom: 120,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStyleButton('Map', 'normal'),
            _buildStyleButton('Satellite', 'satellite'),
            _buildStyleButton('Hybrid', 'hybrid'),
          ],
        ),
      ),
    );
  }

  Widget _buildStyleButton(String label, String style) {
    final isSelected = _mapStyle == style;

    return GestureDetector(
      onTap: () {
        setState(() {
          _mapStyle = style;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.moroccoGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isSelected ? Colors.white : AppTheme.primaryText,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildMapLegend() {
    return Positioned(
      left: 16,
      bottom: 40,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, color: Colors.red, size: 16),
                SizedBox(width: 4),
                Text('Deals Available', style: TextStyle(fontSize: 10)),
              ],
            ),
            SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, color: Colors.orange, size: 16),
                SizedBox(width: 4),
                Text('Food Venues', style: TextStyle(fontSize: 10)),
              ],
            ),
            SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, color: AppTheme.moroccoGreen, size: 16),
                SizedBox(width: 4),
                Text('You', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _goToUserLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLng(const LatLng(33.5731, -7.5898)),
    );
  }

  Future<void> _zoomToFitMarkers() async {
    if (_markers.isEmpty) return;
    
    final GoogleMapController controller = await _controller.future;
    
    // Calculate bounds of all markers
    double minLat = double.infinity;
    double maxLat = -double.infinity;
    double minLng = double.infinity;
    double maxLng = -double.infinity;
    
    for (final marker in _markers) {
      final position = marker.position;
      minLat = minLat < position.latitude ? minLat : position.latitude;
      maxLat = maxLat > position.latitude ? maxLat : position.latitude;
      minLng = minLng < position.longitude ? minLng : position.longitude;
      maxLng = maxLng > position.longitude ? maxLng : position.longitude;
    }
    
    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        100.0, // padding
      ),
    );
  }
}