import '../dev_menu/dead_hour_app_bar.dart';
import 'services/cultural_calendar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/app_theme.dart';
import 'widgets/health_dashboard_controls.dart';
import 'widgets/health_metrics_overview.dart';
import 'widgets/health_room_activity_tab.dart';
import 'widgets/health_user_engagement_tab.dart';
import 'widgets/health_cultural_insights_tab.dart';
import 'widgets/health_business_impact_tab.dart';

class CommunityHealthDashboardScreen extends ConsumerStatefulWidget {
  const CommunityHealthDashboardScreen({super.key});

  @override
  ConsumerState<CommunityHealthDashboardScreen> createState() => 
      _CommunityHealthDashboardScreenState();
}

class _CommunityHealthDashboardScreenState 
    extends ConsumerState<CommunityHealthDashboardScreen> 
    with TickerProviderStateMixin {
  
  final _culturalService = CulturalCalendarService();
  late TabController _tabController;
  String _selectedTimeRange = '7d';
  String _selectedCity = 'Casablanca';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DeadHourAppBar(
        title: 'Community Health',
        subtitle: 'Analytics & Engagement Insights',
        showBackButton: true,
        showMenuDrawer: true,
      ),
      body: Column(
        children: [
          HealthDashboardControls(
            selectedTimeRange: _selectedTimeRange,
            selectedCity: _selectedCity,
            onTimeRangeChanged: (value) => setState(() => _selectedTimeRange = value),
            onCityChanged: (value) => setState(() => _selectedCity = value),
          ),
          const HealthMetricsOverview(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                const HealthRoomActivityTab(),
                const HealthUserEngagementTab(),
                HealthCulturalInsightsTab(culturalService: _culturalService),
                const HealthBusinessImpactTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      labelColor: AppTheme.moroccoGreen,
      unselectedLabelColor: Colors.grey,
      indicatorColor: AppTheme.moroccoGreen,
      isScrollable: true,
      tabs: const [
        Tab(text: 'Room Activity'),
        Tab(text: 'User Engagement'),
        Tab(text: 'Cultural Insights'),
        Tab(text: 'Business Impact'),
      ],
    );
  }
}