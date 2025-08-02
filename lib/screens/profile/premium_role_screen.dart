import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/widgets/common/dead_hour_app_bar.dart';
import 'package:deadhour/screens/profile/state/premium_role_state.dart';
import 'package:deadhour/screens/profile/widgets/premium_hero_section.dart';
import 'package:deadhour/screens/profile/widgets/premium_features_section.dart';
import 'package:deadhour/screens/profile/widgets/premium_pricing_section.dart';
import 'package:deadhour/screens/profile/widgets/premium_comparison_section.dart';
import 'package:deadhour/screens/profile/widgets/premium_testimonials_section.dart';
import 'package:deadhour/screens/profile/widgets/premium_call_to_action.dart';
import 'package:deadhour/screens/profile/widgets/premium_management_section.dart';

class PremiumRoleScreen extends StatefulWidget {
  const PremiumRoleScreen({super.key});

  @override
  State<PremiumRoleScreen> createState() => _PremiumRoleScreenState();
}

class _PremiumRoleScreenState extends State<PremiumRoleScreen>
    with TickerProviderStateMixin {
  late PremiumRoleState _state;

  @override
  void initState() {
    super.initState();
    _state = PremiumRoleState();
    _state.initializeAnimations(this);
    _state.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    _state.removeListener(_onStateChanged);
    _state.dispose();
    super.dispose();
  }

  void _onStateChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeadHourAppBar(
        title: 'Premium Role',
        subtitle: 'Unlock advanced features',
        showBackButton: true,
        customActions: [
          if (_state.isPremiumUser)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 14),
                  SizedBox(width: 4),
                  Text(
                    'ACTIVE',
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: FadeTransition(
        opacity: _state.fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PremiumHeroSection(state: _state),
              const SizedBox(height: AppTheme.spacing32),
              if (!_state.isPremiumUser) ...[
                PremiumPricingSection(state: _state),
                const SizedBox(height: AppTheme.spacing32),
              ],
              PremiumFeaturesSection(state: _state),
              const SizedBox(height: AppTheme.spacing32),
              PremiumComparisonSection(state: _state),
              const SizedBox(height: AppTheme.spacing32),
              PremiumTestimonialsSection(state: _state),
              const SizedBox(height: AppTheme.spacing32),
              if (_state.isPremiumUser) 
                PremiumManagementSection(
                  onShowBillingDetails: _showBillingDetails,
                  onShowCancelDialog: _showCancelDialog,
                )
              else
                PremiumCallToAction(
                  state: _state,
                  onUpgrade: _handleUpgradeClick,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleUpgradeClick() async {
    await _state.handleUpgrade();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Welcome to Premium! You now have access to all premium features.'),
          backgroundColor: Colors.amber,
        ),
      );
    }
  }

  void _showBillingDetails() {
    PremiumManagementSection.showBillingDetailsDialog(context);
  }

  void _showCancelDialog() {
    PremiumManagementSection.showCancelDialog(context, _handleCancelSubscription);
  }

  void _handleCancelSubscription() {
    _state.handleCancellation();
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Premium subscription cancelled. You\'ll retain access until March 15, 2024.'),
      ),
    );
  }
}