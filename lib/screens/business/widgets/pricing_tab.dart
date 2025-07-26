import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';

class PricingTab extends StatelessWidget {
  final Function(BuildContext, String) applyPricingRecommendation;

  const PricingTab({
    super.key,
    required this.applyPricingRecommendation,
  });

  Widget _buildPricingRecommendation(
    String timeSlot,
    String recommendation,
    String reason,
    Color color,
    IconData icon,
    String impact,
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timeSlot,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  recommendation,
                  style: TextStyle(
                    fontSize: 14,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  reason,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                impact,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              ElevatedButton(
                onPressed: () => applyPricingRecommendation(context, timeSlot),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(80, 32),
                ),
                child: const Text('Apply', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompetitorRow(String name, String price, bool isYours) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (isYours)
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppTheme.moroccoGreen,
                shape: BoxShape.circle,
              ),
            )
          else
            const SizedBox(width: 6),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isYours ? FontWeight.bold : FontWeight.normal,
                color: isYours ? AppTheme.moroccoGreen : Colors.black,
              ),
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isYours ? AppTheme.moroccoGreen : Colors.black,
            ),
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
          // Dynamic Pricing Overview
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.moroccoGreen, AppTheme.darkGreen],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.trending_up, color: Colors.white, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Smart Pricing Engine',
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
                  'AI-Powered Dynamic Pricing',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Automatically adjust prices based on demand, weather, events, and competitor analysis',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                Switch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Colors.white,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Pricing Recommendations
          const Text(
            'Pricing Recommendations',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildPricingRecommendation(
            'Lunch Rush (12:00-14:00)',
            '15% increase recommended',
            'High demand + nearby events',
            AppTheme.moroccoGreen,
            Icons.trending_up,
            '+180 MAD/day',
            context,
          ),

          _buildPricingRecommendation(
            'Afternoon Lull (14:00-16:00)',
            '25% discount recommended',
            'Low demand + weather favorable',
            AppTheme.moroccoGold,
            Icons.trending_down,
            '+95 MAD/day',
            context,
          ),

          _buildPricingRecommendation(
            'Evening Peak (19:00-21:00)',
            'Keep current pricing',
            'Optimal pricing detected',
            AppTheme.moroccoGreen,
            Icons.check_circle,
            'Optimized',
            context,
          ),

          const SizedBox(height: 24),

          // Competitor Pricing Analysis
          const Text(
            'Competitor Analysis',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: [
                _buildCompetitorRow('Your Venue', '120 MAD', true),
                const Divider(),
                _buildCompetitorRow('Café Central', '135 MAD', false),
                _buildCompetitorRow('Restaurant Atlas', '98 MAD', false),
                _buildCompetitorRow('Le Bistrot', '150 MAD', false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
