import 'package:flutter/material.dart';

class OptimizationOpportunitiesWidget extends StatelessWidget {
  const OptimizationOpportunitiesWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
}