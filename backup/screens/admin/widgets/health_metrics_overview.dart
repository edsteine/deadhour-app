import 'package:flutter/material.dart';
import '../../../utils/theme.dart';
import '../state/community_health_dashboard_state.dart';

class HealthMetricsOverview extends StatelessWidget {
  final CommunityHealthDashboardState state;

  const HealthMetricsOverview({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final metrics = state.getOverviewMetrics();
    
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Row(
        children: [
          Expanded(child: _buildMetricCard(
            'Active Rooms', 
            metrics['activeRooms'].toString(),
            Icons.forum,
            Colors.blue,
            '+12% vs last period',
          )),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(child: _buildMetricCard(
            'Daily Messages', 
            metrics['dailyMessages'].toString(),
            Icons.message,
            AppTheme.moroccoGreen,
            '+8% vs last period',
          )),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(child: _buildMetricCard(
            'Active Users', 
            metrics['activeUsers'].toString(),
            Icons.people,
            Colors.orange,
            '+15% vs last period',
          )),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(child: _buildMetricCard(
            'Conversion Rate', 
            '${metrics['conversionRate']}%',
            Icons.trending_up,
            Colors.purple,
            '+3% vs last period',
          )),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String trend) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const Spacer(),
              const Icon(Icons.trending_up, color: Colors.green, size: 16),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: AppTheme.spacing4),
          Text(
            trend,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}