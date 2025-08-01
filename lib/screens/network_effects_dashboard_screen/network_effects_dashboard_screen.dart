

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:deadhour/utils/app_theme.dart';








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