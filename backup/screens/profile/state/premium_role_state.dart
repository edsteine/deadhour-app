import 'package:flutter/material.dart';
import '../../../services/analytics_service.dart';
import '../../../utils/theme.dart';

/// State management for Premium Role Screen
class PremiumRoleState extends ChangeNotifier {
  final AnalyticsService _analyticsService = AnalyticsService();
  
  // Animation controllers
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;
  
  // Premium state
  bool _isPremiumUser = false;
  bool _isProcessing = false;
  String _selectedPlan = 'monthly';

  // Static data
  final Map<String, Map<String, dynamic>> pricingPlans = {
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

  final List<Map<String, dynamic>> premiumFeatures = [
    {
      'icon': Icons.flash_on,
      'title': 'Priority Booking Access',
      'description': 'Skip the queue and get first access to limited deals',
      'color': Colors.orange,
    },
    {
      'icon': Icons.analytics,
      'title': 'Advanced Analytics',
      'description': 'Detailed insights across all your active roles',
      'color': Colors.blue,
    },
    {
      'icon': Icons.support_agent,
      'title': 'Premium Support',
      'description': '24/7 priority customer support and live chat',
      'color': AppTheme.moroccoGreen,
    },
    {
      'icon': Icons.star,
      'title': 'Exclusive Deals',
      'description': 'Access to premium-only deals and experiences',
      'color': Colors.amber,
    },
    {
      'icon': Icons.people_alt,
      'title': 'Multi-Role Optimization',
      'description': 'Smart suggestions for role combinations and savings',
      'color': Colors.purple,
    },
    {
      'icon': Icons.rocket_launch,
      'title': 'Early Access',
      'description': 'Beta features and new releases before everyone else',
      'color': Colors.red,
    },
    {
      'icon': Icons.verified,
      'title': 'Verified Badge',
      'description': 'Stand out with premium verification badge',
      'color': Colors.blue,
    },
    {
      'icon': Icons.trending_up,
      'title': 'Revenue Boost',
      'description': 'Enhanced promotion for business and guide roles',
      'color': AppTheme.moroccoGreen,
    },
  ];

  final List<Map<String, String>> testimonials = [
    {
      'name': 'Sarah, Business Owner',
      'text': 'Premium analytics helped me optimize my dead hours strategy. Revenue up 40%!',
      'avatar': 'person',
    },
    {
      'name': 'Ahmed, Local Guide',
      'text': 'Priority booking access and exclusive deals make premium worth every euro.',
      'avatar': 'person_outline',
    },
  ];

  final List<List<String>> comparisonData = [
    ['Basic booking access', 'check', 'check'],
    ['Community rooms', 'check', 'check'],
    ['Deal notifications', 'check', 'check'],
    ['Priority booking', 'close', 'check'],
    ['Advanced analytics', 'close', 'check'],
    ['Premium support', 'close', 'check'],
    ['Exclusive deals', 'close', 'check'],
    ['Multi-role optimization', 'close', 'check'],
  ];

  // Getters
  bool get isPremiumUser => _isPremiumUser;
  bool get isProcessing => _isProcessing;
  String get selectedPlan => _selectedPlan;

  // Setters
  set isPremiumUser(bool value) {
    _isPremiumUser = value;
    notifyListeners();
  }

  set isProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  set selectedPlan(String value) {
    _selectedPlan = value;
    notifyListeners();
  }

  // Initialize animations
  void initializeAnimations(TickerProvider vsync) {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: vsync,
    );
    scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.elasticOut),
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
    animationController.forward();
  }

  // Handle upgrade process
  Future<void> handleUpgrade() async {
    isProcessing = true;

    _analyticsService.trackRoleUsage(
      'premium_upgrade_started',
      activeRoles: ['consumer'], // Mock data
      switchedToRole: 'premium',
      properties: {
        'selected_plan': selectedPlan,
        'price': pricingPlans[selectedPlan]!['price'],
      },
    );

    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 3));

    isPremiumUser = true;
    isProcessing = false;

    _analyticsService.trackRoleUsage(
      'premium_upgrade_completed',
      activeRoles: ['consumer', 'premium'],
      switchedToRole: 'premium',
    );
  }

  // Handle subscription cancellation
  void handleCancellation() {
    isPremiumUser = false;
    
    _analyticsService.trackRoleUsage(
      'premium_cancelled',
      activeRoles: ['consumer'],
      switchedFromRole: 'premium',
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}