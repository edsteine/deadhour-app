import 'package:flutter/material.dart';
import 'accessibility_service.dart';

class AccessibleBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> items;
  final List<String> semanticLabels;

  const AccessibleBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    required this.semanticLabels,
  });

  @override
  Widget build(BuildContext context) {
    final accessibilityService = AccessibilityService();
    
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        final label = index < semanticLabels.length 
            ? semanticLabels[index] 
            : 'Tab ${index + 1}';
        accessibilityService.accessibilityFeedback();
        accessibilityService.announceAction('Switched to $label');
        onTap(index);
      },
      items: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final semanticLabel = index < semanticLabels.length 
            ? accessibilityService.getNavigationSemantic(semanticLabels[index], currentIndex == index)
            : 'Navigation item ${index + 1}';
        
        return BottomNavigationBarItem(
          icon: Semantics(
            label: semanticLabel,
            child: item.icon,
          ),
          activeIcon: Semantics(
            label: semanticLabel,
            child: item.activeIcon,
          ),
          label: item.label,
        );
      }).toList(),
      selectedLabelStyle: TextStyle(
        fontSize: 12 * accessibilityService.textScaleFactor,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12 * accessibilityService.textScaleFactor,
      ),
    );
  }
}