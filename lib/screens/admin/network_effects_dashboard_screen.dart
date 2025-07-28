import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';

class NetworkEffectsDashboardScreen extends StatefulWidget {
  const NetworkEffectsDashboardScreen({super.key});

  @override
  State<NetworkEffectsDashboardScreen> createState() =>
      _NetworkEffectsDashboardScreenState();
}

class _NetworkEffectsDashboardScreenState
    extends State<NetworkEffectsDashboardScreen> {
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
            _buildNetworkEffectsKPIs(),
            const SizedBox(height: 24),

            // This Month's Network Effects
            _buildMonthlyNetworkEffects(),
            const SizedBox(height: 24),

            // Top Network Multipliers
            _buildTopNetworkMultipliers(),
            const SizedBox(height: 24),

            // Platform Health Metrics
            _buildPlatformHealthMetrics(),
            const SizedBox(height: 24),

            // Optimization Opportunities
            _buildOptimizationOpportunities(),
            const SizedBox(height: 24),

            // Action buttons
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkEffectsKPIs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🎯 Network Effects KPIs:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildKPICard(
          'Cross-Problem Engagement: 78%',
          'Users active in BOTH discovery AND booking (target: 70%+)',
          Icons.people,
          AppTheme.moroccoGreen,
          isTarget: true,
        ),
        const SizedBox(height: 12),
        _buildKPICard(
          'Community-Driven Bookings: 89%',
          'Bookings originating from room discussions (target: 60%+)',
          Icons.chat_bubble,
          AppTheme.moroccoGreen,
          isTarget: true,
        ),
        const SizedBox(height: 12),
        _buildKPICard(
          'Business Revenue Growth: +156%',
          'Dead hour revenue vs pre-platform (target: 100%+)',
          Icons.trending_up,
          AppTheme.moroccoGreen,
          isTarget: true,
        ),
      ],
    );
  }

  Widget _buildKPICard(
      String title, String subtitle, IconData icon, Color color,
      {bool isTarget = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                    if (isTarget)
                      const Icon(
                        Icons.check_circle,
                        color: AppTheme.moroccoGreen,
                        size: 20,
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyNetworkEffects() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🌐 This Month\'s Network Effects:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildMetricRow('Social Discovery → Booking:', '89%'),
          _buildMetricRow('Business Success → Community:', '78%'),
          _buildMetricRow('Tourist-Local Connections:', '234'),
          _buildMetricRow('Cross-Category Usage:', '67%'),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: AppTheme.secondaryText),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.moroccoGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopNetworkMultipliers() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🏆 Top Network Multipliers:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildMultiplierItem(
              '1.', '#coffee-afternoon-deals', '156 bookings', Icons.coffee),
          _buildMultiplierItem(
              '2.', '#cultural-experiences', '89 tourism€', Icons.attractions),
          _buildMultiplierItem(
              '3.', '#escape-rooms-weekend', '67 groups', Icons.games),
        ],
      ),
    );
  }

  Widget _buildMultiplierItem(
      String rank, String room, String metric, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            rank,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.moroccoGreen,
            ),
          ),
          const SizedBox(width: 8),
          Icon(icon, color: AppTheme.secondaryText, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              room,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            metric,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.moroccoGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformHealthMetrics() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📈 Platform Health Metrics:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildHealthMetric('Network Effects Score:', '8.7/10', true),
          _buildHealthMetric('Viral Growth Rate:', '1.34x', true),
          _buildHealthMetric('Cross-Problem LTV:', '247€', true),
          _buildHealthMetric('Community Health:', '4.8/5', true),
        ],
      ),
    );
  }

  Widget _buildHealthMetric(String label, String value, bool isHealthy) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: AppTheme.secondaryText),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isHealthy ? AppTheme.moroccoGreen : Colors.orange,
                ),
              ),
              const SizedBox(width: 4),
              if (isHealthy)
                const Icon(
                  Icons.check_circle,
                  color: AppTheme.moroccoGreen,
                  size: 16,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptimizationOpportunities() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.orange[700], size: 24),
              const SizedBox(width: 8),
              const Text(
                '🎯 Optimization Opportunities:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildOpportunityItem('Wellness category needs boosting'),
          _buildOpportunityItem('Family rooms underperforming'),
          _buildOpportunityItem('Tourism integration can expand'),
        ],
      ),
    );
  }

  Widget _buildOpportunityItem(String opportunity) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(Icons.circle, color: Colors.orange[600], size: 8),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              opportunity,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // Show detailed analytics
              _showDetailedAnalytics();
            },
            icon: const Icon(Icons.analytics),
            label: const Text('Detailed Analytics'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // Export data
              _exportData();
            },
            icon: const Icon(Icons.download),
            label: const Text('Export Data'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  void _showDetailedAnalytics() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detailed Analytics'),
        content: const Text(
            'This would show more detailed network effects analytics and charts.'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _exportData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Network effects data exported successfully!'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }
}
