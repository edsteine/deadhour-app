
import 'package:deadhour/utils/haptic_feedback_type.dart';

import 'package:deadhour/utils/performance_utils.dart';
import 'package:deadhour/utils/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:deadhour/utils/app_colors.dart';

/// Widget displaying map markers for locations
class MapMarkers extends StatelessWidget {
  final List<MapLocation> locations;
  final double zoomLevel;
  final Function(MapLocation) onLocationTap;

  const MapMarkers({
    super.key,
    required this.locations,
    required this.zoomLevel,
    required this.onLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: locations.map((location) {
        return _buildMapMarker(context, location);
      }).toList(),
    );
  }

  Widget _buildMapMarker(BuildContext context, MapLocation location) {
    final screenPosition = _getScreenPosition(context, location.lat, location.lng);

    return Positioned(
      left: screenPosition.dx - 20,
      top: screenPosition.dy - 40,
      child: GestureDetector(
        onTap: () {
          PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
          onLocationTap(location);
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
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.red,
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

  Offset _getScreenPosition(BuildContext context, double lat, double lng) {
    final size = MediaQuery.of(context).size;

    // Mock coordinate conversion (in real app, use proper map projection)
    final x = (lng + 7.6) * size.width * 10 * zoomLevel;
    final y = (33.7 - lat) * size.height * 10 * zoomLevel;

    return Offset(
      x.clamp(0, size.width - 40),
      y.clamp(0, size.height - 80),
    );
  }
}