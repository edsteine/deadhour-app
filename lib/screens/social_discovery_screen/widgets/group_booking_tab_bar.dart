import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Tab bar for group booking sections
class GroupBookingTabBar extends StatelessWidget {
  final TabController tabController;

  const GroupBookingTabBar({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: TabBar(
        controller: tabController,
        labelColor: AppTheme.moroccoGreen,
        unselectedLabelColor: AppTheme.secondaryText,
        indicatorColor: AppTheme.moroccoGreen,
        tabs: const [
          Tab(text: 'All Groups'),
          Tab(text: 'My Groups'),
          Tab(text: 'Deal Ops'),
          Tab(text: 'Create'),
        ],
      ),
    );
  }
}