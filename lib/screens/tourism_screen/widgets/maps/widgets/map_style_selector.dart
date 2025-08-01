import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Map style selector for switching between normal, satellite, and hybrid views
class MapStyleSelector extends StatelessWidget {
  final String currentStyle;
  final Function(String) onStyleChanged;

  const MapStyleSelector({
    super.key,
    required this.currentStyle,
    required this.onStyleChanged,
  });

  @override
  Widget build(BuildContext context) {
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
    final isSelected = currentStyle == style;

    return GestureDetector(
      onTap: () => onStyleChanged(style),
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
}