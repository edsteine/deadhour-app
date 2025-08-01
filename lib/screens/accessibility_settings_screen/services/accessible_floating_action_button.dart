import 'package:flutter/material.dart';


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
    final accessibilityService = AccessibilityService();
    
    return Semantics(
      label: semanticLabel,
      button: true,
      child: FloatingActionButton(
        heroTag: 'accessibility_fab',
        onPressed: () {
          accessibilityService.accessibilityFeedback();
          accessibilityService.announceAction(semanticLabel);
          onPressed();
        },
        tooltip: tooltip,
        child: child,
      ),
    );
  }
}