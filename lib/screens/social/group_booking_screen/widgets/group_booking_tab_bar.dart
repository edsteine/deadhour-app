import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';

class GroupBookingTabBar extends StatelessWidget {
  final TabController tabController;

  const GroupBookingTabBar({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: tabController,
        labelColor: Colors.white,
        unselectedLabelColor: AppTheme.secondaryText,
        indicator: BoxDecoration(
          color: AppTheme.moroccoGreen,
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: const [
          Tab(text: 'All'),
          Tab(text: 'My Groups'),
          Tab(text: 'Deals'),
          Tab(text: 'Create'),
        ],
      ),
    );
  }
}