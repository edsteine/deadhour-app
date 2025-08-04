import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/app_theme.dart';

import 'widgets/business_header.dart';
import 'widgets/overview_tab.dart';
import 'widgets/deals_tab.dart';
import 'widgets/analytics_tab.dart';
import 'widgets/settings_tab.dart';

class BusinessDashboardScreen extends StatefulWidget {
  const BusinessDashboardScreen({super.key});

  @override
  State<BusinessDashboardScreen> createState() =>
      _BusinessDashboardScreenState();
}

class _BusinessDashboardScreenState extends State<BusinessDashboardScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _tabs = [
    const Tab(text: 'Overview'),
    const Tab(text: 'Deals'),
    const Tab(text: 'Analytics'),
    const Tab(text: 'Settings'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Business info header
          const BusinessHeader(),

          // Tab bar
          TabBar(
            controller: _tabController,
            labelColor: AppTheme.moroccoGreen,
            unselectedLabelColor: AppTheme.secondaryText,
            indicatorColor: AppTheme.moroccoGreen,
            tabs: _tabs,
          ),

          // Tab views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                OverviewTab(
                  handleActivityTap: _handleActivityTap,
                  createNewDeal: _createNewDeal,
                  tabController: _tabController,
                ),
                DealsTab(
                  editDeal: _editDeal,
                  viewDealAnalytics: _viewDealAnalytics,
                ),
                const AnalyticsTab(),
                SettingsTab(
                  showPremiumUpgrade: _showPremiumUpgrade,
                  signOut: _signOut,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "businessCreateDealFAB",
        onPressed: _createNewDeal,
        backgroundColor: AppTheme.moroccoGreen,
        icon: const Icon(Icons.add),
        label: const Text('Create Deal'),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Business Dashboard',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: _showNotifications,
          icon: Stack(
            children: [
              const Icon(Icons.notifications_outlined),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: _showBusinessMenu,
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }

  void _handleActivityTap() {
    // TODO: Implement activity tap logic
  }

  void _createNewDeal() {
    context.go('/business/create-deal');
  }

  void _editDeal() {
    // TODO: Implement edit deal logic
  }

  void _viewDealAnalytics() {
    // TODO: Implement view deal analytics logic
  }

  void _showPremiumUpgrade() {
    // TODO: Implement show premium upgrade logic
  }

  void _signOut() {
    // TODO: Implement sign out logic
  }

  void _showNotifications() {
    // TODO: Implement show notifications logic
  }

  void _showBusinessMenu() {
    // TODO: Implement show business menu logic
  }
}
