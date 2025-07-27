import 'package:flutter/material.dart';
import 'package:deadhour/models/user.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/screens/community/widgets/community_app_bar.dart';
import 'package:deadhour/screens/community/widgets/community_health_indicator.dart';
import 'package:deadhour/screens/community/widgets/category_filter.dart';
import 'package:deadhour/screens/community/widgets/cultural_filters.dart';

class RoomsScaffold extends StatelessWidget {
  final DeadHourUser? user;
  final TabController tabController;
  final String selectedCity;
  final String selectedCategory;
  final bool showPrayerTimeAware;
  final bool showHalalOnly;
  final VoidCallback onCitySelectorPressed;
  final VoidCallback onRoomSearchPressed;
  final ValueChanged<String> onCategorySelected;
  final ValueChanged<bool> onPrayerTimeAwareChanged;
  final ValueChanged<bool> onHalalOnlyChanged;
  final VoidCallback onCreateRoomPressed;
  final List<Tab> tabs;
  final List<Widget> tabViews;

  const RoomsScaffold({
    super.key,
    required this.user,
    required this.tabController,
    required this.selectedCity,
    required this.selectedCategory,
    required this.showPrayerTimeAware,
    required this.showHalalOnly,
    required this.onCitySelectorPressed,
    required this.onRoomSearchPressed,
    required this.onCategorySelected,
    required this.onPrayerTimeAwareChanged,
    required this.onHalalOnlyChanged,
    required this.onCreateRoomPressed,
    required this.tabs,
    required this.tabViews,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommunityAppBar(
        selectedCity: selectedCity,
        onCitySelectorPressed: onCitySelectorPressed,
        onRoomSearchPressed: onRoomSearchPressed,
      ),
      body: Column(
        children: [
          CommunityHealthIndicator(),
          CategoryFilter(
            selectedCategory: selectedCategory,
            onCategorySelected: onCategorySelected,
          ),
          CulturalFilters(
            showPrayerTimeAware: showPrayerTimeAware,
            showHalalOnly: showHalalOnly,
            onPrayerTimeAwareChanged: onPrayerTimeAwareChanged,
            onHalalOnlyChanged: onHalalOnlyChanged,
          ),
          TabBar(
            controller: tabController,
            labelColor: AppTheme.moroccoGreen,
            unselectedLabelColor: AppTheme.secondaryText,
            indicatorColor: AppTheme.moroccoGreen,
            isScrollable: true,
            tabs: tabs,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: tabViews,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "roomsCreateRoomFAB",
        onPressed: onCreateRoomPressed,
        backgroundColor: AppTheme.moroccoGreen,
        icon: const Icon(Icons.add),
        label: const Text('Create Room'),
      ),
    );
  }
}
