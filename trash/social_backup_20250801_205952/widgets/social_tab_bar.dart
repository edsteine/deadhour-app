import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

class SocialTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;

  const SocialTabBar({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: tabController,
        indicatorColor: AppTheme.moroccoGreen,
        labelColor: AppTheme.moroccoGreen,
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(text: 'Discover'),
          Tab(text: 'My Network'),
          Tab(text: 'Host'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
