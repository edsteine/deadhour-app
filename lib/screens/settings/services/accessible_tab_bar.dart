import 'package:flutter/material.dart';
import 'accessibility_service.dart';

class AccessibleTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final TabController? controller;
  final List<String> semanticLabels;

  const AccessibleTabBar({
    super.key,
    required this.tabs,
    required this.semanticLabels,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final accessibilityService = AccessibilityService();
    
    return TabBar(
      controller: controller,
      tabs: tabs.asMap().entries.map((entry) {
        final index = entry.key;
        final tab = entry.value;
        final semanticLabel = index < semanticLabels.length 
            ? semanticLabels[index] 
            : 'Tab ${index + 1}';
        
        return Semantics(
          label: semanticLabel,
          button: true,
          selected: controller?.index == index,
          child: tab,
        );
      }).toList(),
      labelStyle: TextStyle(
        fontSize: 14 * accessibilityService.textScaleFactor,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14 * accessibilityService.textScaleFactor,
      ),
    );
  }
}