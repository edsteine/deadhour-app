import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

/// Dashboard controls for time range and city selection
class HealthDashboardControls extends StatelessWidget {
  final String selectedTimeRange;
  final String selectedCity;
  final Function(String) onTimeRangeChanged;
  final Function(String) onCityChanged;

  const HealthDashboardControls({
    super.key,
    required this.selectedTimeRange,
    required this.selectedCity,
    required this.onTimeRangeChanged,
    required this.onCityChanged,
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
                  value: selectedTimeRange,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: '24h', child: Text('Last 24 Hours')),
                    DropdownMenuItem(value: '7d', child: Text('Last 7 Days')),
                    DropdownMenuItem(value: '30d', child: Text('Last 30 Days')),
                    DropdownMenuItem(value: '90d', child: Text('Last 3 Months')),
                  ],
                  onChanged: (value) => onTimeRangeChanged(value!),
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
                  value: selectedCity,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: 'All', child: Text('All Cities')),
                    DropdownMenuItem(value: 'Casablanca', child: Text('Casablanca')),
                    DropdownMenuItem(value: 'Marrakech', child: Text('Marrakech')),
                    DropdownMenuItem(value: 'Rabat', child: Text('Rabat')),
                    DropdownMenuItem(value: 'Fez', child: Text('Fez')),
                  ],
                  onChanged: (value) => onCityChanged(value!),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}