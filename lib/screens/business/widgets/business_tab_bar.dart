import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';

class BusinessTabBar extends StatelessWidget {
  final TabController tabController;

  const BusinessTabBar({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: TabBar(
        controller: tabController,
        indicatorColor: AppTheme.moroccoGreen,
        labelColor: AppTheme.moroccoGreen,
        unselectedLabelColor: Colors.grey,
        isScrollable: true,
        tabs: const [
          Tab(text: 'Dead Hours'),
          Tab(text: 'Smart Pricing'),
          Tab(text: 'Promotions'),
          Tab(text: 'AI Insights'),
        ],
      ),
    );
  }
}
