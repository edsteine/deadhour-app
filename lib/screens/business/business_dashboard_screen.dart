import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:deadhour/utils/theme.dart';

import 'package:deadhour/screens/business/widgets/business_header.dart';
import 'package:deadhour/screens/business/widgets/overview_tab.dart';
import 'package:deadhour/screens/business/widgets/deals_tab.dart';
import 'package:deadhour/screens/business/widgets/analytics_tab.dart';
import 'package:deadhour/screens/business/widgets/settings_tab.dart';
import 'package:deadhour/screens/business/widgets/business_dashboard_app_bar.dart';
import 'package:deadhour/screens/business/modals/business_activity_modal.dart';
import 'package:deadhour/screens/business/modals/business_analytics_modal.dart';
import 'package:deadhour/screens/business/modals/business_premium_upgrade_modal.dart';
import 'package:deadhour/screens/business/widgets/business_edit_deal_dialog.dart';
import 'package:deadhour/screens/business/widgets/business_sign_out_dialog.dart';

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
      appBar: const BusinessDashboardAppBar(),
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
        heroTag: 'businessCreateDealFAB',
        onPressed: _createNewDeal,
        backgroundColor: AppTheme.moroccoGreen,
        icon: const Icon(Icons.add),
        label: const Text('Create Deal'),
      ),
    );
  }

  void _handleActivityTap() {
    BusinessActivityModal.show(context);
  }

  void _createNewDeal() {
    context.go('/business/create-deal');
  }

  void _editDeal() {
    BusinessEditDealDialog.show(context);
  }

  void _viewDealAnalytics() {
    BusinessAnalyticsModal.show(context);
  }

  void _showPremiumUpgrade() {
    BusinessPremiumUpgradeModal.show(context);
  }

  void _signOut() {
    BusinessSignOutDialog.show(context);
  }
}