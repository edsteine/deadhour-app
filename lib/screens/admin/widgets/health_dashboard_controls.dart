import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/screens/admin/state/community_health_dashboard_state.dart';

class HealthDashboardControls extends StatelessWidget {
  final CommunityHealthDashboardState state;

  const HealthDashboardControls({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Time Range Selector
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Time Range',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing4),
                DropdownButton<String>(
                  value: state.selectedTimeRange,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: '24h', child: Text('Last 24 Hours')),
                    DropdownMenuItem(value: '7d', child: Text('Last 7 Days')),
                    DropdownMenuItem(value: '30d', child: Text('Last 30 Days')),
                    DropdownMenuItem(value: '90d', child: Text('Last 3 Months')),
                  ],
                  onChanged: (value) {
                    state.selectedTimeRange = value!;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: AppTheme.spacing16),
          // City Selector
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'City',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing4),
                DropdownButton<String>(
                  value: state.selectedCity,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: 'All', child: Text('All Cities')),
                    DropdownMenuItem(value: 'Casablanca', child: Text('Casablanca')),
                    DropdownMenuItem(value: 'Marrakech', child: Text('Marrakech')),
                    DropdownMenuItem(value: 'Rabat', child: Text('Rabat')),
                    DropdownMenuItem(value: 'Fez', child: Text('Fez')),
                  ],
                  onChanged: (value) {
                    state.selectedCity = value!;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}