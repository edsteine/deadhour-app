import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/theme.dart';
import '../../widgets/common/dead_hour_app_bar.dart';
import 'state/community_health_dashboard_state.dart';
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
  
  late CommunityHealthDashboardState _state;

  @override
  void initState() {
    super.initState();
    _state = CommunityHealthDashboardState();
    _state.initializeTabController(this);
    _state.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    _state.removeListener(_onStateChanged);
    _state.dispose();
    super.dispose();
  }

  void _onStateChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DeadHourAppBar(
        title: 'Community Health',
        subtitle: 'Analytics & Engagement Insights',
        showBackButton: true,
      ),
      body: Column(
        children: [
          HealthDashboardControls(state: _state),
          HealthMetricsOverview(state: _state),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _state.tabController,
              children: [
                HealthRoomActivityTab(state: _state),
                HealthUserEngagementTab(state: _state),
                HealthCulturalInsightsTab(state: _state),
                HealthBusinessImpactTab(state: _state),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _state.tabController,
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