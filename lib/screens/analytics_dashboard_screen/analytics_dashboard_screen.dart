
import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

// Import modular analytics widgets





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

  void _onPeriodChanged(String period) {
    setState(() {
      _selectedPeriod = period;
    });
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
          AnalyticsPeriodSelectorWidget(
            selectedPeriod: _selectedPeriod,
            onPeriodChanged: _onPeriodChanged,
          ),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                AnalyticsRevenueTabWidget(selectedPeriod: _selectedPeriod),
                AnalyticsCustomerTabWidget(selectedPeriod: _selectedPeriod),
                AnalyticsPerformanceTabWidget(selectedPeriod: _selectedPeriod),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return ColoredBox(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        indicatorColor: AppTheme.moroccoGreen,
        labelColor: AppTheme.moroccoGreen,
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(text: 'Revenue'),
          Tab(text: 'Customers'),
          Tab(text: 'Performance'),
        ],
      ),
    );
  }
}