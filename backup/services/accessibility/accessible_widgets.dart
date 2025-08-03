import 'package:flutter/material.dart';
import 'voice_over_helper.dart';

/// Accessibility-focused widgets

class AccessibleFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final String semanticLabel;
  final String? tooltip;

  const AccessibleFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.semanticLabel,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: FloatingActionButton(
        onPressed: () {
          VoiceOverHelper.accessibilityFeedback();
          VoiceOverHelper.announceAction(semanticLabel);
          onPressed();
        },
        tooltip: tooltip,
        child: child,
      ),
    );
  }
}

class AccessibleTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final TabController? controller;
  final List<String> semanticLabels;
  final double textScaleFactor;

  const AccessibleTabBar({
    super.key,
    required this.tabs,
    required this.semanticLabels,
    this.controller,
    this.textScaleFactor = 1.0,
  });

  @override
  Widget build(BuildContext context) {
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
        fontSize: 14 * textScaleFactor,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14 * textScaleFactor,
      ),
    );
  }
}

class AccessibleBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> items;
  final List<String> semanticLabels;
  final double textScaleFactor;

  const AccessibleBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    required this.semanticLabels,
    this.textScaleFactor = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        final label = index < semanticLabels.length 
            ? semanticLabels[index] 
            : 'Tab ${index + 1}';
        VoiceOverHelper.accessibilityFeedback();
        VoiceOverHelper.announceAction('Switched to $label');
        onTap(index);
      },
      items: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final semanticLabel = index < semanticLabels.length 
            ? VoiceOverHelper.getNavigationSemantic(semanticLabels[index], currentIndex == index)
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
        fontSize: 12 * textScaleFactor,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12 * textScaleFactor,
      ),
    );
  }
}