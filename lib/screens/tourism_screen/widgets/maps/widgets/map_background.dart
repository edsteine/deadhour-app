import 'package:flutter/material.dart';




/// Map background widget with different styles and overlays
class MapBackground extends StatelessWidget {
  final String mapStyle;

  const MapBackground({
    super.key,
    required this.mapStyle,
  });

  @override
  Widget build(BuildContext context) {
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
    switch (mapStyle) {
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
}