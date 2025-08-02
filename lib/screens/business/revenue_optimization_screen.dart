import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/widgets/common/enhanced_app_bar.dart';
import 'package:deadhour/screens/business/widgets/time_frame_selector.dart';
import 'package:deadhour/screens/business/widgets/business_tab_bar.dart';
import 'package:deadhour/screens/business/widgets/dead_hours_tab.dart';
import 'package:deadhour/screens/business/widgets/pricing_tab.dart';
import 'package:deadhour/screens/business/widgets/promotions_tab.dart';
import 'package:deadhour/screens/business/widgets/insights_tab.dart';
import 'package:deadhour/screens/business/utils/business_action_helpers.dart';

class RevenueOptimizationScreen extends StatefulWidget {
  const RevenueOptimizationScreen({super.key});

  @override
  State<RevenueOptimizationScreen> createState() =>
      _RevenueOptimizationScreenState();
}

class _RevenueOptimizationScreenState extends State<RevenueOptimizationScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedTimeFrame = 'week';

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
      backgroundColor: AppTheme.backgroundColor,
      appBar: const EnhancedAppBar(
        title: 'Revenue Optimization',
        subtitle: 'Maximize your off-peak hour earnings',
        showBackButton: true,
        showGradient: true,
      ),
      body: Column(
        children: [
          TimeFrameSelector(
            selectedTimeFrame: _selectedTimeFrame,
            onTimeFrameSelected: (timeFrame) {
              setState(() {
                _selectedTimeFrame = timeFrame;
              });
            },
          ),
          BusinessTabBar(tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                DeadHoursTab(
                  showOptimizationSuggestions:
                      BusinessActionHelpers.showOptimizationSuggestions,
                  createTargetedDeal: BusinessActionHelpers.createTargetedDeal,
                  optimizeTimeSlot: BusinessActionHelpers.optimizeTimeSlot,
                ),
                PricingTab(
                  applyPricingRecommendation:
                      BusinessActionHelpers.applyPricingRecommendation,
                ),
                PromotionsTab(
                  enableAutomatedPromotions:
                      BusinessActionHelpers.enableAutomatedPromotions,
                  togglePromotion: BusinessActionHelpers.togglePromotion,
                  createFromTemplate: BusinessActionHelpers.createFromTemplate,
                ),
                InsightsTab(
                  generateNewInsights:
                      BusinessActionHelpers.generateNewInsights,
                  implementInsight: BusinessActionHelpers.implementInsight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
