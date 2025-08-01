import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

/// Premium pricing plans section
class PremiumPricingSection extends StatelessWidget {
  final String selectedPlan;
  final Function(String) onPlanChanged;

  const PremiumPricingSection({
    super.key,
    required this.selectedPlan,
    required this.onPlanChanged,
  });

  static const Map<String, Map<String, dynamic>> _pricingPlans = {
    'monthly': {
      'title': 'Monthly Premium',
      'price': '€15',
      'period': '/month',
      'savings': '',
      'recommended': false,
    },
    'annual': {
      'title': 'Annual Premium',
      'price': '€150',
      'period': '/year',
      'savings': 'Save €30/year',
      'recommended': true,
    },
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Your Plan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            ...(_pricingPlans.entries.map((entry) {
              final planKey = entry.key;
              final plan = entry.value;
              final isSelected = selectedPlan == planKey;
              final isRecommended = plan['recommended'] as bool;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.spacing12),
                child: GestureDetector(
                  onTap: () => onPlanChanged(planKey),
                  child: Container(
                    padding: const EdgeInsets.all(AppTheme.spacing16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected 
                            ? Colors.amber 
                            : Colors.grey.withValues(alpha: 0.3),
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                      color: isSelected 
                          ? Colors.amber.withValues(alpha: 0.1)
                          : null,
                    ),
                    child: Row(
                      children: [
                        Radio<String>(
                          value: planKey,
                          groupValue: selectedPlan,
                          onChanged: (value) => onPlanChanged(value!),
                          activeColor: Colors.amber,
                        ),
                        const SizedBox(width: AppTheme.spacing12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    plan['title'] as String,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (isRecommended) ...[
                                    const SizedBox(width: AppTheme.spacing8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppTheme.moroccoGreen,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        'RECOMMENDED',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              if ((plan['savings'] as String).isNotEmpty)
                                Text(
                                  plan['savings'] as String,
                                  style: const TextStyle(
                                    color: AppTheme.moroccoGreen,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              plan['price'] as String,
                              style: TextStyle(
                                color: Colors.amber.shade700,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              plan['period'] as String,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })),
          ],
        ),
      ),
    );
  }
}