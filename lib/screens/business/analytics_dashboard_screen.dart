import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/widgets/common/enhanced_app_bar.dart';
import 'package:deadhour/screens/business/widgets/analytics_period_selector.dart';
import 'package:deadhour/screens/business/widgets/analytics_revenue_tab.dart';
import 'package:deadhour/screens/business/widgets/analytics_customer_tab.dart';
import 'package:deadhour/screens/business/widgets/analytics_performance_tab.dart';

class AnalyticsDashboardScreen extends StatefulWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  State<AnalyticsDashboardScreen> createState() =>
      _AnalyticsDashboardScreenState();
}

class _AnalyticsDashboardScreenState extends State<AnalyticsDashboardScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPeriod = 'week';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: const EnhancedAppBar(
        title: 'Business Analytics',
        subtitle: 'Deep insights into your performance',
        showBackButton: true,
        showGradient: true,
      ),
      body: Column(
        children: [
          AnalyticsPeriodSelector(
            selectedPeriod: _selectedPeriod,
            onPeriodChanged: (period) {
              setState(() {
                _selectedPeriod = period;
              });
            },
          ),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                AnalyticsRevenueTab(selectedPeriod: _selectedPeriod),
                const AnalyticsCustomerTab(),
                const AnalyticsPerformanceTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: AppTheme.moroccoGreen,
        unselectedLabelColor: Colors.grey.shade600,
        indicatorColor: AppTheme.moroccoGreen,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        tabs: const [
          Tab(text: 'Revenue'),
          Tab(text: 'Customers'),
          Tab(text: 'Performance'),
        ],
      ),
    );
  }
}