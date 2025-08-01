




/// Mock user data demonstrating multi-role system capabilities
class UserData {
  static List<DeadHourUser> get users => [
        DeadHourUser(
          id: '1',
          name: 'Ahmed Benali - Multi-Role Success',
          email: 'ahmed.benali@email.com',
          phone: '+212 661 234 567',
          activeRoles: {
            UserRole.business,
            UserRole.guide,
            UserRole.premium
          }, // €65/month revenue
          city: 'Casablanca',
          profileImageUrl: 'https://picsum.photos/150/150?random=21',
          joinDate: DateTime.now().subtract(const Duration(days: 120)),
          preferredLanguage: 'ar',
          isVerified: true,
          roleCapabilities: {
            UserRole.business: {'venueId': '1', 'monthlyRevenue': 850},
            UserRole.guide: {
              'expertiseAreas': ['Food', 'Culture'],
              'rating': 4.8
            },
            UserRole.premium: {
              'enhancedAnalytics': true,
              'prioritySupport': true
            }
          },
          crossRoleMetrics: {
            'businessGuideAmplification': 1.4,
            'totalEarnings': 65
          },
          networkEffectMultiplier: 1.4,
          favoriteCategories: ['food', 'entertainment'],
          languages: ['ar', 'fr'],
        ),
        DeadHourUser(
          id: '2',
          name: 'Sarah Johnson - Guide Role Success',
          email: 'sarah.johnson@email.com',
          phone: '+33 6 12 34 56 78',
          activeRoles: {UserRole.guide, UserRole.premium}, // €35/month revenue
          city: 'Marrakech',
          profileImageUrl: 'https://picsum.photos/150/150?random=22',
          joinDate: DateTime.now().subtract(const Duration(days: 3)),
          isVerified: true,
          roleCapabilities: {
            UserRole.guide: {
              'expertiseAreas': ['Tourism', 'Culture'],
              'rating': 4.9,
              'languages': ['en', 'fr']
            },
            UserRole.premium: {
              'enhancedDiscovery': true,
              'priorityBookings': true
            }
          },
          crossRoleMetrics: {'guideExpertise': 4.9, 'totalEarnings': 35},
          networkEffectMultiplier: 1.2,
          favoriteCategories: ['tourism', 'food', 'wellness'],
          languages: ['en', 'fr'],
        ),
        DeadHourUser(
          id: '3',
          name: 'Omar El Fassi - Business Role Owner',
          email: 'omar.elfassi@email.com',
          phone: '+212 662 345 678',
          activeRoles: {UserRole.business}, // €30/month revenue
          city: 'Rabat',
          profileImageUrl: 'https://picsum.photos/150/150?random=23',
          joinDate: DateTime.now().subtract(const Duration(days: 89)),
          preferredLanguage: 'ar',
          isVerified: true,
          roleCapabilities: {
            UserRole.business: {
              'venueId': '4',
              'monthlyRevenue': 720,
              'category': 'wellness'
            }
          },
          crossRoleMetrics: {'businessOptimization': 1.3, 'totalEarnings': 30},
          networkEffectMultiplier: 1.1,
          favoriteCategories: ['sports', 'entertainment', 'wellness'],
          languages: ['ar', 'fr'],
        ),
        DeadHourUser(
          id: '4',
          name: 'Fatima Alaoui - Consumer (Future Role Potential)',
          email: 'fatima.alaoui@email.com',
          phone: '+212 663 456 789',
          activeRoles: {}, // Consumer, ready for Role progression
          city: 'Casablanca',
          profileImageUrl: 'https://picsum.photos/150/150?random=24',
          joinDate: DateTime.now().subtract(const Duration(days: 15)),
          preferredLanguage: 'ar',
          roleCapabilities: {},
          crossRoleMetrics: {'discoverScore': 3.8},
          favoriteCategories: ['food', 'wellness'],
          languages: ['ar'],
        ),
      ];

  // Current User (Mock)
  static DeadHourUser get currentUser => users.first;
}