

import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';








class PremiumRoleScreen extends StatefulWidget {
  const PremiumRoleScreen({super.key});

  @override
  State<PremiumRoleScreen> createState() => _PremiumRoleScreenState();
}

class _PremiumRoleScreenState extends State<PremiumRoleScreen>
    with TickerProviderStateMixin {
  final _analyticsService = AnalyticsService();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  
  bool _isPremiumUser = false;
  bool _isProcessing = false;
  String _selectedPlan = 'monthly';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeadHourAppBar(
        title: 'Premium Role',
        subtitle: 'Unlock advanced features',
        showBackButton: true,
        customActions: [
          if (_isPremiumUser)
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
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PremiumHeroSection(
                scaleAnimation: _scaleAnimation,
                isPremiumUser: _isPremiumUser,
              ),
              const SizedBox(height: AppTheme.spacing32),
              if (!_isPremiumUser) ...[
                PremiumPricingSection(
                  selectedPlan: _selectedPlan,
                  onPlanChanged: (plan) => setState(() => _selectedPlan = plan),
                ),
                const SizedBox(height: AppTheme.spacing32),
              ],
              const PremiumFeaturesSection(),
              const SizedBox(height: AppTheme.spacing32),
              const PremiumComparisonSection(),
              const SizedBox(height: AppTheme.spacing32),
              const PremiumTestimonialsSection(),
              const SizedBox(height: AppTheme.spacing32),
              if (_isPremiumUser) 
                PremiumManagementSection(
                  onBillingDetails: _showBillingDetails,
                  onCancel: _showCancelDialog,
                )
              else
                PremiumCallToAction(
                  selectedPlan: _selectedPlan,
                  isProcessing: _isProcessing,
                  onUpgrade: _handleUpgradeClick,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleUpgradeClick() async {
    setState(() {
      _isProcessing = true;
    });

    _analyticsService.trackRoleUsage(
      'premium_upgrade_started',
      activeRoles: ['consumer'], // Mock data
      switchedToRole: 'premium',
      properties: {
        'selected_plan': _selectedPlan,
      },
    );

    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isPremiumUser = true;
      _isProcessing = false;
    });

    _analyticsService.trackRoleUsage(
      'premium_upgrade_completed',
      activeRoles: ['consumer', 'premium'],
      switchedToRole: 'premium',
    );

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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Billing Details'),
        content: const Text(
          'Next billing: March 15, 2024\n'
          'Amount: €15.00\n'
          'Payment method: **** 1234\n'
          'Billing address: Casablanca, Morocco',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Would navigate to billing management
            },
            child: const Text('Manage'),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Premium'),
        content: const Text(
          'Are you sure you want to cancel your Premium subscription? You\'ll lose access to all premium features at the end of your current billing period.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Keep Premium'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _handleCancelSubscription();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Cancel Subscription'),
          ),
        ],
      ),
    );
  }

  void _handleCancelSubscription() {
    setState(() {
      _isPremiumUser = false;
    });
    
    _analyticsService.trackRoleUsage(
      'premium_cancelled',
      activeRoles: ['consumer'],
      switchedFromRole: 'premium',
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Premium subscription cancelled. You\'ll retain access until March 15, 2024.'),
      ),
    );
  }
}