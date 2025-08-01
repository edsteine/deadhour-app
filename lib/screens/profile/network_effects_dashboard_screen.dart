import 'services/network_effects_service.dart';
import '../business/services/ramadan_business_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/app_theme.dart';
import 'widgets/network_effects_kpis_widget.dart';
import 'widgets/monthly_network_effects_widget.dart';
import 'widgets/top_network_multipliers_widget.dart';
import 'widgets/platform_health_metrics_widget.dart';
import 'widgets/optimization_opportunities_widget.dart';
import 'widgets/ramadan_optimization_widget.dart';
import 'widgets/network_dashboard_actions_widget.dart';

class NetworkEffectsDashboardScreen extends StatefulWidget {
  const NetworkEffectsDashboardScreen({super.key});

  @override
  State<NetworkEffectsDashboardScreen> createState() =>
      _NetworkEffectsDashboardScreenState();
}

class _NetworkEffectsDashboardScreenState
    extends State<NetworkEffectsDashboardScreen> {
  final NetworkEffectsService _networkService = NetworkEffectsService();
  final RamadanBusinessService _ramadanService = RamadanBusinessService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Network Effects Dashboard'),
            Text(
              'Dual-problem platform performance',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        backgroundColor: AppTheme.moroccoGreen,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh data
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Network Effects KPIs
            NetworkEffectsKPIsWidget(networkService: _networkService),
            const SizedBox(height: 24),

            // Ramadan Business Optimization (seasonal)
            if (_ramadanService.isRamadanSeason()) ...[
              RamadanOptimizationWidget(ramadanService: _ramadanService),
              const SizedBox(height: 24),
            ],

            // This Month's Network Effects
            const MonthlyNetworkEffectsWidget(),
            const SizedBox(height: 24),

            // Top Network Multipliers
            const TopNetworkMultipliersWidget(),
            const SizedBox(height: 24),

            // Platform Health Metrics
            const PlatformHealthMetricsWidget(),
            const SizedBox(height: 24),

            // Optimization Opportunities
            const OptimizationOpportunitiesWidget(),
            const SizedBox(height: 24),

            // Action buttons
            const NetworkDashboardActionsWidget(),
          ],
        ),
      ),
    );
  }
}