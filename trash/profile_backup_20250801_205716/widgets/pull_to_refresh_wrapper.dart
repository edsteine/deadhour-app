import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

class PullToRefreshWrapper extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  final bool enabled;

  const PullToRefreshWrapper({
    super.key,
    required this.onRefresh,
    required this.child,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppTheme.moroccoGreen,
      backgroundColor: Colors.white,
      child: child,
    );
  }
}