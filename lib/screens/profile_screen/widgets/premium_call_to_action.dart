import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Premium upgrade call to action section
class PremiumCallToAction extends StatelessWidget {
  final String selectedPlan;
  final bool isProcessing;
  final VoidCallback onUpgrade;

  const PremiumCallToAction({
    super.key,
    required this.selectedPlan,
    required this.isProcessing,
    required this.onUpgrade,
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
          children: [
            const Text(
              'Ready to go Premium?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              'Unlock all premium features and maximize your DeadHour experience',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacing20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isProcessing ? null : onUpgrade,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: isProcessing
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        'Upgrade to Premium - ${_pricingPlans[selectedPlan]!['price']}${_pricingPlans[selectedPlan]!['period']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            Text(
              '30-day money-back guarantee',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}