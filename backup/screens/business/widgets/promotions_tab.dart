import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

class PromotionsTab extends StatelessWidget {
  final Function(BuildContext) enableAutomatedPromotions;
  final Function(String, bool) togglePromotion;
  final Function(BuildContext, String) createFromTemplate;

  const PromotionsTab({
    super.key,
    required this.enableAutomatedPromotions,
    required this.togglePromotion,
    required this.createFromTemplate,
  });

  Widget _buildPromotionCard(
    String title,
    String description,
    String status,
    String performance,
    Color color,
    bool isActive,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Switch(
                value: isActive,
                onChanged: (value) => togglePromotion(title, value),
                activeColor: AppTheme.moroccoGreen,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Text(
                performance,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionTemplate(
      String emoji, String title, String description, BuildContext context) {
    return GestureDetector(
      onTap: () => createFromTemplate(context, title),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
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
          // Automated Promotions
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.moroccoGold, Colors.orange],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.white, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Automated Promotions',
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
                  'AI creates and launches deals automatically',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => enableAutomatedPromotions(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppTheme.moroccoGold,
                        ),
                        child: const Text('Enable Auto-Promotions'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Active Promotions
          const Text(
            'Active Promotions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildPromotionCard(
            'Happy Hour Special',
            '30% off all drinks 14:00-16:00',
            'Active until 16:00',
            '12 bookings today',
            AppTheme.moroccoGreen,
            true,
            context,
          ),

          _buildPromotionCard(
            'Rainy Day Deal',
            '25% off when weather < 18°C',
            'Weather-triggered',
            '8 bookings today',
            AppTheme.moroccoGold,
            true,
            context,
          ),

          _buildPromotionCard(
            'Late Night Bites',
            'Buy 2 get 1 free after 21:00',
            'Scheduled for tonight',
            'Ready to launch',
            Colors.grey,
            false,
            context,
          ),

          const SizedBox(height: 24),

          // Promotion Templates
          const Text(
            'Quick Promotion Templates',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildPromotionTemplate(
                '⏰',
                'Dead Hour\nSpecial',
                'Auto-discount during low occupancy',
                context,
              ),
              _buildPromotionTemplate(
                '🌧️',
                'Weather\nDeal',
                'Rain or cold weather promotion',
                context,
              ),
              _buildPromotionTemplate(
                '👥',
                'Group\nDiscount',
                'Encourage larger party bookings',
                context,
              ),
              _buildPromotionTemplate(
                '🎉',
                'Event\nBooster',
                'Capitalize on nearby events',
                context,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
