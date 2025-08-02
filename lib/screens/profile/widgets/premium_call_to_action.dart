import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/screens/profile/state/premium_role_state.dart';

class PremiumCallToAction extends StatelessWidget {
  final PremiumRoleState state;
  final VoidCallback onUpgrade;

  const PremiumCallToAction({
    super.key,
    required this.state,
    required this.onUpgrade,
  });

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
                onPressed: state.isProcessing ? null : onUpgrade,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: state.isProcessing
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        'Upgrade to Premium - ${state.pricingPlans[state.selectedPlan]!['price']}${state.pricingPlans[state.selectedPlan]!['period']}',
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