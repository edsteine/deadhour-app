import 'package:flutter/material.dart';
import '../../../services/analytics_service.dart';
import '../../../services/cultural_calendar_service.dart';

/// State management for Community Health Dashboard Screen
class CommunityHealthDashboardState extends ChangeNotifier {
  final AnalyticsService _analyticsService = AnalyticsService();
  final CulturalCalendarService _culturalService = CulturalCalendarService();
  
  late TabController tabController;
  String _selectedTimeRange = '7d';
  String _selectedCity = 'Casablanca';

  // Getters
  String get selectedTimeRange => _selectedTimeRange;
  String get selectedCity => _selectedCity;

  // Setters
  set selectedTimeRange(String value) {
    _selectedTimeRange = value;
    notifyListeners();
  }

  set selectedCity(String value) {
    _selectedCity = value;
    notifyListeners();
  }

  // Initialize tab controller
  void initializeTabController(TickerProvider vsync) {
    tabController = TabController(length: 4, vsync: vsync);
    
    // Track analytics for dashboard access
    _analyticsService.trackEvent('community_health_dashboard_opened', properties: {
      'time_range': selectedTimeRange,
      'city': selectedCity,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // Data methods
  Map<String, dynamic> getOverviewMetrics() {
    return {
      'activeRooms': 47,
      'dailyMessages': 2847,
      'activeUsers': 1234,
      'conversionRate': 34,
    };
  }

  List<Map<String, dynamic>> getRoomActivityData() {
    return [
      {
        'name': 'Food Lovers Casablanca',
        'category': 'Food & Dining',
        'members': 1247,
        'messages': 87,
        'icon': Icons.restaurant,
        'categoryColor': Colors.orange,
      },
      {
        'name': 'Marrakech Entertainment',
        'category': 'Entertainment',
        'members': 892,
        'messages': 64,
        'icon': Icons.movie,
        'categoryColor': Colors.purple,
      },
      {
        'name': 'Wellness Warriors',
        'category': 'Wellness',
        'members': 567,
        'messages': 43,
        'icon': Icons.spa,
        'categoryColor': Colors.green,
      },
      {
        'name': 'Cultural Explorers',
        'category': 'Tourism',
        'members': 723,
        'messages': 38,
        'icon': Icons.explore,
        'categoryColor': Colors.blue,
      },
    ];
  }

  List<Map<String, dynamic>> getTopContributors() {
    return [
      {'name': 'Fatima M.', 'messages': 247, 'helpfulVotes': 89, 'avatar': 'F'},
      {'name': 'Ahmed K.', 'messages': 198, 'helpfulVotes': 76, 'avatar': 'A'},
      {'name': 'Aicha B.', 'messages': 156, 'helpfulVotes': 54, 'avatar': 'A'},
      {'name': 'Youssef R.', 'messages': 134, 'helpfulVotes': 43, 'avatar': 'Y'},
    ];
  }

  List<Map<String, dynamic>> getDealPerformanceData() {
    return [
      {'room': '🍕 Food & Dining', 'deals': 45, 'bookings': 234, 'revenue': '€12,400'},
      {'room': '🎮 Entertainment', 'deals': 32, 'bookings': 156, 'revenue': '€8,900'},
      {'room': '💆 Wellness', 'deals': 28, 'bookings': 189, 'revenue': '€15,600'},
      {'room': '🌍 Tourism', 'deals': 22, 'bookings': 98, 'revenue': '€6,700'},
    ];
  }

  bool isRamadan() {
    return _culturalService.isRamadan();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}