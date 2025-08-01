import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Map control buttons for zoom, location, and traffic
class MapControls extends StatelessWidget {
  final double zoomLevel;
  final bool showTraffic;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onCenterLocation;
  final VoidCallback onToggleTraffic;

  const MapControls({
    super.key,
    required this.zoomLevel,
    required this.showTraffic,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onCenterLocation,
    required this.onToggleTraffic,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      top: MediaQuery.of(context).padding.top + 60,
      child: Column(
        children: [
          // Zoom in
          _buildControlButton(
            icon: Icons.add,
            onPressed: onZoomIn,
          ),
          const SizedBox(height: 8),

          // Zoom out
          _buildControlButton(
            icon: Icons.remove,
            onPressed: onZoomOut,
          ),
          const SizedBox(height: 8),

          // Center on user location
          _buildControlButton(
            icon: Icons.my_location,
            onPressed: onCenterLocation,
          ),
          const SizedBox(height: 8),

          // Toggle traffic
          _buildControlButton(
            icon: Icons.traffic,
            isActive: showTraffic,
            onPressed: onToggleTraffic,
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
}