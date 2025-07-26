import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';

class InsightsTab extends StatelessWidget {
  final Function(BuildContext) generateNewInsights;
  final Function(BuildContext, String) implementInsight;

  const InsightsTab({
    super.key,
    required this.generateNewInsights,
    required this.implementInsight,
  });

  Widget _buildInsightCard(
    IconData icon,
    String title,
    String description,
    String priority,
    Color color,
    String impact,
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        priority,
                        style: TextStyle(
                          fontSize: 12,
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  impact,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => implementInsight(context, title),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(80, 36),
                ),
                child: const Text('Implement'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Insights Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple[400]!, Colors.purple[600]!],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.psychology, color: Colors.white, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'AI Business Intelligence',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Smart insights to grow your business',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => generateNewInsights(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.purple[600],
                  ),
                  child: const Text('Generate New Insights'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Insights List
          _buildInsightCard(
            Icons.trending_up,
            'Revenue Growth Opportunity',
            'Your Tuesday afternoons show 40% less traffic than competitors. Consider launching a "Tuesday Treats" promotion to capture market share.',
            'High Impact',
            AppTheme.moroccoGreen,
            '+320 MAD/week potential',
            context,
          ),

          _buildInsightCard(
            Icons.people_outline,
            'Customer Pattern Discovery',
            'Families with children visit 60% more on weekends. Add kid-friendly menu items and play area promotions.',
            'Medium Impact',
            AppTheme.moroccoGold,
            '+180 MAD/week potential',
            context,
          ),

          _buildInsightCard(
            Icons.wb_sunny,
            'Weather Correlation',
            'Your sales increase 25% on sunny days above 22°C. Create weather-triggered outdoor seating promotions.',
            'Low Impact',
            Colors.blue,
            '+90 MAD/week potential',
            context,
          ),

          _buildInsightCard(
            Icons.event,
            'Event Optimization',
            'University exams period (next week) typically reduces student traffic by 35%. Offer "Study Break" deals to maintain revenue.',
            'Urgent',
            AppTheme.moroccoRed,
            'Prevent -200 MAD loss',
            context,
          ),
        ],
      ),
    );
  }
}
