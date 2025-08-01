



/// Mock analytics data for business and community metrics
class AnalyticsData {
  // Mock Business Analytics Data
  static Map<String, dynamic> get businessAnalytics => {
        'todayPerformance': {
          'revenueIncrease': 23,
          'deadHourBookings': 12,
          'platformEarnings': 234,
        },
        'weeklyTraffic': [
          {'day': 'Mon', 'occupancy': 45},
          {'day': 'Tue', 'occupancy': 38},
          {'day': 'Wed', 'occupancy': 42},
          {'day': 'Thu', 'occupancy': 35},
          {'day': 'Fri', 'occupancy': 67},
          {'day': 'Sat', 'occupancy': 89},
          {'day': 'Sun', 'occupancy': 72},
        ],
        'deadHours': [
          {'time': '14:00-16:00', 'occupancy': 35, 'status': 'dead'},
          {'time': '20:00-22:00', 'occupancy': 28, 'status': 'dead'},
        ],
        'monthlyRevenue': {
          'total': 4890,
          'commission': 391,
          'netEarnings': 4499,
          'growth': 34,
        },
      };

  // Mock Community Health Data
  static Map<String, dynamic> get communityHealth => {
        'overallHealth': 'excellent',
        'totalActiveRooms': 47,
        'dailyActiveUsers': 1234,
        'crossRoomInteractions': 67,
        'averageSessionTime': 12,
        'engagementMetrics': {
          'messagesPerUser': 8.4,
          'dealShares': 12.6,
          'successfulMeetups': 89,
          'userSatisfaction': 4.7,
        },
      };

  // Business Data for logged-in business user
  static Map<String, dynamic> get businessData => {
        'venue': VenueData.venues.first,
        'activeDeals': DealData.deals.where((deal) => deal.isActive).toList(),
        'analytics': businessAnalytics,
        'monthlyStats': {
          'totalBookings': 47,
          'platformRevenue': 1240,
          'newCustomers': 23,
          'averageRating': 4.6,
        },
      };
}