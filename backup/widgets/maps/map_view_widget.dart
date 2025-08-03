import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../models/deal.dart';
import '../../models/venue.dart';
import '../../utils/performance_utils.dart';

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
  String _mapStyle = 'normal'; // 'normal', 'satellite', 'hybrid'
  double _zoomLevel = 1.0;
  bool _showTraffic = false;
  String _selectedFilter = 'all';

  // Mock nearby locations
  final List<MapLocation> _locations = [
    MapLocation(
      id: 'user',
      name: 'Your Location',
      lat: 33.5731,
      lng: -7.5898,
      type: MapLocationType.user,
      icon: '📍',
    ),
    MapLocation(
      id: 'cafe1',
      name: 'Café Atlas',
      lat: 33.5741,
      lng: -7.5888,
      type: MapLocationType.venue,
      icon: '☕',
      category: 'food',
      hasDeals: true,
      dealCount: 2,
    ),
    MapLocation(
      id: 'restaurant1',
      name: 'Restaurant Al-Fassia',
      lat: 33.5721,
      lng: -7.5908,
      type: MapLocationType.venue,
      icon: '🍽️',
      category: 'food',
      hasDeals: true,
      dealCount: 1,
    ),
    MapLocation(
      id: 'mosque1',
      name: 'Hassan II Mosque',
      lat: 33.6084,
      lng: -7.6325,
      type: MapLocationType.cultural,
      icon: '🕌',
      category: 'cultural',
    ),
    MapLocation(
      id: 'spa1',
      name: 'Royal Spa Casablanca',
      lat: 33.5751,
      lng: -7.5878,
      type: MapLocationType.venue,
      icon: '💆',
      category: 'wellness',
      hasDeals: true,
      dealCount: 3,
    ),
    MapLocation(
      id: 'entertainment1',
      name: 'Morocco Mall Cinema',
      lat: 33.5211,
      lng: -7.6901,
      type: MapLocationType.venue,
      icon: '🎬',
      category: 'entertainment',
      hasDeals: false,
    ),
  ];

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
    if (_selectedFilter == 'all') return _locations;
    if (_selectedFilter == 'deals') {
      return _locations.where((loc) => loc.hasDeals == true).toList();
    }
    return _locations.where((loc) => loc.category == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Mock map background
        _buildMapBackground(),

        // Map markers
        ..._buildMapMarkers(),

        // Map controls
        _buildMapControls(),

        // Filter chips
        _buildFilterChips(),

        // Map style selector
        _buildMapStyleSelector(),

        // Location details sheet (if marker is selected)
        _buildLocationDetailsSheet(),
      ],
    );
  }

  Widget _buildMapBackground() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _getMapBackgroundColors(),
        ),
      ),
      child: Stack(
        children: [
          // Grid pattern to simulate map tiles
          CustomPaint(
            painter: MapGridPainter(),
            size: Size.infinite,
          ),

          // Streets overlay
          CustomPaint(
            painter: StreetsOverlayPainter(),
            size: Size.infinite,
          ),

          // Water bodies (Atlantic Ocean)
          Positioned(
            top: 0,
            left: 0,
            right: MediaQuery.of(context).size.width * 0.3,
            bottom: MediaQuery.of(context).size.height * 0.7,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  '🌊 Atlantic Ocean',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _getMapBackgroundColors() {
    switch (_mapStyle) {
      case 'satellite':
        return [
          Colors.brown.shade300,
          Colors.green.shade200,
          Colors.blue.shade100,
        ];
      case 'hybrid':
        return [
          Colors.grey.shade200,
          Colors.green.shade100,
          Colors.blue.shade50,
        ];
      default: // normal
        return [
          const Color(0xFFF5F5DC), // Beige
          const Color(0xFFE6E6FA), // Lavender
          const Color(0xFFE0FFFF), // Light cyan
        ];
    }
  }

  List<Widget> _buildMapMarkers() {
    return _filteredLocations.map((location) {
      return _buildMapMarker(location);
    }).toList();
  }

  Widget _buildMapMarker(MapLocation location) {
    final screenPosition = _getScreenPosition(location.lat, location.lng);

    return Positioned(
      left: screenPosition.dx - 20,
      top: screenPosition.dy - 40,
      child: GestureDetector(
        onTap: () {
          PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
          _showLocationDetails(location);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Column(
            children: [
              // Marker icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getMarkerColor(location),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    location.icon,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),

              // Deal indicator
              if (location.hasDeals == true)
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${location.dealCount}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              // Location pin
              Container(
                width: 2,
                height: 8,
                color: _getMarkerColor(location),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getMarkerColor(MapLocation location) {
    switch (location.type) {
      case MapLocationType.user:
        return AppTheme.moroccoGreen;
      case MapLocationType.venue:
        switch (location.category) {
          case 'food':
            return AppColors.foodCategory;
          case 'entertainment':
            return AppColors.entertainmentCategory;
          case 'wellness':
            return AppColors.wellnessCategory;
          default:
            return AppTheme.moroccoGreen;
        }
      case MapLocationType.cultural:
        return AppColors.prayerTime;
      default:
        return Colors.grey;
    }
  }

  Offset _getScreenPosition(double lat, double lng) {
    final size = MediaQuery.of(context).size;

    // Mock coordinate conversion (in real app, use proper map projection)
    final x = (lng + 7.6) * size.width * 10 * _zoomLevel;
    final y = (33.7 - lat) * size.height * 10 * _zoomLevel;

    return Offset(
      x.clamp(0, size.width - 40),
      y.clamp(0, size.height - 80),
    );
  }

  Widget _buildMapControls() {
    return Positioned(
      right: 16,
      top: MediaQuery.of(context).padding.top + 60,
      child: Column(
        children: [
          // Zoom in
          _buildControlButton(
            icon: Icons.add,
            onPressed: () {
              setState(() {
                _zoomLevel = (_zoomLevel * 1.2).clamp(0.5, 3.0);
              });
            },
          ),
          const SizedBox(height: 8),

          // Zoom out
          _buildControlButton(
            icon: Icons.remove,
            onPressed: () {
              setState(() {
                _zoomLevel = (_zoomLevel / 1.2).clamp(0.5, 3.0);
              });
            },
          ),
          const SizedBox(height: 8),

          // Center on user location
          _buildControlButton(
            icon: Icons.my_location,
            onPressed: () {
              PerformanceUtils.hapticFeedback(HapticFeedbackType.medium);
              // Center map on user location
              setState(() {
                _zoomLevel = 1.0;
              });
            },
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
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
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
      {'id': 'cultural', 'name': 'Culture', 'icon': '🕌'},
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
            final isSelected = _selectedFilter == filter['id'];

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
      ),
    );
  }

  Widget _buildMapStyleSelector() {
    return Positioned(
      left: 16,
      bottom: 100,
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
            _buildStyleButton('Normal', 'normal'),
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.moroccoGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.white : AppTheme.primaryText,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildLocationDetailsSheet() {
    // This would show when a marker is tapped
    return const SizedBox.shrink();
  }

  void _showLocationDetails(MapLocation location) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  location.icon,
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (location.hasDeals == true)
                        Text(
                          '${location.dealCount} active deals',
                          style: const TextStyle(
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (location.hasDeals == true) ...[
              const Text(
                'Available Deals:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ...List.generate(location.dealCount ?? 0, (index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          '30% OFF',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text('Dead hour special - Limited time'),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 16),
            ],
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.directions),
                    label: const Text('Directions'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      if (location.hasDeals == true &&
                          widget.onVenueTap != null) {
                        // Navigate to venue details
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.moroccoGreen,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.visibility),
                    label: const Text('View'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Map location model
class MapLocation {
  final String id;
  final String name;
  final double lat;
  final double lng;
  final MapLocationType type;
  final String icon;
  final String? category;
  final bool? hasDeals;
  final int? dealCount;

  MapLocation({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.type,
    required this.icon,
    this.category,
    this.hasDeals,
    this.dealCount,
  });
}

enum MapLocationType {
  user,
  venue,
  cultural,
  deal,
}

// Custom painters for map styling
class MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.1)
      ..strokeWidth = 0.5;

    const gridSize = 50.0;

    // Draw vertical lines
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Draw horizontal lines
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class StreetsOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.3)
      ..strokeWidth = 3;

    // Draw some mock streets
    canvas.drawLine(
      Offset(0, size.height * 0.3),
      Offset(size.width, size.height * 0.3),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.4, 0),
      Offset(size.width * 0.4, size.height),
      paint,
    );

    canvas.drawLine(
      Offset(0, size.height * 0.7),
      Offset(size.width, size.height * 0.7),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
