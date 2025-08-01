import 'package:flutter/material.dart';

import '../../../utils/theme.dart';
import '../services/network_effects_service.dart';

class NetworkEffectsKPIsWidget extends StatelessWidget {
  final NetworkEffectsService networkService;

  const NetworkEffectsKPIsWidget({
    super.key,
    required this.networkService,
  });

  @override
  Widget build(BuildContext context) {
    final kpis = networkService.getNetworkEffectsKPIs();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🎯 Network Effects KPIs:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        // Display real KPIs from NetworkEffectsService
        ...kpis.map((kpi) => Column(
          children: [
            _buildKPICard(
              '${kpi['name']}: ${kpi['value']}',
              kpi['description'],
              _getKPIIcon(kpi['name']),
              kpi['trend'] == 'increasing' ? AppTheme.moroccoGreen : AppColors.warning,
              isTarget: kpi['impact'] == 'high',
            ),
            const SizedBox(height: 12),
          ],
        )),
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

  IconData _getKPIIcon(String kpiName) {
    switch (kpiName.toLowerCase()) {
      case 'dual problem engagement':
        return Icons.people;
      case 'cross-problem conversion':
        return Icons.chat_bubble;
      case 'network growth rate':
        return Icons.trending_up;
      case 'tourism integration':
        return Icons.explore;
      case 'revenue optimization':
        return Icons.attach_money;
      default:
        return Icons.analytics;
    }
  }
}